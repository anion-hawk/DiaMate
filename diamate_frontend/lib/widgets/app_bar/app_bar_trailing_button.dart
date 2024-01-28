import 'package:diamate_frontend/core/app_export.dart';
import 'package:diamate_frontend/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppbarTrailingIconButton extends StatelessWidget {
  AppbarTrailingIconButton({
    Key? key,
    this.imagePath,
    this.margin,
    this.onTap,
  }) : super(
          key: key,
        );

  String? imagePath;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!.call();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: CustomIconButton(
          decoration: IconButtonStyleHelper.fillOnErrorContainer,
          child: CustomImageView(
            imagePath: imagePath,
          ),
          height: 24.v,
          width: 26.h,
          //fit: BoxFit.contain,
        ),
      ),
    );
  }
}
