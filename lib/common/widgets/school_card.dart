import 'package:flutter/material.dart';
import 'package:tc_sa/common/index.dart';

class SchoolCard extends StatelessWidget {
  const SchoolCard({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Container(
      width: size.width * 0.6,
      height: size.width * 0.9,
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
              Expanded(
                child: Container(
                  decoration: BoxDecoration(color: Colors.grey),
                  child: Text('ash'),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    spacing: 12,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'College Name College Name College Name College Name',
                        style: STextStyles.s18W600.copyWith(
                          color: SColor.secTextColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'College Name',
                                style: STextStyles.s14W600.copyWith(
                                  color: SColor.secTextColor,
                                ),
                              ),
                              Text(
                                'College Name',
                                style: STextStyles.s14W400.copyWith(
                                  color: SColor.secTextColor,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Fee Range',
                                style: STextStyles.s14W600.copyWith(
                                  color: SColor.secTextColor,
                                ),
                              ),
                              Text(
                                'College Name',
                                style: STextStyles.s14W400.copyWith(
                                  color: SColor.secTextColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'College Name',
                                style: STextStyles.s14W600.copyWith(
                                  color: SColor.secTextColor,
                                ),
                              ),
                              Text(
                                'College Name',
                                style: STextStyles.s14W400.copyWith(
                                  color: SColor.secTextColor,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'College Name',
                                style: STextStyles.s14W600.copyWith(
                                  color: SColor.secTextColor,
                                ),
                              ),
                              Text(
                                'College Name',
                                style: STextStyles.s14W400.copyWith(
                                  color: SColor.secTextColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
              child: Icon(Icons.save),
            ),
          ),
        ],
      ),
    );
  }
}
