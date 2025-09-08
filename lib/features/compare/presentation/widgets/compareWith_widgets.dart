import 'package:flutter/material.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/common/widgets/s_button.dart';

class CompareWithWidgets {
  const CompareWithWidgets._();

  // Search + shortlisted toggle row
  static Widget searchAndFilterRow({
    required String searchText,
    required bool showShortlistedOnly,
    required ValueChanged<String> onSearchChanged,
    required VoidCallback onToggleShortlist,
  }) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 36,
            decoration: BoxDecoration(
              border: Border.all(color: SColor.primaryColor),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Icon(Icons.search, size: 18, color: SColor.primaryColor),
                const SizedBox(width: 6),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: "Search",
                      hintStyle: TextStyle(fontSize: 13),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    onChanged: onSearchChanged,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        InkWell(
          onTap: onToggleShortlist,
          child: Container(
            height: 36,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: SColor.primaryColor),
              color: showShortlistedOnly ? SColor.primaryColor : Colors.transparent,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.filter_list,
                  size: 16,
                  color: showShortlistedOnly ? Colors.white : SColor.primaryColor,
                ),
                const SizedBox(width: 4),
                Text(
                  showShortlistedOnly ? "Showing Shortlisted" : "Shortlisted Schools",
                  style: TextStyle(
                    fontSize: 13,
                    color: showShortlistedOnly ? Colors.white : Colors.black,
                    fontWeight: showShortlistedOnly ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // “Base school” preview label
  static Widget basePreview(String baseName) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 12),
      child: Row(
        children: [
          const Icon(Icons.push_pin, size: 16),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              "Base School: $baseName",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  // List item tile for a school with the compare button
  static Widget schoolTile(
    SchoolCardModel s, {
    required VoidCallback onCompare,
  }) {
    return Container(
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
          // Card content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Expanded(
                    child: Text(
                      s.name ?? 'School Name',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: SColor.primaryColor, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        '${s.ratings ?? 0}/5',
                        style: TextStyle(fontWeight: FontWeight.bold, color: SColor.primaryColor),
                      ),
                    ],
                  ),
                ]),
                const SizedBox(height: 8),
                Text(
                  s.location ?? 'Location not available',
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _chip(s.board ?? 'Board'),
                    const SizedBox(width: 8),
                    _chip(s.genderType ?? 'Gender'),
                    const SizedBox(width: 8),
                    _chip(s.schoolMode ?? 'Type'),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  s.feeRange ?? 'Fee not available',
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
              ],
            ),
          ),
          // Compare Button (SButton)
          Container(width: double.infinity, height: 1, color: Colors.grey[200]),
          Padding(
            padding: const EdgeInsets.all(12),
            child: SButton(
              max: true,
              label: 'Select to Compare',
              onPressed: onCompare,
            ),
          ),
        ],
      ),
    );
  }

  // small chip
  static Widget _chip(String text) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: SColor.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: SColor.primaryColor.withOpacity(0.3)),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: SColor.primaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
}
