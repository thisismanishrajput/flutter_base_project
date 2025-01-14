import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_project/utility/common_widgets/primary_button.dart';

import '../../../../../utility/constants/color_constants.dart';
import '../../../../../utility/constants/string_constants.dart';

class LocationRequestDialog extends StatelessWidget {
  const LocationRequestDialog(
      {super.key, this.message = kPleaseEnableLocationForExperience});

  final String message;

  TextStyle get staticStyle => const TextStyle(
        color: ColorConst.black,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      );

  TextStyle get yellowStyle => const TextStyle(
        color: ColorConst.colorPrimary,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorConst.white,
      insetPadding: const EdgeInsets.all(48),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              kLocationPermission,
              style: TextStyle(
                color: ColorConst.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
           const Icon(Icons.location_on_outlined,size: 36,),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: ColorConst.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    isExpanded: false,
                    title:"Allow" ,
                    press: (){
                      Navigator.pop(context, true);
                      },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: PrimaryButton(
                    isExpanded: false,
                    title:"Cancel" ,
                    press: (){
                      SystemNavigator.pop(); // Exit the app

                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
