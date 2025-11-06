import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../profile/screen/profile_screen.dart';

// Controller for Dashboard feature
class DashboardController extends GetxController {
  // variables
  final RxInt _selectedIndex = 0.obs;

  // getter
  get selectedIndex => _selectedIndex.value;

  // setter
  set selectedIndex(value) => _selectedIndex.value = value ?? 0;
}

// page  List
final List<Widget> dashboardPages = [
  Center(child: Text('Bikes Page')),
  Center(child: Text('Search Page')),
  Center(child: Text('Chat Page')),
  ProfileScreen(),
];
