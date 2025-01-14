import 'package:flutter/material.dart';
import 'package:flutter_base_project/utility/common_widgets/primary_button.dart';
import 'package:flutter_base_project/utility/constants/assets_constants.dart';
import 'package:flutter_base_project/utility/constants/text_styles_const.dart';

class NoDataWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const NoDataWidget({
    super.key,
    this.message = "No data found",
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(AssetsConst.instance.noDataFound,width: 150,),
            const SizedBox(height: 16),
            Text(
              message,
              style: TextStylesConst.grey18_500(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            PrimaryButton(title: "Retry", press: onRetry,)
          ],
        ),
      ),
    );
  }
}
