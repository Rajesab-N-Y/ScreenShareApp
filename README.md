# ScreenShareApp

ScreenShareApp is an iOS application built using SwiftUI and the 100ms SDK. This app allows users to join a video conferencing room via a push notification and initiate screen sharing with participants in the room.

## Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [Code Explanation](#code-explanation)
  - [ScreenShareAppApp.swift](#screenshareappappswift)
  - [ContentView.swift](#contentviewswift)
  - [ContentViewModel.swift](#contentviewmodelswift)
  - [HMSClient.swift](#hmsclientswift)
- [Future Enhancements](#future-enhancements)

## Features

- **Push Notification Handling:** Receives and processes a push notification containing a room code.
- **Room Join:** Automatically joins a room using the received room code.
- **Screen Sharing:** Initiates screen sharing once inside the room.

## Requirements

- macOS with Xcode 14.0 or later
- iOS 15.0 or later
- Swift 5.5 or later
- CocoaPods for dependency management

## Usage
1. Launch the App: Start the app on your iOS device.
2. Receive a Push Notification: When you receive a push notification with a room code, tap to accept and join the room.
3. Start Screen Sharing: Once you're in the room, tap the "Start Screen Sharing" button to begin sharing your screen.

## Project Structure
1. ScreenShareAppApp.swift: The app entry point and setup for notification handling.
2. ContentView.swift: The main user interface, allowing users to join a room and start screen sharing.
3. ContentViewModel.swift: The view model managing state, handling notifications, and interacting with the 100ms SDK.
4. HMSClient.swift: Encapsulates the 100ms SDK functionality, including room joining and screen sharing.

## Code Explanation
1. ScreenShareAppApp.swift
  a. This file is the main entry point of the app, where the app lifecycle is managed.
  b. AppDelegate is configured to handle push notifications, processing the room code from the notification payload and passing it to the ContentView.

2. ContentView.swift
  a. The main view of the app, displaying the room code and a button to start screen sharing.
  b. Uses @StateObject to observe the ContentViewModel for changes in the app's state.
  c. Displays an alert when a push notification is received, allowing the user to join the room.

3. ContentViewModel.swift
  a. The view model that handles the app's business logic, including joining the room and starting screen sharing.
  b. Manages the interaction between the user interface and the 100ms SDK through the HMSClient.

5. HMSClient.swift
  a. A wrapper around the 100ms SDK that simplifies joining a room and starting screen sharing.
  b. Handles obtaining an auth token, joining the room, and starting the screen broadcast using RPSystemBroadcastPickerView.

## Future Enhancements
  1. Error Handling: Implement better error handling and user feedback for scenarios like network issues or SDK errors.
  2. UI Improvements: Enhance the user interface for a more polished experience.
  3. Additional Features: Add functionalities like stopping screen sharing, muting/unmuting, or chat integration.
