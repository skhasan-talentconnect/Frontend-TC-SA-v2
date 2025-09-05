import 'package:flutter/material.dart';
import 'package:tc_sa/common/index.dart';

class CompareSchools extends StatelessWidget {
  final SchoolCardModel firstSchool;
  final SchoolCardModel secondSchool;
  const CompareSchools({super.key, required this.firstSchool, required this.secondSchool});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black), onPressed: () => Navigator.pop(context)),
        title: const Text('School Comparison', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Compare. Decide. Succeed!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
            const SizedBox(height: 8),
            Text('Compare Schools', style: TextStyle(fontWeight: FontWeight.bold, color: SColor.primaryColor, fontSize: 33)),
            const SizedBox(height: 4),
            const Text('Side-by-side comparison to find your best fit.', style: TextStyle(fontSize: 15, color: Colors.black87)),
            const SizedBox(height: 20),
            
            // Simplified school cards - just image and name
            Row(
              children: [
                Expanded(child: _buildSimpleSchoolCard(firstSchool)),
                const SizedBox(width: 10),
                Expanded(child: _buildSimpleSchoolCard(secondSchool)),
              ],
            ),
            
            const SizedBox(height: 20),
            _comparisonRow('School Name', [firstSchool.name ?? 'Not available', secondSchool.name ?? 'Not available']),
            _comparisonRow('Board', [firstSchool.board ?? 'Not available', secondSchool.board ?? 'Not available']),
            _comparisonRow('Fee Range', [firstSchool.feeRange ?? 'Not available', secondSchool.feeRange ?? 'Not available']),
            _comparisonRow('Location', [firstSchool.location ?? 'Not available', secondSchool.location ?? 'Not available']),
            _comparisonRow('Gender', [firstSchool.genderType ?? 'Not available', secondSchool.genderType ?? 'Not available']),
            _comparisonRow('School Type', [firstSchool.schoolMode ?? 'Not available', secondSchool.schoolMode ?? 'Not available']),
            _ratingsComparison('Ratings', firstSchool.ratings ?? 0, secondSchool.ratings ?? 0),
          ],
        ),
      ),
    );
  }

  Widget _buildSimpleSchoolCard(SchoolCardModel school) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // School image placeholder
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.school, size: 40, color: Colors.blue),
          ),
          const SizedBox(height: 8),
          // School name
          Text(
            school.name ?? 'School Name',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
  
  Widget _comparisonRow(String label, List<String> values) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Text(label, style: TextStyle(fontWeight: FontWeight.bold, color: SColor.primaryColor, fontSize: 16)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: _comparisonCell(values[0])),
            const SizedBox(width: 10),
            Expanded(child: _comparisonCell(values[1])),
          ],
        ),
      ],
    );
  }

  Widget _comparisonCell(String text) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(border: Border.all(color: SColor.primaryColor)),
      child: Text(text, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w500)),
    );
  }
  
  Widget _ratingsComparison(String label, int firstRating, int secondRating) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Text(label, style: TextStyle(fontWeight: FontWeight.bold, color: SColor.primaryColor, fontSize: 16)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: _ratingCell(firstRating)),
            const SizedBox(width: 10),
            Expanded(child: _ratingCell(secondRating)),
          ],
        ),
      ],
    );
  }

  Widget _ratingCell(int rating) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(border: Border.all(color: SColor.primaryColor)),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(5, (index) => 
            Icon(index < rating ? Icons.star : Icons.star_outline, color: SColor.primaryColor, size: 20))
          ),
          const SizedBox(height: 4),
          Text('$rating/5', style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}