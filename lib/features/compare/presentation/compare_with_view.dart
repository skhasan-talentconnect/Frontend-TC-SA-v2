import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/navigation/route_name.dart';

class CompareWith extends StatefulWidget {
  final SchoolCardModel school;
  const CompareWith({super.key, required this.school});

  @override
  State<CompareWith> createState() => _CompareWithState();
}

class _CompareWithState extends State<CompareWith> {
  bool showShortlistedOnly = false;
  String searchText = '';

  final List<SchoolCardModel> allSchools = [
    SchoolCardModel(
      schoolId: "1", ratings: 4, name: "Green Valley High School",
      feeRange: "₹25,000 - ₹50,000", location: "Mumbai, Maharashtra",
      board: "CBSE", genderType: "Co-educational", shifts: ["Morning"], schoolMode: "Private",
    ),
    SchoolCardModel(
      schoolId: "2", ratings: 5, name: "Sunrise International School",
      feeRange: "₹1 Lakh - ₹2 Lakh", location: "Delhi, Delhi",
      board: "IB", genderType: "Co-educational", shifts: ["Morning", "Afternoon"], schoolMode: "Convent",
    ),
    SchoolCardModel(
      schoolId: "3", ratings: 3, name: "St. Mary's Convent",
      feeRange: "₹10,000 - ₹25,000", location: "Pune, Maharashtra",
      board: "ICSE", genderType: "Girls Only", shifts: ["Morning"], schoolMode: "Convent",
    ),
    SchoolCardModel(
      schoolId: "4", ratings: 2, name: "Govt. Boys High School",
      feeRange: "₹1,000 - ₹10,000", location: "Lucknow, Uttar Pradesh",
      board: "STATE", genderType: "Boys Only", shifts: ["Afternoon"], schoolMode: "Government",
    ),
  ];

  List<SchoolCardModel> get filteredSchools {
    List<SchoolCardModel> schools = showShortlistedOnly ? allSchools.sublist(0, 2) : allSchools;
    
    // Remove current school
    schools = schools.where((s) => s.schoolId != widget.school.schoolId).toList();
    
    // Apply search filter
    if (searchText.isNotEmpty) {
      schools = schools.where((school) =>
        school.name!.toLowerCase().contains(searchText.toLowerCase()) ||
        school.location!.toLowerCase().contains(searchText.toLowerCase())
      ).toList();
    }
    
    return schools;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Choose School', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Compare. Decide. Succeed.", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
              const SizedBox(height: 4),
              Text("Compare With", style: TextStyle(fontWeight: FontWeight.bold, color: SColor.primaryColor, fontSize: 33)),
              const SizedBox(height: 22),
              Text("Select From Shortlisted Schools or\nSearch Other", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19, color: SColor.primaryColor)),

              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 36,
                      decoration: BoxDecoration(border: Border.all(color: SColor.primaryColor)),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          Icon(Icons.search, size: 18, color: SColor.primaryColor),
                          const SizedBox(width: 6),
                          Expanded(
                            child: TextField(
                              decoration: const InputDecoration(hintText: "Search", hintStyle: TextStyle(fontSize: 13), border: InputBorder.none, isDense: true),
                              onChanged: (value) => setState(() => searchText = value),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () => setState(() => showShortlistedOnly = !showShortlistedOnly),
                    child: Container(
                      height: 36,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: SColor.primaryColor),
                        color: showShortlistedOnly ? SColor.primaryColor : Colors.transparent,
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.filter_list, size: 16, color: showShortlistedOnly ? Colors.white : SColor.primaryColor),
                          const SizedBox(width: 4),
                          Text(
                            showShortlistedOnly ? "Showing Shortlisted" : "Shortlisted Schools",
                            style: TextStyle(fontSize: 13, color: showShortlistedOnly ? Colors.white : Colors.black, fontWeight: showShortlistedOnly ? FontWeight.bold : FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              filteredSchools.isEmpty
                  ? const Padding(padding: EdgeInsets.only(top: 30.0), child: Center(child: Text("No schools found", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))))
                  : ListView.separated(
                      separatorBuilder: (_, index) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        SchoolCardModel school = filteredSchools[index];
                        return _buildSchoolCardWithCompareButton(school);
                      },
                      itemCount: filteredSchools.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSchoolCardWithCompareButton(SchoolCardModel school) {
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
          // School Card Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        school.name ?? 'School Name',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: SColor.primaryColor, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          '${school.ratings ?? 0}/5',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: SColor.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  school.location ?? 'Location not available',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildInfoChip(school.board ?? 'Board'),
                    const SizedBox(width: 8),
                    _buildInfoChip(school.genderType ?? 'Gender'),
                    const SizedBox(width: 8),
                    _buildInfoChip(school.schoolMode ?? 'Type'),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  school.feeRange ?? 'Fee not available',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          
          // Compare Button
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey[200],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.pushNamed(
                    RouteNames.compare,
                    extra: {
                      'firstSchool': widget.school,
                      'secondSchool': school,
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: SColor.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  'Select to Compare',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String text) {
    return Container(
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
}