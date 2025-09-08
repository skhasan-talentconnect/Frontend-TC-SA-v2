import 'package:flutter/material.dart';
import 'package:tc_sa/common/index.dart';

class CompareSchoolsWidgets {
  const CompareSchoolsWidgets._();

  static Widget headerBlock() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Compare. Decide. Succeed!',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
      ],
    );
  }

  static Widget sectionTitle(String text) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: SColor.primaryColor,
        fontSize: 33,
      ),
    );
  }

  static Widget sectionSubtitle(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 15, color: Colors.black87),
    );
  }

  static Widget simpleCard(String name) => Container(
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
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
        Text(
          name,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );

  static Widget dataRow(String label, List<String> values) => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const SizedBox(height: 16),
      Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: SColor.primaryColor,
          fontSize: 16,
        ),
      ),
      const SizedBox(height: 8),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: cell(values[0])),
          const SizedBox(width: 10),
          Expanded(child: cell(values[1])),
        ],
      ),
    ],
  );

  static Widget cell(String text) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(border: Border.all(color: SColor.primaryColor)),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(fontWeight: FontWeight.w500),
    ),
  );

  static String fmtStr(dynamic v) =>
      (v == null || (v is String && v.trim().isEmpty)) ? '-' : '$v';

  static String fmtJoin(dynamic v) =>
      (v is List && v.isNotEmpty) ? v.join(', ') : '-';
}
