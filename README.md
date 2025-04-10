# 🩺 DoctorBuddy

<div align="center">
  <img src="https://img.shields.io/badge/Platform-Flutter-blue" alt="Platform">
  <img src="https://img.shields.io/badge/Language-Dart-blue" alt="Language">
  <img src="https://img.shields.io/badge/Status-Development-yellow" alt="Status">
  <img src="https://img.shields.io/badge/License-MIT-green" alt="License">
</div>

<p align="center">
  <b>A comprehensive clinic management solution for doctors and receptionists</b>
</p>

## 📋 Overview

DoctorBuddy is a Flutter-based application designed to streamline clinic management by providing separate interfaces for doctors and receptionists. The app facilitates patient management, appointment scheduling, medical note-taking, and record-keeping in a user-friendly environment.

> **⚠️ Learning Project Notice**
> 
> This project was developed as a learning exercise to practice Flutter development and UI design. Currently, only the frontend UI is implemented without backend integration or data persistence. All data shown is static and for demonstration purposes only.

## ✨ Key Features

- 🔐 **Role-Based Access**: Separate interfaces for doctors and receptionists
- 👨‍⚕️ **Doctor Dashboard**: View daily appointments and patient information
- 📝 **Digital Prescription**: Create and save digital prescriptions with drawing capabilities
- 📊 **Patient History**: Track patient visits and treatment history
- 🔍 **Patient Search**: Quickly find patient records
- 📅 **Appointment Management**: Schedule, view, and manage appointments
- 📱 **Responsive Design**: Works seamlessly on both mobile and tablet devices

## 🏗️ Architecture

DoctorBuddy follows a feature-first architecture:

```
lib/
├── core/                  # Core utilities and shared components
│   ├── theme/             # App theme and styling
│   └── responsive/        # Responsive layout utilities
├── features/              # Main feature modules
│   ├── auth/              # Authentication and role selection
│   ├── doctor/            # Doctor-specific features
│   │   ├── models/        # Data models
│   │   ├── screens/       # UI screens
│   │   └── widgets/       # Reusable UI components
│   ├── receptionist/      # Receptionist-specific features
│   │   ├── models/        # Data models
│   │   ├── screens/       # UI screens
│   │   ├── services/      # Business logic
│   │   └── widgets/       # Reusable UI components
└── main.dart              # Entry point
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (v3.5.3 or higher)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- An emulator or physical device for testing

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/doctorbuddy.git
   ```

2. Navigate to the project directory:
   ```bash
   cd doctorbuddy
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the application:
   ```bash
   flutter run
   ```

## 📱 User Flows

### Doctor Flow
1. Select "Doctor" role on the role selection screen
2. Log in with credentials
3. View dashboard with today's appointments
4. Search for patients
5. View patient details and history
6. Create digital prescriptions
7. Complete appointments

### Receptionist Flow
1. Select "Receptionist" role on the role selection screen
2. Log in with credentials
3. View today's appointment schedule
4. Add new patients
5. Schedule appointments
6. Search for patient records
7. View appointment history
8. Mark end of day

## 🛠️ Technologies Used

- **Flutter**: Cross-platform UI framework
- **Dart**: Programming language
- **Intl**: Internationalization and date formatting
- **Table Calendar**: Calendar widget for appointment scheduling
- **Flutter Drawing Board**: Digital canvas for prescriptions
- **PDF**: PDF generation for prescriptions and reports
- **Path Provider**: File system access for saving documents

## 📊 Features in Detail

### For Doctors
- **Patient Management**: View comprehensive patient information
- **Appointment Tracking**: See daily appointments and patient status
- **Digital Prescriptions**: Create detailed prescriptions with drawing tools
- **Medical History**: Access patient's previous visits and treatments

### For Receptionists
- **Patient Registration**: Add new patients to the system
- **Appointment Scheduling**: Create and manage appointments
- **Daily Records**: Maintain daily appointment records
- **Patient Search**: Find patients quickly in the database

## 🔮 Future Enhancements

- 🔄 **Backend Integration**: Connect to a real database and API
- 💾 **Data Persistence**: Store and retrieve real patient and appointment data
- 🔄 **Sync Capabilities**: Cloud synchronization for multi-device access
- 📊 **Analytics Dashboard**: Insights on patient visits and clinic performance
- 🔔 **Notifications**: Appointment reminders for staff and patients
- 💊 **Medication Tracking**: Monitor patient medication schedules
- 🌐 **Online Booking**: Patient self-service appointment booking

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Contributors

- Soham Pansare - Project Lead & Developer

---

<p align="center">
  <i>Made with ❤️ for healthcare professionals</i>
</p>
