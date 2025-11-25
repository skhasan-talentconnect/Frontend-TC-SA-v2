import 'package:flutter/material.dart';
import 'package:tc_sa/common/theme/themes.dart';

class AppThemes {
  static final Map<AppTheme, AppColorTheme> themes = {
    AppTheme.themeA:AppColorTheme(
      backgroundColor: Color(0xffffffff),
      textColor: Color(0xff000000),
      secTextColor: Colors.yellow.withValues(alpha:0.5),
      terTextColor: Color(0xff404040),
      primaryColor: Colors.yellow,
     
      borderColor: Colors.yellow.shade200,
      borderSideColor : Colors.yellow.shade400,
      bottomTextColor :  Colors.grey.shade700,
     boxShadowColor: Colors.yellow.shade100.withValues(alpha:0.5),
     topTextColor : Colors.yellow.shade800,
     greyShadowColor : Colors.grey.withValues(alpha:0.5),
   
amberColor : Colors.amber,
amberDarkColor :  Colors.amber.shade800,
amberLightColor : Colors.amber.shade50,
amberMedColor : Colors.amber.shade200,
    ),

    AppTheme.themeB: AppColorTheme(
  backgroundColor: const Color(0xFFF3FCF7), // very soft light green/white
  textColor: const Color(0xFF0B2817), // deep readable green
  secTextColor: const Color(0xFF1B5E20), // medium green
  terTextColor: const Color(0xFF2E7D32), // brighter mid green

  primaryColor: const Color(0xFF0F9D58), // Emerald
  borderColor: const Color(0xFFB2DFDB), // soft teal border
  borderSideColor: const Color(0xFF80CBC4), // medium border shade

  bottomTextColor: const Color(0xFF1B5E20),
  topTextColor: const Color(0xFF064C2E),

  boxShadowColor: const Color(0xFFB2FFCC).withOpacity(0.5),
  greyShadowColor: Colors.grey.withOpacity(0.3),

  amberColor: Colors.green.shade300,
  amberMedColor: Colors.green.shade200,
  amberLightColor: Colors.green.shade50,
  amberDarkColor: Colors.green.shade700,
),


   AppTheme.themeC: AppColorTheme(
  backgroundColor: const Color(0xFFFFFFFF), // pure white
  textColor: const Color(0xFF000000), // pure black

  secTextColor: const Color(0xFF3A3A3A), // dark gray
  terTextColor: const Color(0xFF707070), // medium gray

  primaryColor: const Color(0xFF000000), // black accent
  borderColor: const Color(0xFFE0E0E0), // soft light border
  borderSideColor: const Color(0xFFBDBDBD), // stronger border

  bottomTextColor: const Color(0xFF505050),
  topTextColor: const Color(0xFF1A1A1A),

  boxShadowColor: Colors.black.withOpacity(0.07),
  greyShadowColor: Colors.grey.withOpacity(0.4),

  amberColor: Colors.grey.shade300,
  amberMedColor: Colors.grey.shade200,
  amberLightColor: Colors.grey.shade100,
  amberDarkColor: Colors.grey.shade600,
),

  AppTheme.themeD: AppColorTheme(
  backgroundColor: const Color(0xFFF3F8FF), // soft bluish white
  textColor: const Color(0xFF0A1A33), // dark navy text

  secTextColor: const Color(0xFF1565C0), // mid blue
  terTextColor: const Color(0xFF42A5F5), // bright blue

  primaryColor: const Color(0xFF1E88E5), // main blue
  borderColor: const Color(0xFF90CAF9), // soft blue border
  borderSideColor: const Color(0xFF64B5F6), // stronger border shade

  bottomTextColor: const Color(0xFF2C436B),
  topTextColor: const Color(0xFF0D47A1),

  boxShadowColor: Colors.blue.shade100.withOpacity(0.5),
  greyShadowColor: Colors.grey.withOpacity(0.28),

  amberColor: Colors.blue.shade300,
  amberMedColor: Colors.blue.shade200,
  amberLightColor: Colors.blue.shade50,
  amberDarkColor: Colors.blue.shade700,
),

  };
}
