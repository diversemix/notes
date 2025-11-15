# Setting Up ReadTheDocs Hosting

This guide walks you through hosting your documentation on ReadTheDocs for free.

## Prerequisites

- GitHub repository with your notes project
- GitHub account
- Python 3.7+ installed locally (for testing)

## Step 1: Test Documentation Locally

Before deploying to ReadTheDocs, test that everything works locally.

### Install MkDocs

```bash
# Install MkDocs and the Material theme
pip install mkdocs mkdocs-material

# Or if using pip3
pip3 install mkdocs mkdocs-material
```

### Test the Documentation

```bash
# Navigate to your project directory
cd /home/peter/dev/notes

# Start the development server
mkdocs serve
```

You should see output like:
```
INFO    -  Building documentation...
INFO    -  Cleaning site directory
INFO    -  Documentation built in 0.52 seconds
INFO    -  [16:45:00] Watching paths for changes: 'docs', 'mkdocs.yml'
INFO    -  [16:45:00] Serving on http://127.0.0.1:8000/
```

Open your browser to `http://127.0.0.1:8000` and verify:
- All pages load correctly
- Navigation works
- Links between pages work
- Code blocks are highlighted
- Dark/light mode toggle works

### Fix Any Issues

If you see errors:
- Check `mkdocs.yml` for syntax errors
- Ensure all files in `nav:` section exist
- Verify markdown syntax in your docs

Press `Ctrl+C` to stop the server when done.

## Step 2: Push to GitHub

Make sure your repository has the latest changes:

```bash
cd /home/peter/dev/notes

# Add all the new documentation files
git add mkdocs.yml docs/ README.md

# Commit the changes
git commit -m "Add MkDocs documentation structure for ReadTheDocs"

# Push to GitHub
git push origin main
```

If you haven't set up a GitHub repository yet:

```bash
# Initialize git (if not already done)
git init

# Add files
git add .
git commit -m "Initial commit with MkDocs documentation"

# Create a repository on GitHub (via web interface)
# Then connect and push:
git remote add origin https://github.com/diversemix/notes.git
git branch -M main
git push -u origin main
```

## Step 3: Create ReadTheDocs Account

1. Go to https://readthedocs.org
2. Click **Sign Up** (or **Log In** if you have an account)
3. Choose **Sign up with GitHub** for easiest integration
4. Authorize ReadTheDocs to access your GitHub repositories

## Step 4: Import Your Project

### Option A: Automatic Import (Recommended)

1. Once logged in, click **Import a Project**
2. ReadTheDocs will show a list of your GitHub repositories
3. Find `diversemix/notes` in the list
4. Click the **+** button next to it

### Option B: Manual Import

If your repository doesn't appear:

1. Click **Import a Project** → **Import Manually**
2. Fill in the form:
   - **Name**: `notes` (or `notes-neovim`)
   - **Repository URL**: `https://github.com/diversemix/notes`
   - **Repository type**: Git
   - **Default branch**: `main`
3. Click **Next**

## Step 5: Configure Your Project

After importing, ReadTheDocs will automatically:
- Detect your `mkdocs.yml` file
- Build your documentation
- Deploy it to a URL like `https://notes.readthedocs.io`

### Check the Build

1. Go to your project dashboard on ReadTheDocs
2. Click on **Builds** in the left sidebar
3. You should see a build in progress or completed
4. If the build failed:
   - Click on the failed build
   - Read the error log
   - Fix the issue in your repository
   - Push the fix (ReadTheDocs rebuilds automatically)

### View Your Documentation

Once the build succeeds:
1. Click **View Docs** button
2. Your documentation is now live at `https://notes.readthedocs.io` (or similar)

## Step 6: Configure Advanced Settings (Optional)

### Set Default Version

1. In your project dashboard, go to **Admin** → **Advanced Settings**
2. Set **Default version**: `latest` or `stable`
3. Click **Save**

### Configure Custom Domain (Optional)

If you want a custom domain like `docs.yoursite.com`:

1. In **Admin** → **Domains**, click **Add Domain**
2. Enter your domain name
3. Follow the DNS configuration instructions
4. Click **Save**

### Add Requirements File (If Needed)

If your docs need additional Python packages, create a `requirements.txt`:

```bash
cd /home/peter/dev/notes
cat > requirements.txt << EOF
mkdocs==1.5.3
mkdocs-material==9.4.14
EOF
```

Then create `.readthedocs.yaml` in your project root:

```yaml
version: 2

mkdocs:
  configuration: mkdocs.yml

python:
  install:
    - requirements: requirements.txt
```

Commit and push:
```bash
git add requirements.txt .readthedocs.yaml
git commit -m "Add ReadTheDocs configuration"
git push
```

## Step 7: Enable Automatic Builds

By default, ReadTheDocs rebuilds on every push to your repository. Verify this:

1. Go to **Admin** → **Integrations**
2. You should see a **GitHub incoming webhook**
3. Status should be **active**

Now every time you push to GitHub, your docs will rebuild automatically.

## Step 8: Add ReadTheDocs Badge to README (Optional)

Add a badge to your README to show documentation status:

```markdown
# Notes - Neovim Note-Taking for Executive Function

[![Documentation Status](https://readthedocs.org/projects/notes/badge/?version=latest)](https://notes.readthedocs.io/en/latest/?badge=latest)

...rest of README...
```

Replace `notes` with your actual project name on ReadTheDocs.

## Testing the Full Workflow

Make a small change to test automatic rebuilds:

```bash
# Edit a doc file
echo "## Test Section" >> docs/index.md

# Commit and push
git add docs/index.md
git commit -m "Test automatic ReadTheDocs rebuild"
git push
```

Within a minute or two:
1. Check ReadTheDocs **Builds** page
2. You should see a new build triggered
3. Once complete, the change appears on your live docs

## Troubleshooting

### Build Fails with "Module not found"

**Solution**: Add a `requirements.txt` and `.readthedocs.yaml` as shown in Step 6.

### Documentation Not Updating

**Solutions**:
- Check the **Builds** page for errors
- Verify webhook is active in **Admin** → **Integrations**
- Manually trigger a build: **Builds** → **Build Version: latest**

### 404 on Documentation Pages

**Solutions**:
- Check that file names in `mkdocs.yml` match actual files
- Verify all links use correct relative paths
- Check build log for warnings

### Material Theme Not Loading

**Solution**: Add `requirements.txt` with `mkdocs-material` and `.readthedocs.yaml`

### Custom Domain Not Working

**Solutions**:
- Verify DNS CNAME record points to `readthedocs.io`
- Allow 24-48 hours for DNS propagation
- Check domain status in **Admin** → **Domains**

## Customization Tips

### Change Documentation URL

The default URL is based on your username/project. To customize:

1. Go to **Admin** → **Advanced Settings**
2. Change the **Project slug** (this changes the URL)
3. Save and rebuild

### Enable Versioning

To host multiple versions (e.g., `latest`, `v1.0`, `v2.0`):

1. Create tags in your Git repository:
   ```bash
   git tag -a v1.0 -m "Version 1.0"
   git push origin v1.0
   ```

2. In ReadTheDocs **Versions**, activate the tag
3. Users can switch versions using the version selector

### Analytics

To add Google Analytics:

1. Go to **Admin** → **Advanced Settings**
2. Enter your **Analytics code**
3. Save

## Maintenance

### Keeping Documentation Updated

Good practices:
1. Update docs in the same PR/commit as code changes
2. Test locally with `mkdocs serve` before pushing
3. Check build status after pushing
4. Review live docs periodically

### Monitoring

ReadTheDocs provides:
- Build notifications (email)
- Build status badges
- Traffic analytics (in dashboard)

Enable email notifications:
1. **Admin** → **Notifications**
2. Add your email
3. Choose notification triggers

## Resources

- **ReadTheDocs Documentation**: https://docs.readthedocs.io/
- **MkDocs Documentation**: https://www.mkdocs.org/
- **Material Theme**: https://squidfunk.github.io/mkdocs-material/
- **Your Project Dashboard**: https://readthedocs.org/projects/notes/

## Summary Checklist

- [ ] Install MkDocs locally and test with `mkdocs serve`
- [ ] Push to GitHub repository
- [ ] Create ReadTheDocs account with GitHub
- [ ] Import your repository on ReadTheDocs
- [ ] Verify first build succeeds
- [ ] Visit your live documentation
- [ ] Add badge to README (optional)
- [ ] Test automatic rebuilds
- [ ] Configure custom domain (optional)

---

Once set up, your documentation will automatically rebuild and deploy every time you push changes to GitHub!
