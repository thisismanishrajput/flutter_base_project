/// Centralized text constants used across non-UI layers and feature flows.
///
/// Keep reusable labels/messages here to avoid scattered literals.
class AppStrings {
  const AppStrings._();

  static const String appTitleProducts = 'Products';
  static const String appTitleLogin = 'Login';
  static const String settingsTitle = 'Settings';
  static const String toggleTheme = 'Toggle theme';
  static const String logout = 'Logout';
  static const String retry = 'Retry';
  static const String noProductsFound = 'No products found.';
  static const String pageNotFound = 'Page Not Found';
  static const String routeNotFoundMessagePrefix = 'No route found for';
  static const String routeNotFoundMessageSuffix =
      'Please check your route path or redirect rules.';
  static const String settingsPlaceholderMessage =
      'Use this route as a base for app-level settings and preferences.';

  static const String requestTimeout = 'Request timed out. Please try again.';
  static const String noInternet = 'Unable to connect to the internet.';
  static const String somethingWentWrong =
      'Something went wrong. Please try again.';
  static const String requestCancelled = 'Request was cancelled.';
  static const String badRequest = 'Bad request.';
  static const String unauthorizedRequest = 'Unauthorized request.';
  static const String accessDenied = 'Access denied.';
  static const String resourceNotFound = 'Requested resource not found.';
  static const String serverError = 'Server error occurred.';
  static const String serverTemporarilyUnavailable =
      'Server is temporarily unavailable.';
  static const String unexpectedApiError = 'Unexpected API error occurred.';
  static const String unexpectedProductsError =
      'Unexpected error occurred while fetching products.';

  static const String noInternetAvailable = 'No internet connection available.';
  static const String username = 'Username';
  static const String password = 'Password';
  static const String signIn = 'Sign In';
  static const String loginFailed = 'Login failed. Please try again.';
  static const String invalidCredentials =
      'Invalid username or password. Try sample credentials.';
  static const String sampleCredentialsHint =
      'Sample: username "emilys", password "emilyspass"';
}
