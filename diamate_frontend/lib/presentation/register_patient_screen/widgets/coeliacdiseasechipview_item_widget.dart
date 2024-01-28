import 'package:diamate_frontend/core/app_export.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CoeliacdiseasechipviewItemWidget extends StatelessWidget {
  const CoeliacdiseasechipviewItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return RawChip(
      padding: EdgeInsets.symmetric(
        horizontal: 12.h,
        vertical: 10.v,
      ),
      showCheckmark: false,
      labelPadding: EdgeInsets.zero,
      label: Text(
        "Coeliac disease",
        style: TextStyle(
          color: theme.colorScheme.onErrorContainer,
          fontSize: 12.fSize,
          fontFamily: 'Oxygen',
          fontWeight: FontWeight.w700,
        ),
      ),
      selected: false,
      backgroundColor: theme.colorScheme.onErrorContainer,
      selectedColor: theme.colorScheme.primary,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: theme.colorScheme.primary,
          width: 1.h,
        ),
        borderRadius: BorderRadius.circular(
          18.h,
        ),
      ),
      onSelected: (value) {},
    );
  }
}
