# ⚡ VELORA — Premium Fitness & Life Tracker

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter" />
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart" />
  <img src="https://img.shields.io/badge/GetX-4.6.6-brightgreen?style=for-the-badge&logo=flutter" alt="GetX" />
  <img src="https://img.shields.io/badge/SQLite-003B57?style=for-the-badge&logo=sqlite&logoColor=white" alt="SQLite" />
  <img src="https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white" alt="Android" />
</p>

**VELORA** is a production-grade, dark-neon styled fitness tracking application built with **Flutter**, **GetX**, and **SQLite**. It features live step sensor tracking, custom progress rings, dynamic metric analytics, offline-first persistence, animated splash, and personalized onboarding.

---

## 📱 Application Screenshots & Visual Design

![Screenshot 2026-10-13 140742.png](../../Pictures/Screenshots/Screenshot%202026-10-13%20140742.png)

---

## 🚀 Implemented Features Overview

### 1. 🚶 Real-Time Motion Step Tracking
- Integrates physical activity hardware sensors using the **`pedometer`** stream.
- Manages runtime **`ACTIVITY_RECOGNITION`** Android permissions.
- **Baseline & Reboot Delta Calculation**: Calculates real daily step counts (`currentReading - baseline`), automatically handling device reboots and sensor resets.

### 2. 💾 Offline-First SQLite Local Persistence
- Powered by **`sqflite`** database (`velora_fitness_v2.db`).
- **`daily_activity` Table**: Stores daily steps, step targets, calories, protein, sleep hours, gym workouts, readiness score, and weight.
- **`sensor_state` Table**: Saves sensor baseline states to preserve step counts across app restarts.
- **`weight_entries` Table**: Maintains historical logs for body weight entries.

### 3. 🎬 Animated Splash & One-Time Onboarding Flow
- **Splash Screen**: Animated neon ring with glow branding that checks onboarding state.
- **One-Time Onboarding**: Beautiful 3-slide carousel using **`shared_preferences`** (`UserPreferencesService`):
  - Personal profile setup (Name, Daily Step Target, Weight Target).
  - Activity permission request prompt.
  - Automatically skipped on subsequent app launches.

### 4. 🎨 Dark Neon Material 3 Design System
- **Centralized Design System**: Dedicated files for colors ([`app_colors.dart`](lib/app/core/constants/app_colors.dart)), typography ([`app_text_styles.dart`](lib/app/core/constants/app_text_styles.dart)), and localized strings ([`app_strings.dart`](lib/app/core/constants/app_strings.dart)).
- **Custom Visual Painters**:
  - `CircularProgressRing`: Neon cyan circular arc with optional burst rays.
  - `SemiCircularGauge`: Arc gauge meter for protein and calories.
  - `LineChartWidget`: Glowing cubic spline wave chart for readiness score.
  - `StepsBarChart`: Weekly bar chart with Y-axis grid, **Goal line tag**, and percentage overlays (`78%`, `102%`, `112%`).

### 5. ⚡ Fully Interactive Daily Fitness Metrics
- **🥩 Protein Logger**: Tap card to open portion log sheet (`+20g`, `+30g`, `+50g`).
- **🔥 Calories Tracker**: Dynamic formula combining base burn, live step count, and active gym sessions.
- **🌙 Sleep Logger**: Interactive sleep duration slider sheet (`3.0` – `12.0` hrs).
- **🏋️ Gym & Workouts**: Session counter (`2/4 workouts`), workout timer, and activity categories (Running, Cycling, Weights, Yoga).
- **⚖️ Weight Tracker**: Interactive slider sheet saving logs to SQLite history.
- **💪 Readiness Score**: Dynamic score (`65` – `99`) calculated from sleep quality and step ratios.
- **📅 Real Dynamic Calendar Header**: Generates real current week dates (Sun – Sat) based on device clock, highlighting **Today** automatically.

### 6. 🔄 Shimmer Skeleton Loading
- Displays dark shimmer loading placeholders ([`shimmer_card_loader.dart`](lib/app/widgets/shimmer_card_loader.dart)) while metrics initialize.

---

## 🏗️ Architecture & Project Structure

The project strictly follows **GetX Clean Architecture**:

```text
lib/
├── app/
│   ├── core/
│   │   ├── constants/
│   │   │   ├── app_colors.dart          # Centralized color definitions
│   │   │   ├── app_strings.dart         # Centralized text constants
│   │   │   └── app_text_styles.dart     # Typography styles
│   │   └── theme/
│   │       └── app_theme.dart           # ThemeData with dark mode
│   ├── data/
│   │   ├── models/
│   │   │   ├── day_model.dart           # Calendar weekday model
│   │   │   └── step_stat_model.dart     # Chart dataset model
│   │   ├── providers/
│   │   │   ├── app_database.dart        # SQLite database operations
│   │   │   └── fitness_data_provider.dart # Dynamic calendar week generator
│   │   └── services/
│   │       ├── step_tracking_service.dart # Pedometer hardware step tracking
│   │       └── user_preferences_service.dart # SharedPreferences manager
│   ├── modules/
│   │   ├── splash/                      # Splash Screen
│   │   ├── onboarding/                  # One-time Onboarding Flow
│   │   ├── main_navigation/             # 5-Tab Shell Container
│   │   ├── home/                        # Fitness Dashboard (Tab 0)
│   │   ├── achievements/                # Achievements & Badges (Tab 1)
│   │   ├── workouts/                    # Gym & Workouts Tracker (Tab 2)
│   │   ├── goals/                       # Target Preferences Editor (Tab 3)
│   │   ├── settings/                    # Profile & Hardware Controls (Tab 4)
│   │   └── steps_detail/                # Detailed Step Analytics Screen
│   ├── routes/
│   │   ├── app_pages.dart               # GetX GetPage route definitions
│   │   └── app_routes.dart              # Route name constants
│   └── widgets/                         # Reusable UI Components
│       ├── primary_button.dart          # Vibrant green pill button
│       ├── share_button.dart            # Share button with icon
│       ├── custom_icon_button.dart      # Circular back/action button
│       ├── custom_card.dart             # Standard dark card container
│       ├── circular_progress_ring.dart  # Custom ring painter
│       ├── semi_circular_gauge.dart     # Custom gauge painter
│       ├── line_chart_painter.dart      # Custom wave chart painter
│       └── shimmer_card_loader.dart     # Skeleton loading placeholders
└── main.dart                            # Entry point & service initialization
```

---

## 📦 Required Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  get: ^4.6.6                  # State management, routing, & DI
  pedometer: ^4.2.0            # Hardware motion step counter
  permission_handler: ^11.4.0   # Runtime permission handler
  sqflite: ^2.3.3+1            # Local SQLite database
  shared_preferences: ^2.3.2   # Lightweight preferences persistence
  shimmer: ^3.0.0              # Skeleton shimmer loading
  path: ^1.9.0                 # File path utilities
  intl: ^0.19.0                # Date formatting
  cupertino_icons: ^1.0.8      # iOS icons
```

---

## 🛠️ How to Run the Project

### Prerequisites
- **Flutter SDK**: `^3.13.5` or later
- **Android Studio / VS Code**
- Physical **Android Device** (Motion sensor required for live step counts)

### Setup Steps
1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-username/VELORA.git
   cd VELORA
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Ensure Android Manifest permissions** (`android/app/src/main/AndroidManifest.xml`):
   ```xml
   <uses-permission android:name="android.permission.ACTIVITY_RECOGNITION" />
   ```

4. **Run static analysis & tests**:
   ```bash
   flutter analyze
   flutter test
   ```

5. **Run the app on connected Android phone**:
   ```bash
   flutter run
   ```

---

## 📝 License & Author
Designed & Developed with ❤️ using **Flutter & GetX**.
