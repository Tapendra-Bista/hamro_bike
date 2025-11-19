import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hamro_bike/common/constant/constant_colors.dart';
import 'package:hamro_bike/common/extensions/extensions_buildcontext.dart';
import 'package:hamro_bike/common/widgets/app_logo.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../common/constant/constant_strings.dart';
import '../../../routes/routes_name.dart';

class BikesAppBar extends StatelessWidget {
  const BikesAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      actions: [
        IconButton(
          tooltip: ConstantStrings.backButtonTooltip,
          style: context.iconButtonTheme.style,
          onPressed: () {},
          icon: Icon(
            Iconsax.setting_4_copy,
            color: ConstantColors.secondaryTextColor,
          ),
        ).paddingOnly(right: 8.w),
      ],

      leading: IconButton(
        tooltip: ConstantStrings.creatPostTooltip,
        style: context.iconButtonTheme.style,
        onPressed: () => Get.toNamed(RoutesName.createPost),
        icon: Icon(Iconsax.add_copy),
      ),
      title: AppLogo(
        width: 150,
      ),
      centerTitle: true,
    );
  }
}
