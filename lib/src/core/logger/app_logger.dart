import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

/// Centralized logger utility for structured app and network logs.
class AppLogger {
  const AppLogger._();

  /// Toggle to enable/disable logs globally.
  static bool enabled = kDebugMode;

  static void debug(String tag, String message, {Object? data}) {
    _log('DEBUG', tag, message, data: data);
  }

  static void info(String tag, String message, {Object? data}) {
    _log('INFO', tag, message, data: data);
  }

  static void warning(String tag, String message, {Object? data}) {
    _log('WARN', tag, message, data: data);
  }

  static void error(
    String tag,
    String message, {
    Object? data,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (!enabled) return;

    final payload = _normalizePayload(data);
    final composed = StringBuffer('[$tag] $message');
    if (payload != null) {
      composed.write('\n$payload');
    }

    developer.log(
      composed.toString(),
      name: 'ERROR',
      error: error,
      stackTrace: stackTrace,
      level: 1000,
    );
  }

  static void _log(String level, String tag, String message, {Object? data}) {
    if (!enabled) return;

    final payload = _normalizePayload(data);
    final composed = StringBuffer('[$tag] $message');
    if (payload != null) {
      composed.write('\n$payload');
    }
    developer.log(composed.toString(), name: level);
  }

  static String? _normalizePayload(Object? data) {
    if (data == null) return null;
    try {
      if (data is String) return data;
      const encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(data);
    } catch (_) {
      return data.toString();
    }
  }
}
