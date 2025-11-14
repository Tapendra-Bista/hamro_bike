import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamro_bike/features/bikes/screen/bikes_screen.dart';

import '../../profile/screen/profile_screen.dart';

// Controller for Dashboard feature
class DashboardController extends GetxController {
  // variables
  final RxInt _selectedIndex = 0.obs;

  // getter
  int get selectedIndex => _selectedIndex.value;

  // setter
  set selectedIndex(int? value) => _selectedIndex.value = value ?? 0;
}

// page  List
final List<Widget> dashboardPages = [
  BikesScreen(),
  Center(child: Text('Search Page')),
  Center(child: Text('Chat Page')),
  ProfileScreen(),
];
