import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/detailPages/faculty/presentation/widgets/faculty_widgets.dart';
import 'view_models/faculty_view_model.dart';



class FacultyView extends StatefulWidget {
  const FacultyView({super.key,required this.schoolId});
final  String schoolId;
  @override
  State<FacultyView> createState() => _FacultyViewState();
}

class _FacultyViewState extends State<FacultyView> {
  final FacultyViewModel _vm = FacultyViewModel();
  // String _schoolId = '';
  // String _schoolName = 'Faculty';
  // bool _isInitialized = false;

@override
  void initState(){
      super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _vm.getFacultyBySchoolId(schoolId: widget.schoolId);
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
  //     _schoolName = extra['schoolName'] as String? ?? 'Faculty';
  //   }

  //   if (_schoolId.isNotEmpty) {
  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       _vm.getFacultyBySchoolId(schoolId: _schoolId);
  //     });
  //   }
  // }

  Future<void> _refresh() async {
    if (widget.schoolId.isNotEmpty) {
      await _vm.getFacultyBySchoolId(schoolId: widget.schoolId);
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
        // appBar: SAppBar(
        //   title: wschoolName,
        //   leading: SIcon(
        //     icon: Icons.keyboard_arrow_left,
        //     onTap: () => context.pop(),
        //   ),
        // ),
        body: Consumer<FacultyViewModel>(
          builder: (context, vm, _) {
            if (vm.viewState == ViewState.busy) {
              return const Center(child: SLoadingIndicator());
            }

            final facultyMembers = vm.faculty?.facultyMembers ?? [];

            if (facultyMembers.isEmpty) {
              return Center(child: Text(vm.message ?? "No faculty data found."));
            }

            return RefreshIndicator(
              onRefresh: _refresh,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  // --- 1. ADDED THE CENTERED TITLE ---
                  Center(
                    child: Text(
                      'Faculty Details',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 16.0), 

                  ...facultyMembers.map((member) {
                    return FacultyMemberCard(member: member);
                  }).toList(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}