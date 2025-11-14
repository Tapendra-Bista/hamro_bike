import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamro_bike/common/constant/constant_colors.dart';

class CommanDivider extends StatelessWidget {
  const CommanDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(thickness: 0.4.h, color: ConstantColors.dividersColor);
  }
}
