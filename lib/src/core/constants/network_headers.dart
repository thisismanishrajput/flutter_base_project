/// Common HTTP header keys and auth prefixes.
class NetworkHeaders {
  const NetworkHeaders._();

  /// Request body type header key.
  static const String contentType = 'Content-Type';

  /// Accepted response format header key.
  static const String accept = 'Accept';

  /// Authorization header key.
  static const String authorization = 'Authorization';

  /// Standard bearer token prefix.
  static const String bearerPrefix = 'Bearer';
}
