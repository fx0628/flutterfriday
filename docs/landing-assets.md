# Landing Page Assets

This document tracks all assets used across the flutterFriday landing page variants.

## Landing Page Variants

- **Landing A** (`/`): Original landing page with static hero image (hero-dark-phone.jpg)
- **Landing B** (`/b`): Currently identical to Landing A (for A/B testing)
- **Landing C** (`/c`): Video hero variant with background video

## Landing C - Video Hero Assets

### Video Asset

**File:** `assets/videos/hero-c.mp4`

- **Source:** Generated synthetically using FFmpeg
- **License:** Public Domain (generated content, no copyright)
- **Resolution:** 1920×1080 (1080p)
- **Duration:** 15 seconds
- **Codec:** H.264 (MP4)
- **Size:** ~984 KB
- **Description:** Abstract gradient animation with smooth color transitions
- **Creation Method:**
  ```bash
  ffmpeg -f lavfi -i "color=c=0x1a1a2e:s=1920x1080:r=30,format=yuv420p[base];[base]geq='p(X,Y)':128+80*sin(2*PI*T/10+X/100):128+80*cos(2*PI*T/10+Y/100)" -t 15 -c:v libx264 -preset slow -crf 23 -pix_fmt yuv420p hero-c.mp4
  ```

### Poster Image

**File:** `assets/videos/hero-c-poster.webp`

- **Source:** Extracted from hero-c.mp4 at 2-second mark
- **License:** Public Domain (derived from generated content)
- **Resolution:** 1920×1080
- **Format:** WebP
- **Size:** ~14 KB
- **Purpose:** Fallback image for:
  - Users with `prefers-reduced-motion` enabled
  - Video load failures
  - Browsers with poor network connectivity

## Original Landing Assets

### Hero Images (Landing A & B)

**Files:**
- `assets/images/hero-dark-phone.jpg`
- `assets/images/phone-product-dark.jpg`
- `assets/images/desk-workspace.jpg`
- `assets/images/abstract-gradient.jpg`

**Note:** License and source information for these original images should be documented by the original creator.

## Asset Replacement Guide

To replace the video with free commercial stock video:

### Recommended Sources

1. **Pexels Videos** (https://www.pexels.com/videos/)
   - Free for commercial use
   - No attribution required
   - Search terms: "abstract tech", "creative desk", "minimal motion"

2. **Pixabay Videos** (https://pixabay.com/videos/)
   - Free for commercial use
   - No attribution required
   - Search terms: "technology", "abstract", "business"

3. **Coverr** (https://coverr.co/)
   - Free for commercial use
   - No attribution required
   - Curated collection of quality stock videos

### Requirements

- **Format:** MP4 (H.264 codec)
- **Resolution:** 1080p or 720p
- **Size:** ≤ 8-12 MB
- **Duration:** 10-20 seconds recommended
- **Content:** Creative/abstract/desk themes
- **Restrictions:** NO identifiable branded phones or Apple products

### Replacement Steps

1. Download video from one of the recommended sources
2. Optimize if needed:
   ```bash
   ffmpeg -i input.mp4 -c:v libx264 -preset slow -crf 23 -vf scale=1920:1080 -pix_fmt yuv420p -movflags +faststart hero-c.mp4
   ```
3. Extract poster frame:
   ```bash
   ffmpeg -i hero-c.mp4 -ss 00:00:02 -vframes 1 hero-c-poster.webp
   ```
4. Update this document with proper attribution:
   - Video title
   - Creator/author name
   - Source URL
   - License type
   - Download date

### Example Attribution Format

```
**File:** assets/videos/hero-c.mp4
**Title:** [Video Title]
**Creator:** [Creator Name]
**Source:** [URL to video page]
**License:** [License type, e.g., "Pexels License - Free for commercial use"]
**Downloaded:** [Date]
**Resolution:** 1920×1080
**Duration:** [X] seconds
**Size:** [X] MB
```

## Credits

All synthetic/generated content created specifically for this project is released under Public Domain (CC0).

For user-contributed or sourced assets, proper attribution must be maintained in this document.
