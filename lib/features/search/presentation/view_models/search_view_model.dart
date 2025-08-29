// selection_controller.dart
import 'package:flutter/material.dart';

class SelectionController extends ChangeNotifier {
  final Set<String> _selectedStates = {};
  final Set<String> _selectedCities = {};
  final Set<String> _selectedStreams = {};

  Set<String> get selectedStates => _selectedStates;
  Set<String> get selectedCities => _selectedCities;
  Set<String> get selectedStreams => _selectedStreams;

  void toggleStates(String state) {
    if (_selectedStates.contains(state)) {
      _selectedStates.remove(state);
    } else {
      _selectedStates.add(state);
    }
    notifyListeners();
  }

  void toggleCities(String city) {
    if (_selectedCities.contains(city)) {
      _selectedCities.remove(city);
    } else {
      _selectedCities.add(city);
    }
    notifyListeners();
  }

  void toggleStream(String stream) {
    if (_selectedStreams.contains(stream)) {
      _selectedStreams.remove(stream);
    } else {
      _selectedStreams.add(stream);
    }
    notifyListeners();
  }
}