-- Notes System for Neovim (Kickstart.nvim Optimized)
-- Save this as ~/.config/nvim/lua/notes.lua
-- Then add require('notes').setup() to your init.lua

local M = {}

-- Configuration
M.config = {
	notes_dir = vim.fn.expand("~/notes"),
	inbox_file = vim.fn.expand("~/notes/inbox/inbox.md"),
	wiki_dir = vim.fn.expand("~/notes/wiki"),
	daily_dir = vim.fn.expand("~/notes/daily"),
}

-- Follow [[wiki-link]] under cursor
M.follow_link = function()
	local line = vim.api.nvim_get_current_line()
	local col = vim.api.nvim_win_get_cursor(0)[2]

	-- Find [[link]] pattern around cursor
	local link_pattern = "%[%[(.-)%]%]"
	local start_pos = 1

	while start_pos do
		local s, e, link = string.find(line, link_pattern, start_pos)
		if not s then
			break
		end

		-- Check if cursor is within this link
		if col >= s - 1 and col <= e then
			local filepath

			-- Check if link contains a path (has /)
			if link:match("/") then
				-- It's a path-based link, resolve relative to notes_dir
				filepath = M.config.notes_dir .. "/" .. link .. ".md"
			else
				-- No path, assume it's in wiki root
				filepath = M.config.wiki_dir .. "/" .. link:gsub(" ", "-"):lower() .. ".md"
			end

			-- Create file if it doesn't exist using the appropriate bash function
			if vim.fn.filereadable(filepath) == 0 then
				-- Extract the name from the link (last part after /)
				local name = link:match("([^/]+)$")

				-- Determine the type based on the path
				local create_cmd
				if link:match("^areas/") then
					create_cmd = "create-area"
				elseif link:match("^projects/") then
					create_cmd = "create-project"
				else
					-- Default to wiki for simple links or wiki/* links
					create_cmd = "create-wiki"
				end

				-- Call the appropriate bash creation function
				-- NOTE: Ensure you are sourcing the notes-function.sh in your .bash_profile or .zprofile so that it loads
				local result = vim.fn.system(string.format("bash -l -c '%s \"%s\"'", create_cmd, name))
				-- Use the filepath returned by the bash script (trim whitespace)
				filepath = result:gsub("%s+$", "")
			end

			vim.cmd("edit " .. filepath)
			return
		end

		start_pos = e + 1
	end

	print("No link found under cursor")
end

-- Find backlinks to current file using Telescope
M.find_backlinks = function()
	local current_file = vim.fn.expand("%:t:r")

	require("telescope.builtin").grep_string({
		search = "[[" .. current_file .. "]]",
		search_dirs = { M.config.notes_dir },
		prompt_title = "Backlinks to " .. current_file,
	})
end

-- Search notes with Telescope (kickstart has this by default, optimized for notes)
M.find_notes = function()
	require("telescope.builtin").find_files({
		prompt_title = "Find Notes",
		cwd = M.config.notes_dir,
	})
end

-- Grep through notes (kickstart has this, we just pre-fill the directory)
M.grep_notes = function()
	require("telescope.builtin").live_grep({
		prompt_title = "Search Notes",
		cwd = M.config.notes_dir,
	})
end

-- Find notes by tag using Telescope
M.find_by_tag = function()
	local tag = vim.fn.input("Tag: #")
	if tag ~= "" then
		require("telescope.builtin").grep_string({
			search = "#" .. tag,
			search_dirs = { M.config.notes_dir },
			prompt_title = "Notes tagged #" .. tag,
		})
	end
end

-- Insert link to another note using Telescope
M.insert_link = function()
	require("telescope.builtin").find_files({
		prompt_title = "Insert Link to Note",
		cwd = M.config.notes_dir,
		attach_mappings = function(prompt_bufnr, map)
			local actions = require("telescope.actions")
			local action_state = require("telescope.actions.state")

			actions.select_default:replace(function()
				actions.close(prompt_bufnr)
				local selection = action_state.get_selected_entry()
				-- Get the full path relative to notes_dir and remove .md extension
				local relative_path = selection[1]:gsub("%.md$", "")
				-- Remove leading ./ if present
				relative_path = relative_path:gsub("^%./", "")
				-- Insert as wiki link with path
				vim.api.nvim_put({ "[[" .. relative_path .. "]]" }, "", false, true)
			end)

			return true
		end,
	})
end

-- Toggle task checkbox
M.toggle_checkbox = function()
	local line = vim.api.nvim_get_current_line()
	local row = vim.api.nvim_win_get_cursor(0)[1]

	if line:match("^%s*- %[ %]") then
		-- Mark as complete
		local new_line = line:gsub("^(%s*- )%[ %]", "%1[x]")
		vim.api.nvim_buf_set_lines(0, row - 1, row, false, { new_line })
	elseif line:match("^%s*- %[x%]") then
		-- Mark as incomplete
		local new_line = line:gsub("^(%s*- )%[x%]", "%1[ ]")
		vim.api.nvim_buf_set_lines(0, row - 1, row, false, { new_line })
	elseif line:match("^%s*- ") then
		-- Add checkbox
		local new_line = line:gsub("^(%s*- )", "%1[ ] ")
		vim.api.nvim_buf_set_lines(0, row - 1, row, false, { new_line })
	else
		print("Not on a list item")
	end
end

-- New note with template
M.new_note = function()
	local name = vim.fn.input("Note name: ")
	if name == "" then
		return
	end

	local slug = name:lower():gsub(" ", "-")
	local filepath = M.config.wiki_dir .. "/" .. slug .. ".md"

	if vim.fn.filereadable(filepath) == 1 then
		vim.cmd("edit " .. filepath)
		return
	end

	local title = name
	local date = os.date("%Y-%m-%d")
	local template = string.format(
		[[# %s

## Overview

## Details

## Related

---
Created: %s
Tags: 
]],
		title,
		date
	)

	local file = io.open(filepath, "w")
	if file then
		file:write(template)
		file:close()
	end

	vim.cmd("edit " .. filepath)
end

-- Show tasks from current note in quickfix
M.show_tasks = function()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local tasks = {}

	for i, line in ipairs(lines) do
		if line:match("^%s*- %[ %]") then
			table.insert(tasks, {
				bufnr = vim.api.nvim_get_current_buf(),
				lnum = i,
				text = line:gsub("^%s*- %[ %] ", ""),
			})
		end
	end

	if #tasks == 0 then
		print("No incomplete tasks in current note")
		return
	end

	vim.fn.setqflist({}, "r", {
		title = "Tasks in " .. vim.fn.expand("%:t"),
		items = tasks,
	})
	vim.cmd("copen")
end

-- Show all tasks across all notes using Telescope
M.show_all_tasks = function()
	require("telescope.builtin").grep_string({
		search = "^- \\[ \\]",
		search_dirs = { M.config.notes_dir },
		prompt_title = "All Incomplete Tasks",
		use_regex = true,
	})
end

-- Open inbox
M.inbox = function()
	vim.cmd("edit " .. M.config.inbox_file)
end

-- Open today's daily log (calls bash create-today to handle creation/carryover)
M.open_today = function()
	-- Call the bash create-today function which creates the file if needed
	-- and returns the filepath (without opening an editor)
	local result = vim.fn.system("bash -l -c 'create-today'")
	local filepath = result:gsub("%s+$", "") -- trim trailing whitespace/newline

	-- Open the file in the current Neovim instance
	vim.cmd("edit " .. filepath)
end

-- Open yesterday's (most recent) daily log (calls bash find-yesterday)
M.open_yesterday = function()
	-- Call the bash find-yesterday function to get the most recent daily log
	local result = vim.fn.system("bash -l -c 'find-yesterday'")
	local filepath = result:gsub("%s+$", "") -- trim trailing whitespace/newline

	if filepath == "" then
		print("No previous daily notes found")
		return
	end

	-- Open the file in the current Neovim instance
	vim.cmd("edit " .. filepath)
end

-- Setup key mappings (kickstart-friendly)
M.setup_keymaps = function()
	-- Using leader key which kickstart sets to Space
	local opts = { noremap = true, silent = true }

	-- Note operations
	vim.keymap.set("n", "<leader>nf", M.find_notes, vim.tbl_extend("force", opts, { desc = "[N]otes [F]ind" }))
	vim.keymap.set("n", "<leader>ng", M.grep_notes, vim.tbl_extend("force", opts, { desc = "[N]otes [G]rep" }))
	vim.keymap.set("n", "<leader>ni", M.inbox, vim.tbl_extend("force", opts, { desc = "[N]otes [I]nbox" }))
	vim.keymap.set("n", "<leader>nt", M.open_today, vim.tbl_extend("force", opts, { desc = "[N]otes [T]oday" }))
	vim.keymap.set("n", "<leader>ny", M.open_yesterday, vim.tbl_extend("force", opts, { desc = "[N]otes [Y]esterday" }))
	vim.keymap.set("n", "<leader>nl", M.insert_link, vim.tbl_extend("force", opts, { desc = "[N]otes [L]ink" }))
	vim.keymap.set("n", "<leader>nb", M.find_backlinks, vim.tbl_extend("force", opts, { desc = "[N]otes [B]acklinks" }))
	vim.keymap.set("n", "<leader>nn", M.new_note, vim.tbl_extend("force", opts, { desc = "[N]otes [N]ew" }))

	-- Task operations
	vim.keymap.set(
		"n",
		"<leader>nx",
		M.toggle_checkbox,
		vim.tbl_extend("force", opts, { desc = "[N]otes toggle checkbo[X]" })
	)
	vim.keymap.set(
		"n",
		"<leader>ns",
		M.show_tasks,
		vim.tbl_extend("force", opts, { desc = "[N]otes [S]how tasks (current)" })
	)
	vim.keymap.set("n", "<leader>na", M.show_all_tasks, vim.tbl_extend("force", opts, { desc = "[N]otes [A]ll tasks" }))

	-- Follow link with Enter (only in markdown files)
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "markdown",
		callback = function()
			vim.keymap.set("n", "<M-CR>", function()
				-- Try to follow a link first
				local line = vim.api.nvim_get_current_line()
				if line:match("%[%[.-%]%]") then
					M.follow_link()
				else
					-- Otherwise use default behavior (useful for other plugins)
					vim.cmd("normal! <CR>")
				end
			end, { buffer = true, desc = "Follow [[link]] or default action" })

			-- Alternative: Ctrl+] (like vim tags)
			vim.keymap.set("n", "<C-]>", M.follow_link, { buffer = true, desc = "Follow [[link]]" })
		end,
	})
end

-- Auto-commands for markdown files
M.setup_autocmds = function()
	local group = vim.api.nvim_create_augroup("NotesSystem", { clear = true })

	-- Optional: Conceal wiki links in normal mode for cleaner look
	-- Uncomment if you want this feature
	-- vim.api.nvim_create_autocmd("FileType", {
	--	 group = group,
	--	 pattern = "markdown",
	--	 callback = function()
	--		 vim.opt_local.conceallevel = 2
	--		 vim.opt_local.concealcursor = "nc"
	--	 end,
	-- })

	-- Better markdown editing settings
	vim.api.nvim_create_autocmd("FileType", {
		group = group,
		pattern = "markdown",
		callback = function()
			-- Enable spell check in markdown files
			vim.opt_local.spell = true
			vim.opt_local.spelllang = "en_gb" -- British English for UK

			-- Better wrapping for prose
			vim.opt_local.wrap = true
			vim.opt_local.linebreak = true

			-- Indent lists properly
			vim.opt_local.formatoptions:append("n")
			vim.opt_local.formatlistpat = "^\\s*\\d\\+\\.\\s\\+\\|^\\s*[-*+]\\s\\+"
		end,
	})
end

-- Initialize the notes system
M.setup = function(opts)
	opts = opts or {}
	M.config = vim.tbl_deep_extend("force", M.config, opts)

	M.setup_keymaps()
	M.setup_autocmds()

	-- Create user commands (can be called with :NotesFind, etc.)
	vim.api.nvim_create_user_command("NotesFind", M.find_notes, { desc = "Find notes with Telescope" })
	vim.api.nvim_create_user_command("NotesGrep", M.grep_notes, { desc = "Search notes with Telescope" })
	vim.api.nvim_create_user_command("NotesInbox", M.inbox, { desc = "Open the notes inbox" })
	vim.api.nvim_create_user_command("NotesTag", M.find_by_tag, { desc = "Find notes by tag" })
	vim.api.nvim_create_user_command("NotesToday", M.open_today, { desc = "Open today's daily log" })
	vim.api.nvim_create_user_command("NotesYesterday", M.open_yesterday, { desc = "Open yesterday's daily log" })
	vim.api.nvim_create_user_command("NotesNew", M.new_note, { desc = "Create new note" })
	vim.api.nvim_create_user_command("NotesBacklinks", M.find_backlinks, { desc = "Find backlinks to current note" })
	vim.api.nvim_create_user_command("NotesTasks", M.show_tasks, { desc = "Show tasks in current note" })
	vim.api.nvim_create_user_command("NotesAllTasks", M.show_all_tasks, { desc = "Show all incomplete tasks" })

	print("Notes system loaded. Use <leader>n[f/g/i/t/l/b/n/x/s/a] or :Notes* commands")
end

return M
