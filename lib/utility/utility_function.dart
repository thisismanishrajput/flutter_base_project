import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_base_project/utility/common_widgets/toast_widget.dart';
import 'package:flutter_base_project/utility/constants/color_constants.dart';
import 'package:flutter_base_project/utility/constants/string_constants.dart';
import '../core/router/router.dart';

enum ToastLevel { success, error }

class UtilityFunction {
  static UtilityFunction instance = UtilityFunction();
  final List<OverlayEntry?> _overlayList = [];
  static const _kDefaultDuration = Duration(milliseconds: 1500);
  static const _kDefaultGravity = ToastGravity.TOP;

  void showToast(
    String message, {
    Duration? duration,
    String? actionText,
    VoidCallback? action,
    ToastGravity? gravity,
    required ToastLevel level,
  }) {
    // Check for keyboard open. If open will ignore the gravity bottom and change it to top
    if (gravity == ToastGravity.BOTTOM &&
        MediaQuery.of(navigatorKey.currentContext!).viewInsets.bottom != 0) {
      // ignore: parameter_assignments
      gravity = ToastGravity.TOP;
    }

    late Color color;
    late Color textColor;
    late Icon toastIcon;

    switch (level) {
      case ToastLevel.success:
        color = ColorConst.colorPrimary;
        textColor = ColorConst.white;
        toastIcon = const Icon(
          Icons.check_circle,
          color: Colors.white,
          size: 30,
        );
        break;
      case ToastLevel.error:
        color = ColorConst.redBtnBgColor;
        textColor = ColorConst.white;
        toastIcon = const Icon(
          Icons.error,
          color: Colors.white,
          size: 30,
        );
        break;
      default:
        throw Exception(
            'Unknown Level passed in the toast inside NotifyUserService class');
    }

    // default gravity is top & default duration is 3 seconds
    final elementIndex = _overlayList.length;
    final overlayEntry = OverlayEntry(
      builder: (context) => ToastWidget(
        message: message,
        duration: duration ?? _kDefaultDuration,
        gravity: gravity ?? _kDefaultGravity,
        onDismissed: () => _onToastDismiss(elementIndex),
        color: color,
        textColor: textColor,
        actionText: actionText,
        action: action,
        toastIcon: toastIcon,
      ),
    );
    _overlayList.add(overlayEntry);
    navigatorKey.currentState?.overlay?.insert(overlayEntry);
  }

  void _onToastDismiss(int index) {
    // remove from queue & make it null, so as to don't disturb the order
    _overlayList[index]!.remove();
    _overlayList[index] = null;
    final len = _overlayList.length - 1;
    // clear the null elements from reverse of _overlayList, until it finds a valid OverlayEntry
    for (int i = len; i >= 0; i--) {
      if (_overlayList[i] == null) {
        _overlayList.removeLast();
      } else {
        break;
      }
    }
  }

  void showIndicator(BuildContext context, String text) {
    showDialog(
      context: context,
      barrierDismissible: false,
      routeSettings: const RouteSettings(name: "Loader"),
      builder: (context) => Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: CircularProgressIndicator(
                  strokeWidth: 4.0,
                  color: ColorConst.colorPrimary,
                ),
              ),
              (text.isNotEmpty)
                  ? Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        '$text...',

                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }

  sendFirebaseEvent(
      {required String eventName,
      required String description,
      required String screenName}) async {
    await FirebaseAnalytics.instance.logEvent(
      name: eventName,
      parameters: {
        'event_description': description,
      },
    );
    await FirebaseAnalytics.instance.logScreenView(screenName: screenName);
  }


  void updateTheApp(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        routeSettings: const RouteSettings(name: "UpdateApp"),
        builder: (BuildContext context) {
          return CupertinoTheme(
            data: const CupertinoThemeData(brightness: Brightness.dark),
            child: CupertinoAlertDialog(
              content: const Text(
                kYouMustUpdateToContinue,
              ),
              title: const Text(
                kUpdateRequired,
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                    isDefaultAction: true,
                    onPressed: () async {
                      var url = '';
                      if (Platform.isIOS) {
                      } else {
                        url = kPlayStoreUrl;
                      }
                      await launchUrl(Uri.parse(url),
                          mode: LaunchMode.externalApplication);
                    },
                    child: const Text(
                      kUpdate,
                    )),
              ],
            ),
          );
        });
  }

  //these methods are used for parsing the date and time
  String parseDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('MM-dd-yyyy').format(date.toLocal());
  }

  String parseDateInText(DateTime? date) {
    if (date == null) return '';
    return Jiffy.parseFromDateTime(date.toLocal())
        .format(pattern: 'd-MMM-yyyy');
  }

  String parseTime(DateTime? time) {
    if (time == null) return '';
    return DateFormat('hh:mm a').format(time.toLocal());
  }

  bool isEmailValid(String email) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(email);
  }




}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this; // Return empty string if input is empty
    return this[0].toUpperCase() + substring(1);
  }
}
