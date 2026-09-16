# GitHub Pages Setup Instructions

## ✅ What's Been Set Up

The following has been configured in PR #1:
- Flutter Web application with create flow
- GitHub Actions workflow for automatic deployment
- Proper `.gitignore` to exclude build artifacts
- Base URL configuration for GitHub Pages

## 🔧 Required: Enable GitHub Pages

**IMPORTANT:** The owner must enable GitHub Pages in repository settings for the deployment to work.

### Steps to Enable:

1. Go to the repository: https://github.com/fx0628/flutterfriday
2. Click on **Settings** tab
3. Click on **Pages** in the left sidebar
4. Under **Build and deployment**:
   - **Source:** Select **GitHub Actions** from the dropdown
5. Save the settings

That's it! Once enabled, the workflow will automatically deploy on the next push to main.

## 🎯 After Merging PR #1

1. Merge the pull request: https://github.com/fx0628/flutterfriday/pull/1
2. Enable GitHub Pages (see steps above)
3. The workflow will run automatically and deploy to Pages
4. The site will be available at: **https://fx0628.github.io/flutterfriday/**

## 🔄 How Redeployment Works

After initial setup, any push to the `main` branch will:
1. Trigger the GitHub Actions workflow
2. Build the Flutter web app with `flutter build web --base-href /flutterfriday/`
3. Deploy the built files to GitHub Pages
4. Update the live site within 2-5 minutes

## 📁 Files Created

- `.github/workflows/deploy.yml` - GitHub Actions workflow
- `pubspec.yaml` - Flutter project configuration
- `lib/main.dart` - Flutter app with create flow
- `web/index.html` - Web entry point with base href placeholder
- `web/manifest.json` - PWA manifest
- `web/icons/` - App icons (192x192 and 512x512)
- `.gitignore` - Excludes build/ directory
- `README.md` - Updated with deployment info

## 🌐 Review URL

Once deployed: **https://fx0628.github.io/flutterfriday/**

## 💡 Free Plan Notes

This setup works on the free GitHub plan because:
- ✅ The repository is **public**
- ✅ GitHub Pages is free for public repos
- ✅ No build artifacts committed (saves storage)
- ✅ GitHub Actions has generous free tier (2,000 minutes/month)

## 🔍 Base HREF Configuration

The app is configured with `--base-href /flutterfriday/` for GitHub Pages project site hosting.

**If later migrating to a user site** (https://fx0628.github.io/):
1. Edit `.github/workflows/deploy.yml`
2. Change `--base-href /flutterfriday/` to `--base-href /`
3. Commit and push

## 🚀 Future Routing

The current setup supports the planned routing structure:
- `/` - Will host landing page (to be implemented)
- `/create` - App create flow (currently deployed)

The base-href configuration and routing are already set up to support this.

## ⚠️ Visibility Note

**Public Repository:** The repository is public, so the GitHub Pages site will also be publicly accessible. This is required for free Pages hosting. If privacy is needed, consider:
- GitHub Pro plan (private repo + public Pages)
- Alternative hosting (Vercel, Netlify - also have free tiers)
