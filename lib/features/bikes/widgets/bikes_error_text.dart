import 'package:flutter/material.dart';
import 'package:hamro_bike/common/extensions/extensions_buildcontext.dart';
import 'package:hamro_bike/features/bikes/controller/bikes_controller.dart';

class BikesErrorText extends StatelessWidget {
  const BikesErrorText({super.key, required this.bikesController});

  final BikesController bikesController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        bikesController.errorMessage,
        style: context.appTextTheme.bodyMedium,
      ),
    );
  }
}
