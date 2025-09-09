import 'package:flutter/material.dart' hide Form;
import 'package:go_router/go_router.dart';
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
        appBar: SAppBar(
          leading: SIcon(
            icon: Icons.keyboard_arrow_left,
            onTap: () {
              context.pop(context);
            },
          ),
          title: 'Applied Forms',
        ),

        body: Selector<MyFormViewModel, bool>(
          selector: (_, vm) => vm.isLoading,
          builder:
              (_, isLoading, __) =>
                  isLoading
                      ? Center(child: SLoadingIndicator())
                      : SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        child: Column(
                          children: [
                            ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return FormCard(
                                  appliedForm: myFormViewModel.forms[index],
                                );
                              },
                              separatorBuilder:
                                  (_, __) => const SizedBox(height: 16),
                              itemCount: myFormViewModel.forms.length,
                            ),
                          ],
                        ),
                      ),
        ),
      ),
    );
  }
}
