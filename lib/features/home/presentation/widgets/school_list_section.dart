import 'package:flutter/material.dart';
import 'package:tc_sa/common/index.dart';

class SchoolListSection extends StatefulWidget {
  const SchoolListSection({
    required this.title,
    required this.schools,
    super.key,
  });

  final String title;
  final List<SchoolCardModel> schools;

  @override
  State<SchoolListSection> createState() => _SchoolListSectionState();
}

class _SchoolListSectionState extends State<SchoolListSection> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return widget.schools.isNotEmpty
        ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16,
                children: [
                  Text(widget.title, style: STextStyles.s20W600),

                  // // Filters
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 8),
                  //   child: Container(
                  //     height: 50,
                  //     child: ListView.builder(
                  //       itemBuilder: (context, index) {
                  //         final isAll = index == 0;
                  //         final filterTitle =
                  //             isAll ? 'All' : profile.interestedStreams[index - 1];
                  //
                  //         return Row(
                  //           mainAxisSize: MainAxisSize.min,
                  //           children: [
                  //             Filter(
                  //               title: filterTitle,
                  //               section: title,
                  //               onStreamSelected: (stream) {
                  //                 setState(() {
                  //                   if (stream == 'All') {
                  //                     selectedStreamsBySection.remove(title);
                  //                   } else {
                  //                     selectedStreamsBySection[title] = stream;
                  //                   }
                  //                 });
                  //               },
                  //             ),
                  //             const SizedBox(width: 8),
                  //           ],
                  //         );
                  //       },
                  //       itemCount: profile.interestedStreams.length + 1,
                  //       shrinkWrap: true,
                  //       scrollDirection: Axis.horizontal,
                  //     ),
                  //   ),
                  // ),
                  //
                  // const SizedBox(height: 10),

                  // Cards
                  SizedBox(
                    height: 420,
                    child: ListView.separated(
                      controller: scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.schools.length,
                      separatorBuilder: (_, index) => const SizedBox(width: 8),
                      itemBuilder:
                          (_, index) => SchoolCard(
                            school: widget.schools[index],
                            width: 0.75,
                          ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: const CircleBorder(),
                    side: BorderSide(color: SColor.borderColor),
                    padding: const EdgeInsets.all(10),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                  ).copyWith(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  onPressed: () {
                    scrollController.animateTo(
                      scrollController.offset - 300,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 18,
                    color: SColor.secTextColor,
                  ),
                ),
                const SizedBox(width: 12),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: const CircleBorder(),
                    side: BorderSide(color: SColor.borderColor),
                    padding: const EdgeInsets.all(10),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                  ).copyWith(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  onPressed: () {
                    scrollController.animateTo(
                      scrollController.offset + 300,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: SColor.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        )
        : SizedBox.shrink();
  }
}
