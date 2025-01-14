import 'package:flutter/material.dart';
import 'package:flutter_base_project/utility/constants/color_constants.dart';
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.title,
    required this.press,
    this.width = 110,
    this.height = 34,
    this.color = ColorConst.menuEnableColor,
    this.outlineColor = ColorConst.menuEnableColor,
    this.isBgWhite = false,
    this.isOutline = false,
    this.isExpanded = true,
    this.iconPath = "",
    this.iconColor =  Colors.white,
  });

  final String title;
  final VoidCallback press;
  final double? width, height;
  final Color? color;
  final bool? isBgWhite;
  final bool? isOutline;
  final bool isExpanded;
  final Color? outlineColor;
  final String iconPath ;
  final Color? iconColor  ;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: press,
        child: isExpanded ?Container(
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
              color:isOutline! ? Colors.white: color,
              border: Border.all(color: outlineColor ?? ColorConst.menuEnableColor,width: 1),
              borderRadius: BorderRadius.circular(10)
          ),
          padding: const EdgeInsets.only(top: 12,bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(iconPath.isNotEmpty)...[
                const SizedBox(width: 8)
              ],
              Text(title,style: TextStyle(
                  fontSize: 16,
                  color:isOutline! ? ColorConst.black: Colors.white,
                  fontWeight: FontWeight.w600
              ),),
            ],
          ),
        ):Container(
          decoration: BoxDecoration(
              color:isOutline! ? Colors.white: color,
              border: Border.all(color: outlineColor ?? ColorConst.menuEnableColor,width: 1),
              borderRadius: BorderRadius.circular(10)
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if(iconPath.isNotEmpty)...[
                const SizedBox(width: 8)
              ],
              Text(title,style: TextStyle(
                  fontSize: 14,
                  color:isOutline! ? ColorConst.black: Colors.white,
                  fontWeight: FontWeight.w500
              ),),
            ],
          ),
        ),
      ),
    );
  }
}



Widget buttonWithLoading({required BuildContext context,double height = 40,double width = 40, required ValueNotifier valueNotifier, required Widget child,Color color = ColorConst.menuEnableColor}){
  return   Center(
    child: ValueListenableBuilder(
      valueListenable: valueNotifier,
      builder: (_, value, __) {
        if (value == true) {
          return Theme(
            data: Theme.of(context).copyWith(colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorConst.menuEnableColor)),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: SizedBox(
                height: height,
                width: width,
                child: Center(
                  child: CircularProgressIndicator(
                    color: color,
                  ),
                ),
              ),
            ),
          );
        }
        return child;
      },
    ),
  );
}