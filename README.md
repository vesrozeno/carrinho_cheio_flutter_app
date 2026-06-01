# 📱 Carrinho Cheio

<p align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.44.0-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-language-0175C2?logo=dart)
![BLoC](https://img.shields.io/badge/State-BLoC-purple)
![Clean Architecture](https://img.shields.io/badge/Architecture-Clean%20Architecture-brightgreen)
![GetIt](https://img.shields.io/badge/DI-GetIt-orange)
![REST API](https://img.shields.io/badge/API-REST-red)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20Windows-lightgrey)

</p>

Mobile application developed with Flutter for creating and managing shopping lists. It allows user authentication, list creation, product addition and removal, marking purchased items, and data persistence through a REST API.

**API used:**
[https://listadella.azurewebsites.net/apiListadella_desafio.yaml/swagger/index.html](https://listadella.azurewebsites.net/apiListadella_desafio.yaml/swagger/index.html)

---

# 📚 Table of Contents

- [Screenshots](#-screenshots)
- [Project Architecture](#-project-architecture)
- [Dependency Injection](#-dependency-injection)
- [Front-end Approach](#-front-end-approach)
- [API](#-api)
- [How to Run the Project](#-how-to-run-the-project)
- [Possible Improvements](#-possible-improvements)
- [Notes](#-notes)

---

# 📸 Screenshots

## Login and Home

<div style="display: flex; gap: 12px;">
  <img src="screenshots/login.png" width="150"/>
  <img src="screenshots/register.png" width="150"/>
  <img src="screenshots/empty_home.png" width="150"/>
  <img src="screenshots/create_list_dialog.png" width="150"/>
  <img src="screenshots/home.png" width="150"/>
</div>

## Lists

<div style="display: flex; gap: 12px;">
  <img src="screenshots/empty_list_detail.png" width="150"/>
  <img src="screenshots/add_product_dialog.png" width="150"/>
  <img src="screenshots/list_detail.png" width="150"/>
  <img src="screenshots/list_detail_checked.png" width="150"/>
</div>

## Dark Mode

<div style="display: flex; gap: 12px;">
  <img src="screenshots/login_dark_mode.png" width="150"/>
  <img src="screenshots/home_dark_mode.png" width="150"/>
  <img src="screenshots/list_detail_dark_mode.png" width="150"/>
</div>

---

# 🧠 Project Architecture

The project follows a **feature-first architecture combined with a simplified Clean Architecture**, separating responsibilities into layers:

- Presentation (UI + BLoC)
- Domain (Entities + Repository Contracts)
- Data (Implemented Repositories + Data Sources)
- External (API / HTTP Client)

---

## Data Flow

```
UI (Widgets)
   ↓
BLoC (State Management)
   ↓
Repository (Data Abstraction)
   ↓
Data Source (API Implementation)
   ↓
REST API
```

---

## Project Layers

### Presentation

Responsible for the user interface and user interaction layer.

Contains:

- Reusable widgets
- Pages
- BLoCs (state management)
- States and events

Responsibilities:

- User interaction
- State rendering (loading, error, success)
- Triggering events to the business layer

---

### Domain

Responsible for the application's business rules.

Contains:

- Entities (business models)
- Repository contracts (abstractions)

Responsibilities:

- Business rule definitions
- Independence from frameworks and implementations

---

### Data

Responsible for data access and manipulation.

Contains:

- Models (DTOs)
- Repository implementations
- Data sources (API calls)

Responsibilities:

- JSON ↔ Model conversion
- Communication with external APIs

---

# 🧩 Dependency Injection

The project uses **GetIt** for dependency injection.

Responsible for:

- Registering repositories, data sources, and services
- Providing globally accessible decoupled instances

Example:

```dart
final authRepository = getIt<AuthRepository>();
```

---

# 🎨 Front-end Approach

## Interface Design

The design was based on a Figma prototype, inspired by supermarket brands and using red color tones. The project also includes **dark mode**.

---

## Componentization

- Reusable components (`CustomTextField`, `CustomElevatedButton`, `Toast`, `GenericDialog`)
- Generic page base (`AuthBasePage`)
- Reduced code duplication
- Visual and behavioral standardization

---

## Visual Feedback (UX)

The application provides feedback based on the current state:

- Success → Success toast
- Error → Error toast
- Loading → Action blocking and loading indicators
- Empty State → Informative messages when no data is available

---

## State Management

- BLoC (flutter_bloc)
- Reactive states

---

# 🌐 API

REST API integration responsible for data persistence:

- User authentication
- Shopping lists
- Products

---

# 🚀 How to Run the Project

## Prerequisites

- Flutter SDK installed
- Dart configured
- Emulator or physical device
- Flutter 3.44.0

---

## Environment Setup

Create the `.env` file based on `.env.example`:

```bash
cp .env.example .env
```

Fill in the required variables (API URL, Auth URL, etc.).

---

## Run the Project

```bash
flutter pub get
flutter run
```

---

# 🖥️ Desktop Support

The project also supports running on Windows.

## Prerequisites

- Visual Studio with the Desktop Development package installed

## Run:

```bash
flutter run -d windows
```

---

# 🚧 Possible Improvements

## Authentication (Token)

- The token expires after 1 hour
- Refresh token handling and automatic expiration validation were not implemented due to the project's simple scope

---

## Connectivity

- No internet connectivity check is implemented
- Future improvements:
  - Offline detection before requests
  - Offline state indication in the UI
  - Blocking actions when offline

---

## Design / UI

- Based on a Figma prototype
- Some adaptations were made due to technical and UX decisions
- Future improvements:
  - Greater fidelity to the original design (pixel perfect)
  - State transition animations

---

# 📌 Notes

The `LogInUsuario` endpoint may return an empty `UsuarioNome` in some scenarios (e.g., only a first name without a surname).
The primary identifier used by the application is `UsuarioId`.
