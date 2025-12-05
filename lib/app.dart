import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hamro_bike/common/constant/constant_colors.dart';
import 'package:hamro_bike/features/authentication/screen/authentication_screen.dart';
import 'package:hamro_bike/features/dashboard/screen/dashboard_screen.dart';
import 'package:hamro_bike/routes/routes_page.dart';

import 'common/theme/app_theme.dart';

class HamroBike extends StatelessWidget {
  const HamroBike({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, _) {
        return GetMaterialApp(
          defaultTransition: Transition.fadeIn,
          transitionDuration: const Duration(milliseconds: 300),
          initialBinding: initialBinding,
          getPages: getPages,
          debugShowCheckedModeBanner: false,
          title: 'HamroBike',

          theme: AppTheme.darkTheme,

          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                User? user = snapshot.data;
                if (user == null) {
                  return const AuthenticationScreen();
                } else {
                  return const DashboardScreen();
                }
              }
              return Scaffold(backgroundColor: ConstantColors.backgroundColor);
            },
          ),
        );
      },
    );
  }
}
