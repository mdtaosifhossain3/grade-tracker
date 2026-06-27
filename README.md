# 📚 Grade Tracker App

A Flutter application that allows students to add subjects with marks, view their grades, and see a live result summary.

---

## ✨ Features

| Feature | Details |
|---|---|
| **Add Subject** | Form with validation — name cannot be empty, mark must be 0–100 |
| **Subject List** | Live list with name, mark, and grade badge; swipe left to delete |
| **Summary** | Real-time total, average mark, overall grade, and per-subject breakdown |
| **Light / Dark Theme** | Toggle in the AppBar; fully custom ThemeData, no hardcoded colors |
| **State Management** | 100% Provider — zero `setState` calls in the app |

---

## 🗂️ Project Structure

```
lib/
├── main.dart                      # Entry point — MultiProvider + MaterialApp
├── models/
│   └── subject.dart               # Subject class with private _mark and grade getter
├── providers/
│   ├── subject_provider.dart      # List<Subject> state, add/remove, average, .where()/.map()
│   └── theme_provider.dart        # isDark flag + toggleTheme
├── screens/
│   ├── home_screen.dart           # BottomNavigationBar shell + AppBar theme toggle
│   ├── add_subject_screen.dart    # Screen 1 — validated form
│   ├── subject_list_screen.dart   # Screen 2 — ListView.builder + Dismissible
│   └── summary_screen.dart        # Screen 3 — live stats
├── theme/
│   └── app_theme.dart             # Custom light + dark ThemeData
└── widgets/
    └── subject_tile.dart          # Reusable subject row widget
```

---

## 🎓 Grade Scale

| Grade | Condition |
|---|---|
| A | Mark ≥ 80 |
| B | Mark ≥ 65 |
| C | Mark ≥ 50 |
| F | Mark < 50 |

---

## 🚀 How to Run

### Prerequisites
- Flutter SDK ≥ 3.12.2
- Dart SDK ≥ 3.0

### Steps

```bash
# 1. Clone the repository
git clone https://github.com/YOUR_USERNAME/grade_tracker_app.git
cd grade_tracker_app

# 2. Install dependencies
flutter pub get

# 3. Run the app
flutter run
```

> To run on a specific device, use `flutter run -d <device-id>`.  
> List available devices with `flutter devices`.

---

## ✅ Assignment Checklist

- [x] `Subject` class has private `_mark` field and `grade` getter
- [x] `.map()` and `.where()` used in `SubjectProvider`
- [x] Form validates empty name and invalid marks (0–100)
- [x] `Dismissible` deletes subjects with swipe
- [x] Light and dark themes work; no hardcoded colors anywhere
- [x] Zero `setState` calls in screens (Provider only)
- [x] Public GitHub repo with 3+ meaningful commits and README

---

## 📦 Dependencies

| Package | Version | Purpose |
|---|---|---|
| `provider` | ^6.1.2 | State management |
| `cupertino_icons` | ^1.0.8 | iOS-style icons |
