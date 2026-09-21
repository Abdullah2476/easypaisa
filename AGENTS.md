# AGENTS.md - Easypaisa Flutter App Architecture & Guidelines

This document outlines the architectural patterns, coding standards, and project structure for the Easypaisa Flutter application.

## 1. Architecture: MVVM (Model-View-ViewModel) with Provider

The codebase strictly adheres to the MVVM architectural pattern:

- **Model (`lib/models/`)**: Pure Dart data classes representing business entities (e.g., `AccountModel`, `QuickActionItem`, `ServiceItem`, `DebitCardModel`, `MiniAppItem`, `PromoBannerModel`).
- **ViewModel (`lib/viewmodels/`)**: `ChangeNotifier` classes that hold UI state and business logic. Views listen to ViewModels via `Provider` (`Consumer`, `context.watch`, `context.read`).
- **View (`lib/views/`)**: UI screens displaying data from ViewModels and dispatching user actions. Views are declarative and stateless where possible.
- **Widgets (`lib/widgets/`)**: Modular, reusable custom widgets broken down into focused components to avoid monolithic files and ensure clean maintainability.

## 2. Directory Structure

```
lib/
├── core/
│   ├── constants/
│   │   ├── app_colors.dart        # Easypaisa brand colors, gradients & hex tokens
│   │   ├── app_text_styles.dart   # Typography definitions (Outfit / Inter)
│   │   └── app_assets.dart        # Asset paths & mock network image URLs
│   └── theme/
│       └── app_theme.dart         # Global ThemeData configuration
├── models/
│   ├── account_model.dart         # User account info (name, balance, masked number)
│   ├── action_item_model.dart     # Quick actions, services, and mini-app items
│   ├── debit_card_model.dart      # Debit card details (Online vs Plastic)
│   └── promo_banner_model.dart    # Promotional banners and campaigns
├── viewmodels/
│   ├── home_viewmodel.dart        # State for home screen feeds, indicators, cards
│   └── navigation_viewmodel.dart  # State for bottom navigation tabs
├── views/
│   ├── home/
│   │   └── home_screen.dart       # Main scrollable Easypaisa home view
│   ├── cash_points/
│   ├── qr_scanner/
│   ├── promotions/
│   ├── my_account/
│   └── main_navigation_screen.dart # Shell with custom persistent bottom bar
└── widgets/
    ├── app_bar/
    │   └── digital_bank_app_bar.dart
    ├── account_card/
    │   └── account_card_widget.dart
    ├── quick_actions/
    │   ├── quick_actions_row.dart
    │   └── quick_action_card.dart
    ├── more_services/
    │   ├── more_services_section.dart
    │   └── service_tile.dart
    ├── debit_cards/
    │   ├── debit_cards_section.dart
    │   └── debit_card_item.dart
    ├── mini_apps/
    │   ├── mini_apps_section.dart
    │   └── mini_app_tile.dart
    ├── whats_new/
    │   ├── whats_new_carousel.dart
    │   └── promo_card.dart
    ├── action_banners/
    │   ├── schedule_transactions_card.dart
    │   └── customer_support_card.dart
    ├── mascot/
    │   └── ello_mascot_widget.dart
    └── navigation/
        └── easypaisa_bottom_nav.dart
```

## 3. UI & Design Fidelity Principles

- **100% Visual Fidelity**: Colors, gradients, borders, font weights, badge tags, and layouts must precisely replicate the official Easypaisa design screenshots.
- **Color Gradients**: Replicate top header pastel lime gradient (`#D6F5E3` to `#F7FCF9`), emerald account card (`#006B4B` to `#004D36`), promo card borders, and bottom QR button glow.
- **Mascot Rules**:
  - Do NOT place the yellow mascot Ello on the bottom right of the "More with easypaisa" grid (screen 1).
  - DO include the mascot in "Discover MiniApps", the header, and the "Ask Ello" support button.
- **Reusability**: Use custom widgets everywhere instead of long nested widget trees.
- **State Management**: Use `Provider` across all components for reactive state and actions.
