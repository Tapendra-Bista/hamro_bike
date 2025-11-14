import 'package:flutter/material.dart';
import 'package:hamro_bike/common/extensions/extensions_buildcontext.dart';

import '../../../common/constant/constant_strings.dart';

class BikesEmptyText extends StatelessWidget {
  const BikesEmptyText({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Text(
          ConstantStrings.noBikesAvailable,
          style: context.appTextTheme.bodyMedium,
        ),
      ),
    );
  }
}
