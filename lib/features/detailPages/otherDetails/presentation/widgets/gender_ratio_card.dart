import 'package:flutter/material.dart';
import 'package:tc_sa/features/detailPages/infrastructure/presentation/widgets/title_card.dart';
import 'package:tc_sa/features/detailPages/otherDetails/data/entities/otherDetails_model.dart';


class GenderRatioCard extends StatelessWidget {

  final GenderRatioModel ratio;

  const GenderRatioCard({super.key, required this.ratio});

  @override
  Widget build(BuildContext context) {
    return TitledCard(
      title: 'Gender Distribution',
      icon: Icons.pie_chart_outline_rounded,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildRatioIndicator('Male', ratio.male ?? 0, Colors.blue),
            _buildRatioIndicator('Female', ratio.female ?? 0, Colors.pink),
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
                backgroundColor: color.withOpacity(0.1),
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