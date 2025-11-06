import 'package:get/get.dart';
import 'package:hamro_bike/features/about_us/about_us.dart';
import 'package:hamro_bike/features/create_post/screen/create_post_screen.dart';
import 'package:hamro_bike/features/privacy_policy/privacy_policy.dart';
import 'package:hamro_bike/features/profile/controller/profile_controller.dart';
import 'package:hamro_bike/features/terms_and_conditions/terms_and_conditions.dart';
import 'package:hamro_bike/features/user_argreement/user_argreement.dart';
import 'package:hamro_bike/routes/routes_name.dart';

// import '../features/authentication/binding/authentication_binding.dart';
import '../features/authentication/binding/authentication_binding.dart';
import '../features/authentication/controllers/authentication_controllers.dart';
import '../features/authentication/screen/authentication_screen.dart';
import '../features/create_post/binding/create_post_binding.dart';
import '../features/dashboard/bindings/dashboard_bindings.dart';
import '../features/dashboard/controller/dashboard_controller.dart';
import '../features/dashboard/screen/dashboard_screen.dart';

List<GetPage<dynamic>>? getPages = [
  // dashboard
  GetPage(
    name: RoutesName.dashboard,
    page: () => const DashboardScreen(),
    binding: DashboardBinding(),
  ),
  // Authenticating
  GetPage(
    name: RoutesName.authentication,
    page: () => const AuthenticationScreen(),
    binding: AuthenticationBinding(),
  ),
  // PrivacyPolicy
  GetPage(name: RoutesName.privacyPolicy, page: () => PrivacyPolicy()),
  // TermsAndConditions
  GetPage(
    name: RoutesName.termsAndConditions,
    page: () => TermsAndConditions(),
  ),
  // AboutUs
  GetPage(name: RoutesName.aboutUs, page: () => AboutUs()),
  // user agreement
  GetPage(name: RoutesName.userAgreement, page: () => UserAgreements()),

  GetPage(
    name: RoutesName.createPost,
    page: () => const CreatePostScreen(),
    binding: CreatePostBinding(),
  ),
];

// initialBinding
final initialBinding = BindingsBuilder(() {
  // Use fenix so controllers are re-created automatically after being disposed
  Get.lazyPut<AuthenticationController>(
    () => AuthenticationController(),
    fenix: true,
  );
  Get.lazyPut<DashboardController>(() => DashboardController(), fenix: true);
  Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
  // You can add any global controllers here if needed
});
