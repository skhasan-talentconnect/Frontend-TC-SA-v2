import 'package:flutter/material.dart';
import 'package:tc_sa/common/index.dart' show SColor, STextStyles, SchoolCard;

class SearchResultsPage extends StatelessWidget {
  const SearchResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Result Schools",
          style: STextStyles.s22W600.copyWith(color: SColor.primaryColor),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // School cards list
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return SchoolCard();
                },
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                itemCount: 3,
                shrinkWrap: true,
                
              ),
            ),
            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }
}