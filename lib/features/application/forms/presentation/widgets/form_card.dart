import 'package:flutter/material.dart' hide Form;
import 'package:go_router/go_router.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/application/forms/index.dart';

class FormCard extends StatelessWidget {
  const FormCard({required this.appliedForm, super.key});
  final Form appliedForm;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(RouteNames.formDetails, extra: appliedForm.sId);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: SColor.backgroundColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              spreadRadius: 1,
              color: Colors.black.withOpacity(0.2),
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          spacing: 12,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: [
                  Text(
                    appliedForm.school?.name ??
                        'School Name School Name School Name School Name',
                    style: STextStyles.s16W600.copyWith(
                      color: SColor.secTextColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Status: ',
                        style: STextStyles.s14W400.copyWith(
                          color: SColor.secTextColor,
                        ),
                      ),
                      Text(
                        appliedForm.status?.label ?? '',
                        style: STextStyles.s14W600.copyWith(
                          color: appliedForm.status?.color,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(),
            SIcon(icon: Icons.file_copy, onTap: () {}),
            SIcon(icon: Icons.keyboard_arrow_right, onTap: () {}),
          ],
        ),
      ),
    );
  }
}
