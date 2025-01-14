import 'package:flutter/material.dart';
import 'package:flutter_base_project/utility/constants/color_constants.dart';
import 'package:flutter_base_project/utility/constants/text_styles_const.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({super.key, this.loadingText});

  final String? loadingText;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        loadingText != null && (loadingText?.isNotEmpty ?? false)
            ? Text(
                '${loadingText ?? ''}...',
                style: TextStylesConst.whiteText14(fontWeight: FontWeight.w500),
              )
            : Container()
      ],
    );
  }
}
