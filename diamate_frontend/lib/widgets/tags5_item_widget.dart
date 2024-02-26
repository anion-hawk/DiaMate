import 'package:diamate_frontend/core/app_export.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Tags5ItemWidget extends StatelessWidget {
  const Tags5ItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return RawChip(
      padding: EdgeInsets.symmetric(
        horizontal: 10.h,
        vertical: 4.v,
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
      backgroundColor: theme.colorScheme.primary,
      selectedColor: theme.colorScheme.primary,
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
