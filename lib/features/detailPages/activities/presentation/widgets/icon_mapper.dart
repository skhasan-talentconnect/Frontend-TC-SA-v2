import 'package:flutter/material.dart';

class ActivityIconMapper {
  static final Map<String, IconData> activityIcons = {
    "Focusing on Academics": Icons.school,
    "Focuses on Practical Learning": Icons.science,
    "Focuses on Theoretical Learning": Icons.menu_book,
    "Empowering in Sports": Icons.sports_soccer,
    "Empowering in Arts": Icons.palette,
    "Special Focus on Mathematics": Icons.calculate,
    "Special Focus on Science": Icons.biotech,
    "Special Focus on Physical Education": Icons.fitness_center,
    "Leadership Development": Icons.leaderboard,
    "STEM Activities": Icons.code,
    "Cultural Education": Icons.theater_comedy,
    "Technology Integration": Icons.computer,
    "Environmental Awareness": Icons.eco,
  };

  static IconData getIconFor(String activity) {
    return activityIcons[activity] ?? Icons.star; // fallback
  }
}
