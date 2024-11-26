# 🧱 Brick Breaker

A humble recreation of the classic Brick Breaker game from BlackBerry devices, built with Flutter

![Collision Logic](https://img.shields.io/badge/Collision-Native%20Logic-blue)
![Platform](https://img.shields.io/badge/Platform-Web%20%26%20Android-green)
![Inspiration](https://img.shields.io/badge/Inspiration-BlackBerry%20Classic-purple)

## 🎮 Game Overview

Relive the retro gaming experience with this faithful recreation of the iconic Brick Breaker game. Navigate the paddle, bounce the ball, and break bricks[TODO] - just like you remember!

## ✨ Key Features

- **Native Collision Handling**: Implemented custom collision logic from scratch
- **Cross-Platform Support**: Runs smoothly on Web and Android
- **No External Game Engines**: Built without Flutter Flame, showcasing pure Flutter capabilities
- **Responsive Design**: Adapts to different screen sizes

## 🛠 Technical Highlights

### Collision Mechanics
The game features a sophisticated collision system that:
- Dynamically adjusts ball trajectory based on paddle hit location
- Implements speed clamping to prevent extreme ball movement
- Provides natural, responsive ball physics

### Game Loop
- 60 FPS game update cycle
- State management through custom `GameManager`
- Smooth ball and paddle movement

## 🚀 Getting Started

### Prerequisites
- Flutter SDK
- Android Studio or VS Code
- Web browser or Android device

### Installation
1. Clone the repository
2. Run `flutter pub get`
3. Choose your platform:
   - For Web: `flutter run -d chrome`
   - For Android: `flutter run -d android`

## 🤝 Contributing

Contributions are welcome! Feel free to submit pull requests or open issues.

## 🎈 Acknowledgments
Inspired by the legendary BlackBerry Brick Breaker game