import 'package:flutter/material.dart';
import 'package:flutter_base_project/utility/constants/assets_constants.dart';
import 'package:flutter_base_project/utility/constants/string_constants.dart';
import 'package:flutter_base_project/utility/constants/text_styles_const.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const String path = '/';
  static const String routeName = 'splash';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 24.0, top: 44),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Image.asset(
                AssetsConst.instance.splashLogo,
                width: MediaQuery.sizeOf(context).width * 0.5,
              ),
            ),
            Column(
              children: [
                Text(kSupportedBy, style: TextStylesConst.blackText23()),
                const SizedBox(height: 10),
                Image.asset(
                  AssetsConst.instance.createdBy,
                  width: MediaQuery.sizeOf(context).width * 0.3,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
