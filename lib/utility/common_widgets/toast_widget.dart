import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastWidget extends StatefulWidget {
  const ToastWidget(
      {super.key,
      required this.message,
      required this.onDismissed,
      required this.duration,
      required this.gravity,
      required this.color,
      required this.textColor,
      this.actionText,
      this.action,
      required this.toastIcon});

  final String message;
  final Duration duration;
  final ToastGravity gravity;
  final VoidCallback onDismissed;

  final String? actionText;
  final VoidCallback? action;

  final Color color;
  final Color textColor;
  final Icon toastIcon;

  @override
  ToastWidgetState createState() => ToastWidgetState();
}

class ToastWidgetState extends State<ToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  Timer? _dismissTimer;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0), end: Offset.zero)
        .animate(_controller);

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _dismissTimer = Timer(widget.duration, () => _controller.reverse());
      } else if (status == AnimationStatus.dismissed) {
        widget.onDismissed();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final toast = GestureDetector(
      onTap: () {
        if (_controller.isAnimating &&
            _controller.status == AnimationStatus.reverse) return;
        _dismissTimer?.cancel();
        _controller.reverse();
      },
      child: SlideTransition(
        position: _slideAnimation,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: widget.color,
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widget.toastIcon,
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.message,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    if (widget.gravity == ToastGravity.BOTTOM) {
      return Positioned(bottom: 40.0, left: 16, right: 16, child: toast);
    } else {
      return Positioned(top: 40.0, left: 16, right: 16, child: toast);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
