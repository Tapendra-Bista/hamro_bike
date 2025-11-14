import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamro_bike/common/extensions/extensions_buildcontext.dart';
import 'package:hamro_bike/common/extensions/extensions_widget.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class BikesLikeAndComment extends StatelessWidget {
  const BikesLikeAndComment({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .start,
      spacing: 5.w,
      children: [
        Row(
          spacing: 2.w,
          children: [
            Text('5k', style: context.appTextTheme.bodySmall),
            IconButton(
              style: context.iconButtonTheme.style!.copyWith(
                backgroundColor: WidgetStatePropertyAll<Color>(
                  Colors.transparent,
                ),
              ),
              onPressed: () {},
              icon: Icon(Iconsax.heart_copy),
            ),
          ],
        ),
        Row(
          spacing: 2.w,
          children: [
            Text('5k', style: context.appTextTheme.bodySmall),
            IconButton(
              style: context.iconButtonTheme.style!.copyWith(
                backgroundColor: WidgetStatePropertyAll<Color>(
                  Colors.transparent,
                ),
              ),
              onPressed: () {},
              icon: Icon(CupertinoIcons.chat_bubble),
            ),
          ],
        ),
      ],
    ).appPaddingSymmetric(h: 10.w);
  }
}
