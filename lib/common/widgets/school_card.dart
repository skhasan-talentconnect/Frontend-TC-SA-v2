import 'package:flutter/material.dart';
import 'package:tc_sa/common/index.dart';

class SchoolCard extends StatelessWidget {
  const SchoolCard({required this.school, this.width = 0.8, super.key});

  final SchoolCardModel school;
  final double width;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: size.width * width,
        height: 420,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: SColor.primaryColor),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.grey),
                  child: Icon(
                    Icons.image,
                    color: Colors.grey.shade700,
                    size: 48,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            school.name ?? 'College Name',
                            style: STextStyles.s18W600.copyWith(
                              color: SColor.secTextColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            for (int i = 0; i < 5; i++)
                              Icon(
                                i < (school.ratings ?? 0)
                                    ? Icons.star
                                    : Icons.star_outline,
                                color: SColor.primaryColor,
                                size: 16,
                              ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          spacing: 16,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 4,
                                children: [
                                  Text(
                                    'Boards Offered',
                                    style: STextStyles.s14W400.copyWith(
                                      color: SColor.secTextColor,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                  Text(
                                    school.board ?? '-',
                                    style: STextStyles.s14W600.copyWith(
                                      color: SColor.secTextColor,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 4,
                                children: [
                                  Text(
                                    'Fee Range',
                                    style: STextStyles.s14W400.copyWith(
                                      color: SColor.secTextColor,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                  Text(
                                    school.feeRange ?? '-',
                                    style: STextStyles.s14W600.copyWith(
                                      color: SColor.secTextColor,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 4,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: SColor.secTextColor,
                              size: 20,
                            ),
                            Text(
                              school.location ?? '-',
                              style: STextStyles.s12W600.copyWith(
                                color: SColor.secTextColor,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.2),
                ),
                child: SIcon(icon: Icons.bookmark_outline, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
