import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamro_bike/common/constant/constant_colors.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: ConstantColors.backgroundColor,
    useMaterial3: true,
    brightness: Brightness.dark,
    // appBarTheme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      scrolledUnderElevation: 0,
      backgroundColor: ConstantColors.backgroundColor,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    ),

    // textTheme
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: ConstantColors.primaryTextColor,
        fontSize: 20.sp,
        fontWeight: .w400,
      ),
      bodyMedium: TextStyle(
        color: ConstantColors.primaryTextColor,
        fontSize: 18.sp,
      ),
      bodySmall: TextStyle(
        color: ConstantColors.secondaryTextColor,
        fontSize: 14.sp,
      ),
    ),

    // IconButton theme
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        padding: WidgetStatePropertyAll(.all(4.w)),
        iconSize: WidgetStatePropertyAll(25.r),
        backgroundColor: WidgetStatePropertyAll(ConstantColors.containerColor),
        iconColor: WidgetStateProperty.all(ConstantColors.primaryTextColor),
      ),
    ),
  );
}
