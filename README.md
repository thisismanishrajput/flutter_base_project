Project Title

A brief description of your project.

Table of Contents

About

Folder Structure

How to Run

About

This project is a Flutter-based application designed with a modular structure to ensure scalability and maintainability. It includes functionalities for API integration, routing, feature-based modules, and utility services. The codebase adheres to clean architecture principles and leverages Dio for network operations and BLoC for state management.

Folder Structure

lib/
├── api_integration/
│   ├── api_constants.dart
│   ├── connectivity_service.dart
│   ├── dio_client.dart
│   ├── dio_client_x.dart
│   ├── dio_exception.dart
│   ├── network_code.dart
│   ├── network_status_code.dart
│   └── request_interceptor.dart
├── core/
│   ├── router/
│   │   ├── nav_args_model.dart
│   │   ├── route_observer.dart
│   │   ├── router.dart
│   │   ├── app.dart
│   │   └── initialize_app.dart
├── features/
│   ├── home/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │       ├── bloc/
│   │       ├── view/
│   │       └── widget/
│   ├── orders/
│   │   ├── data/
│   │   │   ├── model/
│   │   │   └── repo_impl/
│   │   ├── domain/
│   │   └── presentation/
│   └── user-onboard/
│       ├── data/
│       ├── domain/
│       └── presentation/
├── root/
│   ├── data/
│   ├── domain/
│   └── presentation/
├── services/
│   ├── session_manager/
│   │   ├── app_session_manager.dart
│   │   └── service_locator.dart
├── utility/
│   ├── common_widgets/
│   │   ├── common_widgets.dart
│   │   ├── no_data_found.dart
│   │   ├── not_found_page.dart
│   │   ├── primary_button.dart
│   │   └── toast_widget.dart
│   ├── constants/
│   │   ├── assets_constants.dart
│   │   ├── color_constants.dart
│   │   ├── string_constants.dart
│   │   └── text_styles_const.dart
│   ├── custom_progress_indicator.dart
│   ├── location_service.dart
│   └── utility_function.dart
└── main.dart

How to Run

Clone the repository:

git clone <repository-url>

Navigate to the project directory:

cd <project-folder>

Install dependencies:

flutter pub get

Run the application:
