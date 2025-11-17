import 'package:flutter/material.dart' hide Form;
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/extensions/failure_ext.dart';
import 'package:tc_sa/features/application/forms/presentation/view_models/my_form_view_model.dart';
import 'package:tc_sa/features/application/forms/presentation/widgets/form_card.dart';

class MyFormViews extends StatefulWidget {
  const MyFormViews({super.key});

  @override
  State<MyFormViews> createState() => _MyFormViewsState();
}

class _MyFormViewsState extends State<MyFormViews> {
  MyFormViewModel myFormViewModel = MyFormViewModel();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final failure = await myFormViewModel.getForms();
      failure?.showError(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: myFormViewModel,
      child: Scaffold(
        body: Selector<MyFormViewModel, bool>(
          selector: (_, vm) => vm.isLoading,
          builder:
              (_, isLoading, __) =>
                  isLoading
                      ? Center(child: SLoadingIndicator())
                      : SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          spacing: 20,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 8,
                              children: [
                                SizedBox.shrink(),
                                Text(
                                  'Applied Forms',
                                  style: STextStyles.s20W600,
                                ),
                                Text(
                                  'All the applied forms.',
                                  style: STextStyles.s16W400,
                                ),
                              ],
                            ),
                            ListView.builder(
  physics: const NeverScrollableScrollPhysics(),
  shrinkWrap: true,
  itemCount: myFormViewModel.forms.length,
  itemBuilder: (context, index) {
    final form = myFormViewModel.forms[index];
    final applicantName = form.application?.name ?? "Unknown Applicant";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          applicantName,
          style: STextStyles.s16W600.copyWith(color: SColor.secTextColor),
        ),
        const SizedBox(height: 8),
        FormCard(appliedForm: form),
        const Divider(thickness: 1, height: 24),
      ],
    );
  },
),

                          ],
                        ),
                      ),
        ),
      ),
    );
  }
}
