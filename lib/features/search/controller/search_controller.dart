import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamro_bike/features/create_post/model/create_post_model.dart';
import 'package:hamro_bike/features/search/repository/search_repository.dart';
import 'package:logger/logger.dart';

class SearchController extends GetxController {
  // Instance
  final SearchRepository _searchRepository = SearchRepository();
  final Logger _logger = Logger();
  final TextEditingController searchTextController = TextEditingController();

  // Variables
  final RxList<CreatePostModel> _searchResults = <CreatePostModel>[].obs;
  final RxList<CreatePostModel> _allBikes = <CreatePostModel>[].obs;
  final RxBool _isLoading = false.obs;
  final RxBool _isSearching = false.obs;
  final RxString _searchQuery = ''.obs;

  // Getters
  List<CreatePostModel> get searchResults => _searchResults;
  List<CreatePostModel> get allBikes => _allBikes;
  bool get isLoading => _isLoading.value;
  bool get isSearching => _isSearching.value;
  String get searchQuery => _searchQuery.value;

  // Setters
  set searchResults(List<CreatePostModel> value) =>
      _searchResults.value = value;
  set allBikes(List<CreatePostModel> value) => _allBikes.value = value;
  set isLoading(bool value) => _isLoading.value = value;
  set isSearching(bool value) => _isSearching.value = value;
  set searchQuery(String value) => _searchQuery.value = value;

  @override
  void onInit() {
    super.onInit();
    fetchAllBikes();
  }

  @override
  void onClose() {
    searchTextController.dispose();
    super.onClose();
  }

  // Fetch all bikes for initial display
  Future<void> fetchAllBikes() async {
    try {
      isLoading = true;
      final bikes = await _searchRepository.getAllBikes();
      allBikes = bikes;
      searchResults = bikes;
    } catch (e) {
      _logger.e('Error fetching bikes: $e');
    } finally {
      isLoading = false;
    }
  }

  // Search bikes by query
  void searchBikes(String query) {
    searchQuery = query.trim().toLowerCase();

    if (searchQuery.isEmpty) {
      searchResults = allBikes;
      isSearching = false;
      return;
    }

    isSearching = true;

    searchResults = allBikes.where((bike) {
      final title = bike.title.toLowerCase();
      final vehicleName = bike.vehicleName.toLowerCase();
      final description = bike.description.toLowerCase();
      final location = bike.location.toLowerCase();

      return title.contains(searchQuery) ||
          vehicleName.contains(searchQuery) ||
          description.contains(searchQuery) ||
          location.contains(searchQuery);
    }).toList();
  }

  // Clear search
  void clearSearch() {
    searchTextController.clear();
    searchQuery = '';
    searchResults = allBikes;
    isSearching = false;
  }

  // Filter by price range
  void filterByPriceRange(double minPrice, double maxPrice) {
    if (searchQuery.isEmpty) {
      searchResults = allBikes.where((bike) {
        return bike.price >= minPrice && bike.price <= maxPrice;
      }).toList();
    } else {
      searchResults = searchResults.where((bike) {
        return bike.price >= minPrice && bike.price <= maxPrice;
      }).toList();
    }
  }

  // Sort by price
  void sortByPrice({bool ascending = true}) {
    searchResults.sort((a, b) {
      return ascending
          ? a.price.compareTo(b.price)
          : b.price.compareTo(a.price);
    });
    _searchResults.refresh();
  }

  // Sort by date
  void sortByDate({bool newest = true}) {
    searchResults.sort((a, b) {
      return newest
          ? b.postDate.compareTo(a.postDate)
          : a.postDate.compareTo(b.postDate);
    });
    _searchResults.refresh();
  }
}
