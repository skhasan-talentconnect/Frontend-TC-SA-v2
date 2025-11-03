import 'package:flutter/material.dart';

class SchoolTabController with ChangeNotifier {
  late TabController tabController;
  int currentIndex = 0;

  final List<String> tabs = [
       "Overview",
       'academics',
        'faculty details',
           "Infrastructure", 
    'techAdaption',
        "Activities",
            'safetySecurity',
  'internationalExposure',
 "Fees And Scholarship",

  'admission Timeline',
    "Amenities",
  
    "Aluminis",
        "Reviews",

  "Other Details", 
 'photos'
    
    
       
   
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