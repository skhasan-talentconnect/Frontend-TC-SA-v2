import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/common/theme_provider.dart';
import 'package:tc_sa/core/navigation/route_name.dart';

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
                    final colors = context.watch<ThemeProvider>().colors;

    return widget.schools.isNotEmpty
        ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.blue.shade50,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16,
                children: [
                  Text(widget.title, style: STextStyles.s20W600),
                  SizedBox(
                    height: 420,
                    child: ListView.separated(
                      controller: scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.schools.length,
                      separatorBuilder: (_, index) => const SizedBox(width: 12),
                      itemBuilder:
                          (_, index) => GestureDetector(
                            onTap: () {
                              context.pushNamed(RouteNames.overview);
                            },
                            child: SchoolCard(
                              school: widget.schools[index],
                              width: 0.70,
                            ),
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
                    side: BorderSide(color: colors.borderColor),
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
                    color: colors.secTextColor,
                  ),
                ),
                const SizedBox(width: 12),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: const CircleBorder(),
                    side: BorderSide(color: colors.borderColor),
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
                    color: colors.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        )
        : SizedBox.shrink();
  }
}
