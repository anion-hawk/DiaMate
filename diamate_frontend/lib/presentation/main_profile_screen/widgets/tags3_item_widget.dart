import 'package:diamate_frontend/core/app_export.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Tags3ItemWidget extends StatelessWidget {
  const Tags3ItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return RawChip(
      padding: EdgeInsets.symmetric(
        horizontal: 10.h,
        vertical: 5.v,
      ),
      showCheckmark: false,
      labelPadding: EdgeInsets.zero,
      label: Text(
        "exercise",
        style: TextStyle(
          color: appTheme.indigo100,
          fontSize: 9.fSize,
          fontFamily: 'Source Sans Pro',
          fontWeight: FontWeight.w400,
        ),
      ),
      selected: false,
      backgroundColor: appTheme.indigo900,
      selectedColor: appTheme.indigo900,
      shape: RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.circular(
          11.h,
        ),
      ),
      onSelected: (value) {},
    );
  }
}
