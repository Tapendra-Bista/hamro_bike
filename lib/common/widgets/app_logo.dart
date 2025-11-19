import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/constant/constant_strings.dart';
import '../../../common/extensions/extensions_widget.dart';


class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.width = 300, this.height = 55});
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ConstantStrings.appTextLogo,
      width: width.w,
      height: height.h,
      fit: .contain,
    ).center();
  }
}
