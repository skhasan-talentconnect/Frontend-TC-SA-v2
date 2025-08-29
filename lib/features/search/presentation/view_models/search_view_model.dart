// selection_controller.dart
import 'package:flutter/material.dart';

class SelectionController extends ChangeNotifier {
  final Set<String> _selectedStates = {};
  final Set<String> _selectedCities = {};
  final Set<String> _selectedBoards = {};

  Set<String> get selectedStates => _selectedStates;
  Set<String> get selectedCities => _selectedCities;
  Set<String> get selectedBoards => _selectedBoards;

  void toggleStates(String state) {
    if (_selectedStates.contains(state)) {
      _selectedStates.remove(state);
      // Clear cities and boards when state is deselected
      _selectedCities.clear();
      _selectedBoards.clear();
    } else {
      _selectedStates.add(state);
    }
    notifyListeners();
  }

  void toggleCities(String city) {
    if (_selectedCities.contains(city)) {
      _selectedCities.remove(city);
      // Clear boards when city is deselected
      _selectedBoards.clear();
    } else {
      _selectedCities.add(city);
    }
    notifyListeners();
  }

  void toggleBoard(String board) {
    if (_selectedBoards.contains(board)) {
      _selectedBoards.remove(board);
    } else {
      _selectedBoards.add(board);
    }
    notifyListeners();
  }
}