import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/core/common/theme_provider.dart';
import 'package:tc_sa/features/detailPages/infrastructure/presentation/widgets/title_card.dart';

import 'package:tc_sa/features/detailPages/otherDetails/data/entities/otherDetails_model.dart';

class GenderRatioCard extends StatelessWidget {
  final GenderRatioModel ratio;

  const GenderRatioCard({super.key, required this.ratio});

  @override
  Widget build(BuildContext context) {
                final colors = context.watch<ThemeProvider>().colors;

    return TitledCard(
      title: 'Gender Distribution',
      // --- UI UPDATE: More modern and inclusive icon ---
      icon: Icons.people_alt_outlined,
      // --- THEME UPDATE: Set icon color ---
      iconColor: colors.amberDarkColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // --- THEME UPDATE: New colors for indicators ---
            _buildRatioIndicator('Male', ratio.male ?? 0, Colors.blue.shade700),
            _buildRatioIndicator('Female', ratio.female ?? 0, Colors.pink.shade400),
            _buildRatioIndicator('Others', ratio.others ?? 0, Colors.grey.shade600),
          ],
        ),
      ),
    );
  }

  Widget _buildRatioIndicator(String title, double value, Color color) {
    return Column(
      children: [
        SizedBox(
          height: 80,
          width: 80,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                value: value / 100,
                strokeWidth: 8,
                backgroundColor: color.withValues(alpha:0.1),
                color: color,
              ),
              Center(
                child: Text(
                  '${value.toStringAsFixed(0)}%',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      ],
    );
  }
}