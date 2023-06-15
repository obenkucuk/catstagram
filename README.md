# Catstagram

## Start appliaction

```bash
  flutter clean && flutter pub get && flutter gen-l10n && flutter run
```

A Catstagram project.

## Tech Stack

This project did not use any dependencies or libraries for Instagram like cubic story transitions. It was built from scratch by myself.

**Packages:** intl, isar, go_router, flutter_dotenv, get, lottie, http, video_player

**Flutter Version:** 3.7.12

**Dart:** 2.19.6

## Features

- Api calls
- Localization
- Light/dark mode toggle
- Shimmer Effect for search
- Cubic story transitions (not using any dependencies)
- Video player
- Lazy loading around app
- Custom dropdown
- Overlay search screen
- Custom bottom navigation bar
- Sliver widgets and app bar

## Notes and Explanations

- Application uses getx package for ONLY state management. (No routing, no dependency injection)
- Navigation is done with flutter's official go_router package.
- cataas.com is used for cat images.
- Post and Search screens are using lazy loading.
- Lottie package is used for some animations.

## API Reference

### Get all items

```http
   cataas.com/tags
   cataas.com/cats
```
