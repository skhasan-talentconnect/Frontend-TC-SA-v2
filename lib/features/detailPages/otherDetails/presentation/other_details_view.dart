import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/detailPages/otherDetails/presentation/view_models/otherDetails_view_model.dart';
import 'package:tc_sa/features/detailPages/otherDetails/presentation/widgets/gender_ratio_card.dart';
import 'package:tc_sa/features/detailPages/otherDetails/presentation/widgets/scholarship_available.dart';
import 'package:tc_sa/features/detailPages/otherDetails/presentation/widgets/special_needs_card.dart';

class OtherDetailsView extends StatefulWidget {
  const OtherDetailsView({super.key});

  @override
  State<OtherDetailsView> createState() => _OtherDetailsViewState();
}

class _OtherDetailsViewState extends State<OtherDetailsView> {
  final OtherDetailsViewModel _vm = OtherDetailsViewModel();
  String _schoolId = '';
  String _schoolName = 'Other Details';
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInitialized) return;
    _isInitialized = true;

    final extra = GoRouterState.of(context).extra;
    if (extra is Map) {
      _schoolId = extra['schoolId'] as String? ?? '';
      _schoolName = extra['schoolName'] as String? ?? 'Other Details';
    }

    if (_schoolId.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _vm.getOtherDetailsBySchoolId(schoolId: _schoolId);
      });
    }
  }

  Future<void> _refresh() async {
    if (_schoolId.isNotEmpty) {
      await _vm.getOtherDetailsBySchoolId(schoolId: _schoolId);
    }
  }

  @override
  void dispose() {
    _vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _vm,
      child: Scaffold(
        appBar: SAppBar(
          title: _schoolName,
          leading: SIcon(
            icon: Icons.keyboard_arrow_left,
            onTap: () => context.pop(),
          ),
        ),
        body: Consumer<OtherDetailsViewModel>(
          builder: (context, vm, _) {
            if (vm.viewState == ViewState.busy) {
              return const Center(child: SLoadingIndicator());
            }

            final model = vm.otherDetails;

            if (model == null) {
              return Center(child: Text(vm.message ?? "No data found."));
            }

            return RefreshIndicator(
              onRefresh: _refresh,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  if (model.genderRatio != null)
                    GenderRatioCard(ratio: model.genderRatio!),
                  
                  const SizedBox(height: 20),
                  
                  if (model.scholarshipDiversity != null)
                    ScholarshipDiversityCard(diversityData: model.scholarshipDiversity!),
                  
                  const SizedBox(height: 20),

                  if (model.specialNeedsSupport != null)
                    SpecialNeedsCard(supportData: model.specialNeedsSupport!),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}