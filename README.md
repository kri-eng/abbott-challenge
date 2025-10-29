# Abbott Flutter Challenge

A Flutter app built with the MVVM architecture that animates a heart filling by 10% per second, allows gesture detection on the heart, maintains state across navigation and app restarts, and transitions to a Success screen upon completion.

<img width="200" alt="Screenshot_1761775564" src="https://github.com/user-attachments/assets/69f0a126-5cca-4aed-8d77-4bc6c1cd91db" />
<img width="200" alt="Screenshot_1761775572" src="https://github.com/user-attachments/assets/226f4431-a4c7-41a6-bfbc-81b43b3d5f46" />
<img width="200" alt="Screenshot_1761775579" src="https://github.com/user-attachments/assets/c3439e37-7d6f-4041-aa05-4c95ef9ede70" />
<img width="200" alt="Screenshot_1761775583" src="https://github.com/user-attachments/assets/4e4f078d-2f42-4678-aac8-f271f785759c" />

## Screens

The application contains two major screen - a heart's screen and a success screen.

### Heart Screen

The **Heart Screen** is the main interactive screen of the app.  
It contains the following key components:

- **Heart Widget:**  
  A custom-painted heart shape that dynamically fills by **10% every second** when tapped.  
  The heart fill represents progress and visually transitions from empty to full. The heart is also tapable which pauses/resumes a timer.

- **Percentage Display:**  
  Displays the current fill percentage in real-time (e.g., “70%”).

- **Next Button:**  
  Disabled during progress. It becomes **enabled** only when the heart reaches **100%**, allowing navigation to the Success Screen.

- **Clear Button:**  
  Appears when the heart is completely filled, resetting the heart and percentage back to **0%** (empty state).

- **State Persistence:**  
  The current heart progress and timer state are saved using `SharedPreferences`, ensuring that the app **retains its state** even after being closed and reopened.

### Success Screen

The **Success Screen** is the second screen of the application. It contains the following widgets.

- **Success Text**
  The success text provides a fallback message - SUCCESS!

- **Back Button**
  The success screen contains a back button which allows user to navigate back to the heart screen.

## How to Run

Follow the steps below to set up and run the project locally:

---

### 1. Clone the Repository
```bash
git clone https://github.com/kri-eng/abbott-challenge.git
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Run the App
```bash
flutter run
```
---

## Test the View Model

Run the test in order to verify logic and maintain code coverage:

---

```bash
flutter test test/ui/models/heart_view_model_test.dart
```

---
