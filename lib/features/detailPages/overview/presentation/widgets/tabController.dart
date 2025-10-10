import 'package:flutter/material.dart';

class SchoolTabController with ChangeNotifier {
  late TabController tabController;
  int currentIndex = 0;

  final List<String> tabs = [
       "Overview",
    "Amenities",
     "Infrastructure", 
  "Other Details", 
  "Fees And Scholarship",
    "Activities",
    "Aluminis",
    "Reviews",
    'academics',
    'techAdaption',
    'safetySecurity',
      'internationalExposure'
         'admission Timeline',
    'faculty details'
  ];

  void initialize(TickerProvider vsync) {
    tabController = TabController(length: tabs.length, vsync: vsync);
    tabController.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    if (currentIndex != tabController.index) {
      currentIndex = tabController.index;
      notifyListeners();
    }
  }

  void disposeController() {
    tabController.removeListener(_handleTabChange);
    tabController.dispose();
  }

  void changeTab(int index) {
    if (index >= 0 && index < tabs.length) {
      tabController.animateTo(index);
    }
  }
}