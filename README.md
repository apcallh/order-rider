# Order Rider — Delivery Driver Command Center

Flutter app for delivery drivers with Arabic/English UI, OpenStreetMap, GPS tracking, work sessions, orders, fuel/expense calculations, analytics, themes, local Drift storage, and optional Supabase sync.

## Build locally

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

The generated `lib/data/local/database.g.dart` is intentionally produced by Drift's build runner and is not committed.

## Build APK with GitHub Actions

Push to `main`/`master`, or run **Build Order Rider APK** manually from Actions. The workflow creates the Android shell, generates Drift code, analyzes, and publishes split APK artifacts.
