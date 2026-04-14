import 'package:clean_arch_base/src/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class RoutePlaceholderPage extends StatelessWidget {
  const RoutePlaceholderPage({
    required this.title,
    required this.message,
    super.key,
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title, style: context.h6)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            message,
            style: context.bodyMd,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
