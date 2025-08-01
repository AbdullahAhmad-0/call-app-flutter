# Kasookoo SDK Flutter App

A Flutter application implementing Kasookoo SDK functionality with Firebase Cloud Messaging for push notifications and LiveKit for WebRTC calls.

## Features

- Role-based interface (Customer/Driver)
- Call history with SharedPreferences
- Firebase push notifications for incoming calls
- LiveKit integration for WebRTC calls
- Modern gradient UI design
- GetX state management

## Setup

1. Add your `google-services.json` file to `android/app/`
2. Configure your LiveKit server URL in `lib/services/livekit_service.dart`
3. Update Firebase configuration as needed
4. Run `flutter pub get`
5. Run the app with `flutter run`

## Architecture

- **GetX**: State management and dependency injection
- **SharedPreferences**: Local storage for call history
- **Firebase**: Push notifications
- **LiveKit**: WebRTC calling functionality
- **Component-based**: Reusable UI components

## API Integration

The app integrates with Kasookoo API endpoints:
- `/api/v1/bot/sdk/get-token` - Get LiveKit access token
- `/api/v1/bot/sdk-sip/calls/make` - Make WebRTC to SIP call
- `/api/v1/bot/sdk-sip/calls/end` - End WebRTC to SIP call
