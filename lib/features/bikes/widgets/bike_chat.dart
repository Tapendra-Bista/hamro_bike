import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hamro_bike/common/constant/constant_strings.dart';
import 'package:hamro_bike/common/extensions/extensions_buildcontext.dart';

class BikeChat extends StatelessWidget {
  const BikeChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        Text(
          ConstantStrings.details,
          style: context.textTheme.bodyLarge!.copyWith(
            fontSize: 20.sp,
            fontWeight: .bold,
          ),
        ),

        Row(
          spacing: 5.w,
          children: [
            Text(
              '${ConstantStrings.chat} : ',
              style: context.textTheme.bodySmall,
            ),
            IconButton(
              style: context.iconButtonTheme.style!.copyWith(
                fixedSize: WidgetStatePropertyAll(Size(60, 60)),
              ),
              tooltip: ConstantStrings.chatWithSeller,
              onPressed: () {},
              icon:  Icon(CupertinoIcons.chat_bubble,size: 35.sp,),
            ),
          ],
        ),
      ],
    ).paddingSymmetric(horizontal: 10.w);
  }
}
