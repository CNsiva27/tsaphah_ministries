# Tsaphah Ministries — Flutter App

A single-home-page Flutter app for Tsaphah Ministries, built responsive
for phone, tablet, and desktop/web.

## Structure

```
lib/
  main.dart                  App entry point, theme
  theme/app_colors.dart      Gold / navy / cream palette (matches the logo)
  utils/responsive.dart      Breakpoints + gallery column helper
  pages/home_page.dart       Assembles all sections, handles nav scroll
  widgets/
    site_header.dart         Banner: logo + menu (drawer on mobile)
    hero_section.dart        Parallax verse hero blending into Our Vision &
                              Pastor Singh Selvaraj's calling
    gallery_section.dart     Ministries / Gallery grid
    about_section.dart       Church history & branches
    contact_section.dart     Address, phone/WhatsApp, email, social icons,
                              and the site footer (copyright + tagline)
assets/images/
  logo.png                   Header/drawer logo, 1.0x variant (96x96)
  2.0x/logo.png              2.0x variant (192x192), auto-picked by Flutter
  3.0x/logo.png              3.0x variant (288x288), auto-picked by Flutter
  logo_master.png            Full-res source (not bundled) — regenerate the
                              variants above and web/icons/*.png from this
                              file if the logo changes
  pastor.jpeg
```

## Responsive behavior

- **< 600px (mobile):** hamburger menu opens an end-drawer, gallery shows 2 columns,
  pastor photo stacks above the bio text.
- **600–900px (tablet):** gallery shows 3 columns.
- **900–1200px:** gallery shows 4 columns, top nav bar appears inline.
- **> 1200px (desktop/web):** gallery shows 5 columns, content is centered and
  capped at 1180px wide so text doesn't stretch edge-to-edge.

Breakpoints live in `lib/utils/responsive.dart` if you want to tune them.

## Getting started

1. Install the [Flutter SDK](https://docs.flutter.dev/get-started/install) if you
   haven't already.
2. From this folder, fetch dependencies:
   ```
   flutter pub get
   ```
3. Run on a device/emulator, or in Chrome:
   ```
   flutter run
   flutter run -d chrome
   ```

## Things to update before publishing

- **Gallery photos:** `lib/widgets/gallery_section.dart` currently renders 15
  placeholder tiles (gradient + camera icon) with real captions. Replace the
  placeholder `Container` in `_GalleryCard` with `Image.asset(...)` once real
  photos are supplied, and add the files under `assets/images/gallery/`
  (remember to list new asset paths in `pubspec.yaml`).
- **Contact details:** `lib/widgets/contact_section.dart` has placeholder phone
  and email values — update the strings and the `tel:` / `mailto:` / `wa.me`
  links.
- **Social links:** update the four URLs in `ContactSection` (`facebook.com`,
  `youtube.com`, `instagram.com`, `wa.me/...`) to the ministry's real profiles.

## Dependencies

- `url_launcher` — opens phone/email/social links.
- `cupertino_icons` — default Flutter icon set (bundled by the template).
