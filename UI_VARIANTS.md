# UI A/B Variants

This Flutter web app supports two UI variants for A/B testing:

## UI-A (Default)
**Route:** `/` (default home route)

**Design:**
- Dark commercial theme
- Full-screen dark backgrounds
- Parallax scrolling effects on home page
- Purple/cyan gradient accents
- Large hero sections with overlays

**Access:**
- Default route: https://fx0628.github.io/flutterfriday/
- All pages use dark theme by default

## UI-B (Light Variant)
**Route:** `/b` (activates light theme globally)

**Design:**
- White background (#F5F5F7)
- Near-black text (#1D1D1F)
- Single accent color for primary CTA (#0071E3)
- NO full-screen dark backgrounds
- NO parallax effects
- Generous whitespace and minimal design

**Specifications:**
- **Top bar:** Height 56px, white, shows "flutterFriday" branding, ≤1 secondary action
- **Create screen:** Large product image (≥45% viewport height), dual entry (upload image or text input)
- **Input/synth:** Large preview first, single "開始合成" button, retry on failure
- **Device/case:** Card-based horizontal scroll, soft + clear case options, device list from engineering v1.3
- **Preview:** Large case art preview, disclaimer that preview≠physical product, primary CTA "找客製廠商"
- **Vendor:** Shopee search prefill with "客製手機殼", ≤3 demo shops (external links), no in-app checkout

**Access:**
- Navigate to: https://fx0628.github.io/flutterfriday/#/b
- Or visit https://fx0628.github.io/flutterfriday/b (if base href supports it)
- Once activated, the light theme persists across all routes (home, create, preview, vendor)

## Implementation Details

The UI variant is determined by the route:
- Default routes (`/`, `/create`, `/composing`, `/preview`, `/vendor`) use UI-A (dark)
- Route `/b` activates UI-B (light) theme globally via `UIVariantProvider`
- All page components check `UIVariantProvider.isUIB(context)` to adapt their styling
- Theme switching is handled in `FlutterFridayApp` state

## For Reviewers

To test both variants:
1. **UI-A (dark):** Open the default URL
2. **UI-B (light):** Navigate to `/#/b` or `/b`
3. Verify both follow the same functional path (home → create → composing → preview → vendor)
4. Confirm UI-B has light styling, large product imagery, and no parallax effects
5. Confirm UI-A remains unchanged with dark theme and parallax

## Build Command

```bash
flutter build web --release
```

The build must succeed for both variants to be deployable.
