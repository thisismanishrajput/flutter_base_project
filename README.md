# Clean Architecture Base

This is a Flutter starter project built as a reusable base architecture.
It follows clean architecture with strict `data`, `domain`, and `presentation` layering, uses `get_it` for dependency injection, and uses `dio` (without Retrofit) for API calls.

The sample feature integrated in this base is `products` (from `https://dummyjson.com/products`).

## Architecture Document

For full architecture, flow diagrams, and extension blueprint, see:

- `ARCHITECTURE.md`

## Design System Theme

A reusable theme system is provided under `lib/src/core/theme`:

- `app_colors.dart`: centralized semantic color tokens
- `app_text_styles.dart`: typography scale and style helpers (`h1`, `h2`, `h3`, `h4`, `h5`, `h6`, `bodyLg`, `bodyMd`, `bodySm`)
- `app_theme.dart`: complete light and dark `ThemeData`

Theme behavior:

- Uses `ThemeMode.system` to automatically switch between light/dark mode
- Includes app bar, card, and button theme defaults
- Typography helpers are exposed via `BuildContext` extension for consistent UI text styling

## Key Tech Stack

- State management: `flutter_bloc`
- DI: `get_it`
- Routing: `go_router`
- Networking: `dio`
- Logging: centralized logger + Dio interceptor
- Internet checks: `connectivity_plus` + `internet_connection_checker_plus`
- Architecture: `data` -> `domain` -> `presentation`

## Folder Structure

```text
lib/
  main.dart
  main_dev.dart
  main_prod.dart
  src/
    app.dart
    bootstrap.dart
    core/
      config/
        app_environment.dart
      constants/
        api_endpoints.dart
      di/
        injection_container.dart
      router/
        app_route_paths.dart
        app_router.dart
        route_placeholder_page.dart
      error/
        error_handler.dart
        exceptions.dart
        failures.dart
      network/
        dio_client.dart
        network_info.dart
      utils/
        result.dart
    features/
      products/
        data/
          datasources/
            product_remote_datasource.dart
          models/
            product_model.dart
          repositories/
            product_repository_impl.dart
        domain/
          entities/
            product.dart
          repositories/
            product_repository.dart
          usecases/
            get_products_usecase.dart
        presentation/
          bloc/
            product_bloc.dart
            product_event.dart
            product_state.dart
          pages/
            products_page.dart
          widgets/
            product_card.dart
```

## Flavor and Environment Setup (Dev/Prod)

### Flutter entry points

- `lib/main_dev.dart` -> Dev environment
- `lib/main_prod.dart` -> Prod environment
- `lib/src/core/config/app_environment.dart` stores runtime env config (`flavor`, `appName`, `baseUrl`)

### Android flavor setup

- Flavors are defined in `android/app/build.gradle.kts`:
  - `dev`: `applicationIdSuffix = ".dev"`, `versionNameSuffix = "-dev"`
  - `prod`: production package without suffix
- Flavor app names:
  - `android/app/src/dev/res/values/strings.xml`
  - `android/app/src/prod/res/values/strings.xml`

Run commands:

```bash
# Dev
flutter run --flavor dev -t lib/main_dev.dart

# Prod
flutter run --flavor prod -t lib/main_prod.dart
```

Build commands:

```bash
# Android APK/AAB
flutter build apk --flavor dev -t lib/main_dev.dart
flutter build appbundle --flavor prod -t lib/main_prod.dart
```

### iOS flavor setup

- Shared schemes added:
  - `ios/Runner.xcodeproj/xcshareddata/xcschemes/dev.xcscheme`
  - `ios/Runner.xcodeproj/xcshareddata/xcschemes/prod.xcscheme`

Run commands:

```bash
# Dev
flutter run --flavor dev -t lib/main_dev.dart

# Prod
flutter run --flavor prod -t lib/main_prod.dart
```

Build commands:

```bash
# iOS (no codesign example)
flutter build ios --flavor dev -t lib/main_dev.dart --no-codesign
flutter build ios --flavor prod -t lib/main_prod.dart --no-codesign
```

## Layer Documentation

### Domain layer (`features/*/domain`)

Purpose: pure business rules and contracts.

Contains:
- **Entities**: core business objects (`Product`)
- **Repository contracts**: interfaces used by use cases (`ProductRepository`)
- **Use cases**: single business actions (`GetProductsUsecase`)

Rules:
- No Flutter, Dio, or UI dependency
- Keep this layer framework-agnostic and highly testable

### Data layer (`features/*/data`)

Purpose: implementation of domain contracts and external integrations.

Contains:
- **Models**: JSON parsing and serialization (`ProductModel`)
- **Data sources**: API/local storage implementations (`ProductRemoteDataSource`)
- **Repository implementations**: map datasource results/exceptions to domain-friendly `Result`/`Failure`

Flow:
1. Datasource calls API through Dio
2. `DioException` is mapped to typed `AppException`
3. Repository converts exceptions into `Failure`
4. Domain/use case receives `Result<T>` only

### Presentation layer (`features/*/presentation`)

Purpose: UI and state orchestration.

Contains:
- **Bloc**:
  - `Event`: user/action intents (`FetchProducts`)
  - `State`: immutable screen state (`ProductState`)
  - `Bloc`: coordinates use case invocation and state emission (`ProductBloc`)
- **Pages/Widgets**: Flutter UI that renders from Bloc state

UI behavior:
- `loading` -> spinner
- `success` -> product list
- `failure` -> friendly message + retry action

## Error and Internet Handling

- Repository checks internet availability through `NetworkInfo` before API call.
- Data source catches `DioException` and maps it via `ErrorHandler`.
- Repository converts exceptions to typed `Failure` objects.
- UI consumes failures and shows readable messages.

## Dependency Injection

All wiring is centralized in `lib/src/core/di/injection_container.dart`:

- External: `Dio`, `Connectivity`, `InternetConnection`
- Core: `NetworkInfo`
- Feature: datasource -> repository -> use case -> bloc

## Quality Baseline

- Reactive auth-aware routing via `AuthSessionManager` + `GoRouter.refreshListenable`
- Typed error mapping for offline/server/unknown failures
- Baseline tests for error handling, auth session persistence, and product model parsing

## Token Storage and Auth Header

Shared preference wrapper:

- `lib/src/core/storage/shared_pref_service.dart`
  - `saveToken()`, `getToken()`, `clearToken()`
  - `saveAccessToken()`, `getAccessToken()`
  - `logout()`, `clearAll()`

Network auth session manager:

- `lib/src/core/network/auth_session_manager.dart`
  - `setAccessToken(token)` saves token and updates Dio auth header
  - `hydrateAccessTokenToHeader()` restores token header after app restart
  - `logout()` clears tokens and removes auth header

## Getting Started

```bash
flutter pub get
flutter run --flavor dev -t lib/main_dev.dart
```
