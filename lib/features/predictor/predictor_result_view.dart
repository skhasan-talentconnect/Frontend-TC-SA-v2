import 'package:flutter/material.dart';

class SchoolResultsPage extends StatefulWidget {
  const SchoolResultsPage({super.key});

  @override
  State<SchoolResultsPage> createState() => _SchoolResultPageState();
}

class _SchoolResultPageState extends State<SchoolResultsPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body:  SafeArea(
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Predict Your Rank. Find Your College.",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "College Predictor",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Your personalized college recommendations based on your score.",
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  const SizedBox(height: 24),

                  Row(
                    children: [
                      // Expanded(
                      //   child: OutlinedButton.icon(
                      //     onPressed: () {},
                      //     icon: const Icon(Icons.filter_list, color: Colors.black),
                      //     label: const Text("Filter", style: TextStyle(color: Colors.black)),
                      //     style: OutlinedButton.styleFrom(
                      //       foregroundColor: Colors.black,
                      //       side: const BorderSide(color: Colors.black),
                      //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                      //       padding: const EdgeInsets.symmetric(vertical: 12),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 40,
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () {

                             
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                "Edit Preferences",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                ]
              ),
            ),
          ),
        );}}