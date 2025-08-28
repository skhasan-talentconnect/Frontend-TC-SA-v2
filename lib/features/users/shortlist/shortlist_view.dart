import 'package:flutter/material.dart';

class ShortlistedSchoolsPage extends StatefulWidget {
  const ShortlistedSchoolsPage({super.key});

  @override
  State<ShortlistedSchoolsPage> createState() =>
      _ShortlistedCollegesPageState();
}

class _ShortlistedCollegesPageState extends State<ShortlistedSchoolsPage> {
  int shortlistedCollegesCount = 0; // Variable to hold the count

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          //padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  height: 30,
                  width: 30,
                  
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Shortlisted Colleges (0)",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 26,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Explore the colleges you've saved for future reference.",
                style: TextStyle(fontSize: 15, color: Colors.black), // Changed from white to black
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Add your college list items here
                ],
              ),
              Center(
                child: Text(
                  "No Colleges Shortlisted",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}