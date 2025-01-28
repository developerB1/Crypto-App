# Crypto Portfolio App

A modern and intuitive cryptocurrency portfolio management app built with Flutter.

## Features

- 📊 Real-time cryptocurrency price tracking
- 💼 Portfolio management and tracking
- 📈 Interactive price charts and trends
- 💰 Buy, sell, and transfer cryptocurrencies
- 📱 Biometric authentication
- 🌙 Dark/Light theme support
- 📱 Responsive design
- 🔔 Push notifications for price alerts
- 📊 Transaction history
- 🔒 Secure wallet management

## Screenshots

[Add screenshots here]

## Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / VS Code
- Android SDK / Xcode (for iOS development)

### Installation

1. Clone the repository:

```bash
git clone https://github.com/yourusername/crypto_app.git
```

2. Navigate to the project directory:

```bash
cd crypto_app
```

3. Install dependencies:

```bash
flutter pub get
```

4. Run the app:

```bash
flutter run
```

## Architecture

The app follows a clean architecture pattern with the following structure:

```
lib/
  ├── core/           # Core functionality, constants, and utilities
  ├── features/       # Feature modules (home, market, wallet, etc.)
  ├── shared/         # Shared widgets and services
  ├── config/         # App configuration
  └── main.dart       # Entry point
```

## Dependencies

- `flutter_riverpod`: State management
- `fl_chart`: Charts and graphs
- `dio`: HTTP client
- `flutter_secure_storage`: Secure storage
- `local_auth`: Biometric authentication
- `google_fonts`: Custom fonts
- `firebase_core`: Firebase integration
- `firebase_auth`: Authentication
- `cloud_firestore`: Cloud database

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [Flutter](https://flutter.dev)
- [Material Design](https://material.io)
- [CoinGecko API](https://coingecko.com) for cryptocurrency data
