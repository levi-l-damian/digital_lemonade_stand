# Digital Lemonade Stand

A Flutter Material 3 playground that experiments with a lemonade stand brand system.
It wires a custom `ThemeData` to a central set of design tokens so colors, typography, and
spacing stay consistent across widgets.

## Features
- Token-driven theming defined in `lib/tokens.dart`.
- Reusable `buildTheme()` helper in `lib/theme.dart` that composes Material 3 surfaces and widgets.
- Minimal `MainApp` entry point (`lib/main.dart`) that demonstrates how the theme applies in the UI.

## Getting Started
1. Install the [Flutter SDK](https://docs.flutter.dev/get-started/install) and run `flutter doctor` to confirm your environment.
2. Fetch dependencies:
   ```bash
   flutter pub get
   ```
3. Launch the demo on an emulator or device:
   ```bash
   flutter run
   ```

## Development Tips
- Static analysis: `flutter analyze`
- Format Dart code: `dart format lib`
- Hot reload is enabled by default; keep `flutter run` active while editing for fast feedback.

## Project Layout
- `lib/main.dart` – Application entry point and sample scaffold.
- `lib/theme.dart` – Centralized Material 3 theme configuration.
- `lib/tokens.dart` – Design tokens (color palette, typography fallbacks, radii, spacing).

## Customizing the Theme
Edit the values in `lib/tokens.dart` to change the color scheme or typography. The theme helper
automatically consumes these tokens, so UI components pick up the new styles without
additional wiring.

## Troubleshooting
- If `flutter analyze` fails because the engine cache is out of date, rerun the command with elevated permissions so Flutter can update `/Users/levi/flutter/bin/cache`.
- Ensure emulators/simulators are running and devices are authorized before launching `flutter run`.
