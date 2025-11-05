# Digital Lemonade Stand

Digital Lemonade Stand is a Flutter showcase that brings a playful lemonade brand to life
across desktop, tablet, and mobile breakpoints. It highlights how design tokens, custom
themable widgets, and Riverpod state management can be combined to ship a consistent
ordering experience.

## Highlights

- 🎨 **Design token system** – Colors, typography, spacing, and radii are centralized in
  `lib/tokens.dart` and consumed by `buildTheme()` in `lib/theme.dart`.
- 🧭 **GoRouter navigation** – A GoRouter configuration (`lib/app_router.dart`) drives the
  Home → Order flow with named routes.
- 🧺 **Riverpod state** – Providers in `lib/providers/beverage_providers.dart` coordinate the
  beverage catalog, cart quantities, and derived order summary.
- 🧋 **Responsive catalog UI** – `HomeScreen` lays out beverage cards in a responsive wrap that
  adapts from 1–4 columns while enforcing a macOS window minimum of 800×600.
- 🧾 **Checkout form** – `OrderScreen` mirrors the Figma design with a cart summary, form
  fields, and contextual button states.

## Architecture Notes

- **State management with Riverpod**  
  A collection of providers in `lib/providers/beverage_providers.dart` maintains immutable
  beverage definitions and user selections. `StateNotifier` drives mutations while derived
  providers expose the shopping cart summary. Widgets simply `watch` the pieces they need,
  keeping UI rebuilds predictable and testable.

- **Navigation with go_router**  
  GoRouter is configured in `lib/app_router.dart` with named routes defined in
  `lib/routes.dart`. Navigation from the catalog to the checkout screen uses
  `context.pushNamed`, giving deep-link support and easy route guarding if the flow grows.

## Getting Started

1. Install the [Flutter SDK](https://docs.flutter.dev/get-started/install) and verify with:
   ```bash
   flutter doctor
   ```
2. Fetch dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app on an emulator, simulator, or macOS window:
   ```bash
   flutter run
   ```

> **Note:** When running on macOS the main window cannot shrink below 800×600. This matches the
> design requirements and keeps the grid layout intact.

## Project Structure

| Path | Description |
| --- | --- |
| `lib/main.dart` | Entry point; enforces macOS min window size and wires `ProviderScope`. |
| `lib/app_router.dart` & `lib/routes.dart` | GoRouter setup with named routes. |
| `lib/providers/` | Riverpod providers, models, and state notifiers for beverages and selections. |
| `lib/screens/home_screen.dart` | Responsive beverage catalog with quantity controls. |
| `lib/screens/order_screen.dart` | Checkout form plus inline order summary. |
| `lib/widgets/` | Reusable UI elements (cards, buttons, text fields). |
| `lib/theme.dart` & `lib/tokens.dart` | Material 3 theme built from design tokens. |

## Development Tasks

- Static analysis  
  ```bash
  flutter analyze
  ```
- Format Dart code  
  ```bash
  dart format lib
  ```
- Run tests (if added in the future)  
  ```bash
  flutter test
  ```

## Customization Notes

- **Add new beverages:** Update `_beverages` in
  `lib/providers/beverage_providers.dart` with pricing and visuals. The Riverpod providers
  and UI will pick up the changes automatically.
- **Swap card imagery:** Replace the `BeverageVisual` gradients with real `Image` widgets or
  new color palettes to match branding.
- **Tweak layout breakpoints:** Adjust `_columnsForWidth` in `lib/screens/home_screen.dart`
  or modify padding tokens for different device classes.

## Troubleshooting

- If `flutter analyze` reports sandbox permission issues (engine cache updates), rerun the
  command with elevated permissions.
- When hot reloading layout tweaks, ensure `flutter run` stays active to keep stateful data
  preserved between edits.
