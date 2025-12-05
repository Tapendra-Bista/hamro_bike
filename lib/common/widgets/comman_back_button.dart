import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../extensions/extensions_buildcontext.dart';

class CommanBackButton extends StatelessWidget {
  const CommanBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: context.iconButtonTheme.style!.copyWith(
        fixedSize: WidgetStatePropertyAll(Size(20, 20)),
      ),
      onPressed: () => Get.back(),
      icon: Icon(Iconsax.arrow_left_copy),
    );
  }
}
