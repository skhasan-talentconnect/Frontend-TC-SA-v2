import 'package:flutter/material.dart';

class SelectionController extends ChangeNotifier {
  final Set<String> _selectedStates = {};
  final Set<String> _selectedCities = {};
  final Set<String> _selectedBoards = {};
  final Set<String> _selectedGenders = {};    // ✅ NEW
  final Set<String> _selectedModes = {};      // ✅ NEW
  final Set<String> _selectedFeeRange = {};   // ✅ FIXED

  Set<String> get selectedStates => _selectedStates;
  Set<String> get selectedCities => _selectedCities;
  Set<String> get selectedBoards => _selectedBoards;
  Set<String> get selectedGenders => _selectedGenders;
  Set<String> get selectedModes => _selectedModes;
  Set<String> get selectedFeeRange => _selectedFeeRange;  // ✅ FIXED

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

  void toggleGender(String gender) {
    if (_selectedGenders.contains(gender)) {
      _selectedGenders.remove(gender);
    } else {
      _selectedGenders.add(gender);
    }
    notifyListeners();
  }

  void toggleMode(String mode) {
    if (_selectedModes.contains(mode)) {
      _selectedModes.remove(mode);
    } else {
      _selectedModes.add(mode);
    }
    notifyListeners();
  }

  void toggleFeeRange(String fee) {
    if (_selectedFeeRange.contains(fee)) {
      _selectedFeeRange.remove(fee);
    } else {
      _selectedFeeRange.add(fee);
    }
    notifyListeners();
  }
}
