import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_base_project/utility/common_widgets/primary_button.dart';
import 'package:flutter_base_project/utility/constants/string_constants.dart';
import '../constants/color_constants.dart';
import '../constants/text_styles_const.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.black,
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: ColorConst.colorPrimary,
                    ),
                    height: 160,
                    width: 260,
                    child: const Center(
                      child: Text(
                        '404',
                        style: TextStyle(
                          fontSize: 100,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "There's Nothing here!",
                ),
                const SizedBox(height: 16),
                const Text(
                  "Sorry, the page you were looking for does not exist.",
                  style: TextStylesConst.whiteNormalText18,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 26),
            child: PrimaryButton(title: kLogin, press: (){}),
          ),
        ],
      ),
    );
  }

}
