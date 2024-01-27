import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static get bodyLargeIndigo900 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.indigo900,
      );
  static get bodyLargeOnErrorContainer => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.onErrorContainer,
      );
  static get bodyLargePoppinsOnErrorContainer =>
      theme.textTheme.bodyLarge!.poppins.copyWith(
        color: theme.colorScheme.onErrorContainer,
        fontSize: 17.fSize,
      );
  static get bodyLargePoppinsPrimary =>
      theme.textTheme.bodyLarge!.poppins.copyWith(
        color: theme.colorScheme.primary,
      );
  static get bodyMediumBlack90002 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.black90002,
        fontSize: 14.fSize,
      );
  static get bodyMediumBlack9000214 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.black90002,
        fontSize: 14.fSize,
      );
  static get bodyMediumBlack90002_1 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.black90002,
      );
  static get bodyMediumGray800 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray800,
        fontSize: 14.fSize,
      );
  static get bodyMediumOnErrorContainer => theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.onErrorContainer,
      );
  static get bodyMediumOnErrorContainer14 =>
      theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.onErrorContainer,
        fontSize: 14.fSize,
      );
  static get bodyMediumPoppinsBlack90002 =>
      theme.textTheme.bodyMedium!.poppins.copyWith(
        color: appTheme.black90002,
        fontSize: 14.fSize,
      );
  static get bodyMediumPoppinsBlue300 =>
      theme.textTheme.bodyMedium!.poppins.copyWith(
        color: appTheme.blue300,
      );
  static get bodyMediumPoppinsBluegray40001 =>
      theme.textTheme.bodyMedium!.poppins.copyWith(
        color: appTheme.blueGray40001,
        fontSize: 14.fSize,
      );
  static get bodyMediumPoppinsGray400 =>
      theme.textTheme.bodyMedium!.poppins.copyWith(
        color: appTheme.gray400,
        fontSize: 14.fSize,
      );
  static get bodyMediumPoppinsGray50 =>
      theme.textTheme.bodyMedium!.poppins.copyWith(
        color: appTheme.gray50,
        fontSize: 14.fSize,
      );
  static get bodyMediumPoppinsOnErrorContainer =>
      theme.textTheme.bodyMedium!.poppins.copyWith(
        color: theme.colorScheme.onErrorContainer,
      );
  static get bodyMediumPrimaryContainer => theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.primaryContainer,
      );
  static get bodyMediumff000000 => theme.textTheme.bodyMedium!.copyWith(
        color: Color(0XFF000000),
        fontSize: 14.fSize,
      );
  static get bodySmallBlue300 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.blue300,
        fontSize: 12.fSize,
      );
  static get bodySmallBlue300_1 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.blue300,
      );
  static get bodySmallBluegray40002 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.blueGray40002,
        fontSize: 12.fSize,
      );
  static get bodySmallBluegray40003 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.blueGray40003,
        fontSize: 12.fSize,
      );
  static get bodySmallIndigo900 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.indigo900,
      );
  static get bodySmallOxygenBlack90002 =>
      theme.textTheme.bodySmall!.oxygen.copyWith(
        color: appTheme.black90002,
        fontSize: 12.fSize,
      );
  static get bodySmallOxygenGray500 =>
      theme.textTheme.bodySmall!.oxygen.copyWith(
        color: appTheme.gray500,
        fontSize: 12.fSize,
      );
  static get bodySmallOxygenGray600 =>
      theme.textTheme.bodySmall!.oxygen.copyWith(
        color: appTheme.gray600,
        fontSize: 10.fSize,
      );
  static get bodySmallOxygenGray70001 =>
      theme.textTheme.bodySmall!.oxygen.copyWith(
        color: appTheme.gray70001,
        fontSize: 11.fSize,
      );
  static get bodySmallOxygenOnErrorContainer =>
      theme.textTheme.bodySmall!.oxygen.copyWith(
        color: theme.colorScheme.onErrorContainer,
        fontSize: 12.fSize,
      );
  static get bodySmallPoppinsBlack90002 =>
      theme.textTheme.bodySmall!.poppins.copyWith(
        color: appTheme.black90002,
        fontWeight: FontWeight.w300,
      );
  static get bodySmallPoppinsGray60002 =>
      theme.textTheme.bodySmall!.poppins.copyWith(
        color: appTheme.gray60002,
        fontSize: 12.fSize,
      );
  static get bodySmallPoppinsGray700 =>
      theme.textTheme.bodySmall!.poppins.copyWith(
        color: appTheme.gray700,
        fontWeight: FontWeight.w300,
      );
  static get bodySmallPoppinsPrimary =>
      theme.textTheme.bodySmall!.poppins.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 12.fSize,
      );
  static get bodySmallPrimary => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.primary,
      );
  // Headline text style
  static get headlineSmallBlack90001 => theme.textTheme.headlineSmall!.copyWith(
        color: appTheme.black90001,
      );
  static get headlineSmallOxygenOnErrorContainer =>
      theme.textTheme.headlineSmall!.oxygen.copyWith(
        color: theme.colorScheme.onErrorContainer,
        fontSize: 24.fSize,
        fontWeight: FontWeight.w700,
      );
  static get headlineSmallOxygenPrimary =>
      theme.textTheme.headlineSmall!.oxygen.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 24.fSize,
        fontWeight: FontWeight.w700,
      );
  static get headlineSmallRed500 => theme.textTheme.headlineSmall!.copyWith(
        color: appTheme.red500,
        fontSize: 24.fSize,
        fontWeight: FontWeight.w700,
      );
  // Label text style
  static get labelLargeBlack90002 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.black90002,
        fontWeight: FontWeight.w600,
      );
  static get labelLargeBlue300 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.blue300,
      );
  static get labelLargeBlue300ExtraBold => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.blue300,
        fontWeight: FontWeight.w800,
      );
  static get labelLargeBlue300SemiBold => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.blue300,
        fontWeight: FontWeight.w600,
      );
  static get labelLargeBluegray900 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.blueGray900,
      );
  static get labelLargeOxygenOnErrorContainer =>
      theme.textTheme.labelLarge!.oxygen.copyWith(
        color: theme.colorScheme.onErrorContainer,
        fontWeight: FontWeight.w700,
      );
  static get labelLargeOxygenPrimary =>
      theme.textTheme.labelLarge!.oxygen.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w700,
      );
  static get labelLargePrimary => theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.primary,
      );
  static get labelLargeSourceSansProBlue300 =>
      theme.textTheme.labelLarge!.sourceSansPro.copyWith(
        color: appTheme.blue300,
        fontWeight: FontWeight.w600,
      );
  static get labelLargeSourceSansProIndigo900 =>
      theme.textTheme.labelLarge!.sourceSansPro.copyWith(
        color: appTheme.indigo900,
        fontWeight: FontWeight.w600,
      );
  static get labelLargeSourceSansProOnErrorContainer =>
      theme.textTheme.labelLarge!.sourceSansPro.copyWith(
        color: theme.colorScheme.onErrorContainer,
        fontWeight: FontWeight.w600,
      );
  static get labelLargeSourceSansProPrimary =>
      theme.textTheme.labelLarge!.sourceSansPro.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w600,
      );
  static get labelMediumBlue300 => theme.textTheme.labelMedium!.copyWith(
        color: appTheme.blue300,
        fontSize: 10.fSize,
      );
  static get labelMediumSemiBold => theme.textTheme.labelMedium!.copyWith(
        fontWeight: FontWeight.w600,
      );
  static get labelSmallSFProDisplayBlack90002 =>
      theme.textTheme.labelSmall!.sFProDisplay.copyWith(
        color: appTheme.black90002,
      );
  // Oxygen text style
  static get oxygenBlack90002 => TextStyle(
        color: appTheme.black90002,
        fontSize: 7.fSize,
        fontWeight: FontWeight.w400,
      ).oxygen;
  static get oxygenBlack90002Regular => TextStyle(
        color: appTheme.black90002,
        fontSize: 7.fSize,
        fontWeight: FontWeight.w400,
      ).oxygen;
  // Poppins text style
  static get poppinsBlack90002 => TextStyle(
        color: appTheme.black90002,
        fontSize: 6.fSize,
        fontWeight: FontWeight.w500,
      ).poppins;
  // S text style
  static get sFProDisplayBlack90002 => TextStyle(
        color: appTheme.black90002,
        fontSize: 5.fSize,
        fontWeight: FontWeight.w500,
      ).sFProDisplay;
  static get sFProDisplayBlack90002Regular => TextStyle(
        color: appTheme.black90002,
        fontSize: 5.fSize,
        fontWeight: FontWeight.w400,
      ).sFProDisplay;
  static get sFProDisplayBlack90002SemiBold => TextStyle(
        color: appTheme.black90002,
        fontSize: 7.fSize,
        fontWeight: FontWeight.w600,
      ).sFProDisplay;
  static get sFProDisplayGray80001 => TextStyle(
        color: appTheme.gray80001,
        fontSize: 6.fSize,
        fontWeight: FontWeight.w400,
      ).sFProDisplay;
  // Source text style
  static get sourceSansProOnErrorContainer => TextStyle(
        color: theme.colorScheme.onErrorContainer,
        fontSize: 6.fSize,
        fontWeight: FontWeight.w700,
      ).sourceSansPro;
  // Title text style
  static get titleLargeOxygenPrimary =>
      theme.textTheme.titleLarge!.oxygen.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w700,
      );
  static get titleLargePoppinsBlack90002 =>
      theme.textTheme.titleLarge!.poppins.copyWith(
        color: appTheme.black90002,
        fontSize: 21.fSize,
      );
  static get titleLargePoppinsBlack90002Bold =>
      theme.textTheme.titleLarge!.poppins.copyWith(
        color: appTheme.black90002,
        fontWeight: FontWeight.w700,
      );
  static get titleLargePoppinsBlack90002Regular =>
      theme.textTheme.titleLarge!.poppins.copyWith(
        color: appTheme.black90002,
        fontWeight: FontWeight.w400,
      );
  static get titleLargePoppinsGray500 =>
      theme.textTheme.titleLarge!.poppins.copyWith(
        color: appTheme.gray500,
        fontWeight: FontWeight.w700,
      );
  static get titleLargePoppinsIndigo900 =>
      theme.textTheme.titleLarge!.poppins.copyWith(
        color: appTheme.indigo900,
      );
  static get titleLargePoppinsIndigo900Medium =>
      theme.textTheme.titleLarge!.poppins.copyWith(
        color: appTheme.indigo900,
        fontWeight: FontWeight.w500,
      );
  static get titleLargePoppinsOnErrorContainer =>
      theme.textTheme.titleLarge!.poppins.copyWith(
        color: theme.colorScheme.onErrorContainer,
        fontWeight: FontWeight.w700,
      );
  static get titleMediumBlack90002 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black90002,
      );
  static get titleMediumBlue300 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.blue300,
      );
  static get titleMediumOnErrorContainer =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onErrorContainer,
      );
  static get titleMediumPoppins =>
      theme.textTheme.titleMedium!.poppins.copyWith(
        fontWeight: FontWeight.w600,
      );
  static get titleMediumPoppinsBlack90002 =>
      theme.textTheme.titleMedium!.poppins.copyWith(
        color: appTheme.black90002,
        fontWeight: FontWeight.w600,
      );
  static get titleMediumPoppinsBlack90002SemiBold =>
      theme.textTheme.titleMedium!.poppins.copyWith(
        color: appTheme.black90002,
        fontSize: 19.fSize,
        fontWeight: FontWeight.w600,
      );
  static get titleMediumPoppinsBlue300 =>
      theme.textTheme.titleMedium!.poppins.copyWith(
        color: appTheme.blue300,
      );
  static get titleMediumPoppinsBlue300Medium =>
      theme.textTheme.titleMedium!.poppins.copyWith(
        color: appTheme.blue300,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumPoppinsBlue300SemiBold =>
      theme.textTheme.titleMedium!.poppins.copyWith(
        color: appTheme.blue300,
        fontWeight: FontWeight.w600,
      );
  static get titleMediumPoppinsGray500 =>
      theme.textTheme.titleMedium!.poppins.copyWith(
        color: appTheme.gray500,
      );
  static get titleMediumPoppinsOnErrorContainer =>
      theme.textTheme.titleMedium!.poppins.copyWith(
        color: theme.colorScheme.onErrorContainer,
        fontWeight: FontWeight.w600,
      );
  static get titleMediumPoppinsOnErrorContainerMedium =>
      theme.textTheme.titleMedium!.poppins.copyWith(
        color: theme.colorScheme.onErrorContainer,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumPoppinsOnErrorContainer_1 =>
      theme.textTheme.titleMedium!.poppins.copyWith(
        color: theme.colorScheme.onErrorContainer,
      );
  static get titleSmallBluegray300 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray300,
        fontSize: 14.fSize,
      );
  static get titleSmallBluegray400 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray400,
        fontSize: 14.fSize,
      );
  static get titleSmallBluegray50001 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray50001,
      );
  static get titleSmallBluegray5000114 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray50001,
        fontSize: 14.fSize,
      );
  static get titleSmallGray50002 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.gray50002,
        fontSize: 14.fSize,
      );
  static get titleSmallInter => theme.textTheme.titleSmall!.inter.copyWith(
        fontSize: 14.fSize,
        fontWeight: FontWeight.w500,
      );
  static get titleSmallInterGray50001 =>
      theme.textTheme.titleSmall!.inter.copyWith(
        color: appTheme.gray50001,
        fontSize: 14.fSize,
        fontWeight: FontWeight.w500,
      );
  static get titleSmallInterGray800 =>
      theme.textTheme.titleSmall!.inter.copyWith(
        color: appTheme.gray800,
        fontSize: 14.fSize,
        fontWeight: FontWeight.w500,
      );
  static get titleSmallOnErrorContainer => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.onErrorContainer,
        fontSize: 14.fSize,
      );
  static get titleSmallOnErrorContainer_1 =>
      theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.onErrorContainer,
      );
  static get titleSmallOnPrimaryContainer =>
      theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
        fontSize: 14.fSize,
      );
  static get titleSmallPoppins => theme.textTheme.titleSmall!.poppins.copyWith(
        fontSize: 14.fSize,
        fontWeight: FontWeight.w500,
      );
  static get titleSmallPoppins14 =>
      theme.textTheme.titleSmall!.poppins.copyWith(
        fontSize: 14.fSize,
      );
  static get titleSmallPoppinsBlack900 =>
      theme.textTheme.titleSmall!.poppins.copyWith(
        color: appTheme.black900,
      );
  static get titleSmallPoppinsBlue300 =>
      theme.textTheme.titleSmall!.poppins.copyWith(
        color: appTheme.blue300,
        fontSize: 14.fSize,
        fontWeight: FontWeight.w500,
      );
  static get titleSmallPoppinsBluegray500 =>
      theme.textTheme.titleSmall!.poppins.copyWith(
        color: appTheme.blueGray500,
        fontWeight: FontWeight.w600,
      );
  static get titleSmallPoppinsIndigo900 =>
      theme.textTheme.titleSmall!.poppins.copyWith(
        color: appTheme.indigo900,
        fontWeight: FontWeight.w500,
      );
  static get titleSmallPoppinsMedium =>
      theme.textTheme.titleSmall!.poppins.copyWith(
        fontWeight: FontWeight.w500,
      );
  static get titleSmallPoppinsOnErrorContainer =>
      theme.textTheme.titleSmall!.poppins.copyWith(
        color: theme.colorScheme.onErrorContainer,
        fontWeight: FontWeight.w600,
      );
  static get titleSmallPoppinsSemiBold =>
      theme.textTheme.titleSmall!.poppins.copyWith(
        fontWeight: FontWeight.w600,
      );
  static get titleSmallPoppinsSemiBold14 =>
      theme.textTheme.titleSmall!.poppins.copyWith(
        fontSize: 14.fSize,
        fontWeight: FontWeight.w600,
      );
  static get titleSmallPoppins_1 => theme.textTheme.titleSmall!.poppins;
  static get titleSmallff000000 => theme.textTheme.titleSmall!.copyWith(
        color: Color(0XFF000000),
        fontSize: 14.fSize,
      );
}

extension on TextStyle {
  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }

  TextStyle get oxygen {
    return copyWith(
      fontFamily: 'Oxygen',
    );
  }

  TextStyle get sourceSansPro {
    return copyWith(
      fontFamily: 'Source Sans Pro',
    );
  }

  TextStyle get sFProDisplay {
    return copyWith(
      fontFamily: 'SF Pro Display',
    );
  }

  TextStyle get poppins {
    return copyWith(
      fontFamily: 'Poppins',
    );
  }
}
