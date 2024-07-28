# Appwrite Email Auth Flutter

A Flutter application demonstrating email-based authentication using Appwrite. This app includes functionalities for user login, registration, and logout.

## Features

- **Login**: Allows users to log in using their email and password.
- **Register**: Enables new users to create an account with an email and password.
- **Logout**: Provides the option for users to log out of their account.

## Getting Started

### Prerequisites

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Appwrite: [Install Appwrite](https://appwrite.io/docs/installation)

### Setup

1. Clone the repository:
    ```bash
    git clone https://github.com/Shubham-Zone/Appwrite_Email_Auth_Flutter.git
    cd Appwrite_Email_Auth_Flutter
    ```

2. Install dependencies:
    ```bash
    flutter pub get
    ```

3. Update Appwrite configurations:
    Open `main.dart` and update the following with your Appwrite server details:
    ```dart
    Client client = Client();
    client
        .setEndpoint('https://cloud.appwrite.io/v1') // Your Appwrite Endpoint
        .setProject('YOUR_PROJECT_ID') // Your project ID
        .setSelfSigned(status: true);
    ```

4. Run the app:
    ```bash
    flutter run
    ```

## Usage

1. **Login**:
    - Enter your email and password.
    - Tap the "Login" button.

2. **Register**:
    - Enter your name, email, and password.
    - Tap the "Register" button.

3. **Logout**:
    - Tap the "Logout" button to log out of your account.

## Contact

For any inquiries, please contact Shubham Kumar at devshubham652@gmail.com.
