import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/detailPages/admission-timeline/presentation/view_models/admission_view_model.dart';
import 'package:tc_sa/features/detailPages/admission-timeline/presentation/widgets/admission_widgets.dart';



class AdmissionTimelineView extends StatefulWidget {
  const AdmissionTimelineView({super.key, required this.schoolId});
  final String schoolId;
  @override
  State<AdmissionTimelineView> createState() => _AdmissionTimelineViewState();
}

class _AdmissionTimelineViewState extends State<AdmissionTimelineView> {
  final AdmissionTimelineViewModel _vm = AdmissionTimelineViewModel();
  // String _schoolId = '';
  // String _schoolName = 'Admission Timeline';
  // bool _isInitialized = false;
  @override
void initState(){
    super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
        _vm.getAdmissionTimelineBySchoolId(schoolId: widget.schoolId);
      });
}
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   if (_isInitialized) return;
  //   _isInitialized = true;

  //   final extra = GoRouterState.of(context).extra;
  //   if (extra is Map) {
  //     _schoolId = extra['schoolId'] as String? ?? '';
  //     _schoolName = extra['schoolName'] as String? ?? 'Admission Timeline';
  //   }

  //   if (_schoolId.isNotEmpty) {
  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       _vm.getAdmissionTimelineBySchoolId(schoolId: _schoolId);
  //     });
  //   }
  // }

  Future<void> _refresh() async {
    if (widget.schoolId.isNotEmpty) {
      await _vm.getAdmissionTimelineBySchoolId(schoolId: widget.schoolId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _vm,
      child: Scaffold(
        // appBar: SAppBar(
        //   title: _schoolName,
        //   leading: SIcon(
        //     icon: Icons.keyboard_arrow_left,
        //     onTap: () => context.pop(),
        //   ),
        // ),
        body: Consumer<AdmissionTimelineViewModel>(
          builder: (context, vm, _) {
            if (vm.viewState == ViewState.busy) {
              return const Center(child: SLoadingIndicator());
            }

            final timelines = vm.admissionTimeline?.timelines ?? [];

            if (timelines.isEmpty) {
              return Center(child: Text(vm.message ?? "No admission timeline data found."));
            }

            return RefreshIndicator(
              onRefresh: _refresh,
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: timelines.length,
                itemBuilder: (context, index) {
                  // --- 2. USE THE PUBLIC WIDGET ---
                  return TimelineCard(timeline: timelines[index]);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

// --- 3. REMOVE THE HELPER WIDGETS FROM THIS FILE ---
// The _TimelineCard and _InfoRow classes are now in their own file.