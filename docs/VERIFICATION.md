# Landing Page Commercial Redesign - Verification Guide

## Quick Links
- **PR**: https://github.com/fx0628/flutterfriday/pull/6
- **Branch**: `cursor/commercial-landing-parallax-be12`
- **Asset Credits**: See [docs/landing-assets.md](landing-assets.md)

## Build Verification ✅

The PR has been tested and confirmed to build successfully:

```bash
flutter build web --release
```

**Result**: ✓ Built build/web (no errors)

## What Changed

### 1. Visual Theme Transformation
- **Before**: Light MVP design with purple/blue gradients and gray placeholder boxes
- **After**: Professional dark commercial theme (#0A0A0A background) with real stock photography

### 2. Parallax Scrolling Implementation
Parallax effect makes background images move at different speeds than foreground content:

| Section | Background Image | Parallax Rate | Effect |
|---------|------------------|---------------|---------|
| Hero | `hero-dark-phone.jpg` | 0.5x | Slowest - creates maximum depth |
| Features | `phone-product-dark.jpg` | 0.3x | Subtle background texture |
| Vendor Flow | `desk-workspace.jpg` | 0.4x | Medium parallax for engagement |

### 3. Assets Added
All images are commercially licensed (Unsplash License - free to use):

```
assets/images/
├── hero-dark-phone.jpg (195KB)      # Dark smartphone on wood
├── desk-workspace.jpg (212KB)       # Developer workspace
├── phone-product-dark.jpg (657KB)   # Premium phone shot
└── abstract-gradient.jpg (536KB)    # Dark gradient overlay
```

**Total**: ~1.6MB (optimized for web)

## How to See the Parallax Effect

### Method 1: Visual Testing
1. Navigate to the homepage
2. **Scroll slowly** down the page
3. Watch for:
   - Hero background (dark phone) moves slower than the "flutterFriday" text
   - Features section has subtle moving background
   - Vendor section workspace image creates depth on scroll

### Method 2: Code Inspection
The parallax effect is implemented in `lib/app/home_page.dart`:

```dart
// ScrollController tracks scroll position
final ScrollController _scrollController = ScrollController();
double _scrollOffset = 0.0;

// Background moves at fraction of scroll speed
final heroParallax = _scrollOffset * 0.5;

Transform.translate(
  offset: Offset(0, heroParallax),  // Moves slower than content
  child: Image.asset('assets/images/hero-dark-phone.jpg'),
)
```

### Method 3: Browser DevTools
1. Open Chrome DevTools (F12)
2. Watch the Transform matrix of background images while scrolling
3. They translate vertically at different rates than page scroll

## Performance Notes

The parallax implementation is web-optimized:
- Uses `Transform.translate` (GPU-accelerated)
- No expensive layouts on scroll
- Images are optimized JPEGs
- `setState()` only updates scroll offset value

## Content Verification

All original content is preserved:
- ✅ "開始創作" CTA routes to `/create`
- ✅ "直接找廠商" routes to `/vendor`
- ✅ "先免費體驗" badge present
- ✅ Three core features: 圖文輸入, AI 套殼, 機型預覽
- ✅ Preview disclaimer warning
- ✅ AI capability boundaries (可以做, 不可做, 暫緩開放)
- ✅ No in-app checkout notice
- ✅ Footer with copyright

## Testing Checklist

Before merging, verify:
- [ ] `flutter build web` succeeds
- [ ] Landing page loads without errors
- [ ] All 4 images load correctly
- [ ] Parallax effect is visible when scrolling
- [ ] Dark theme applied throughout
- [ ] CTAs navigate to correct routes
- [ ] Text remains readable on dark backgrounds
- [ ] No console warnings about missing assets
- [ ] Page performs smoothly on web browser

## Troubleshooting

### Images Not Loading
- Ensure `pubspec.yaml` includes `assets/images/`
- Run `flutter pub get`
- Check that images exist in `assets/images/` directory

### No Parallax Effect
- Verify scrolling is working
- Check that `ScrollController` is attached
- Test in a web browser (not Flutter DevTools inspector)

### Build Fails
- Ensure Flutter SDK is up to date
- Run `flutter clean && flutter pub get`
- Check that all imports resolve correctly

## Credits

All stock photos sourced from Unsplash (free commercial license):
- Tyler Lastovich (hero phone)
- Ilya Pavlov (workspace)
- Bagus Hernawan (product phone)
- Javier Miranda (abstract gradient)

See full credits in [docs/landing-assets.md](landing-assets.md)

---

**Ready to merge**: All requirements met ✅
