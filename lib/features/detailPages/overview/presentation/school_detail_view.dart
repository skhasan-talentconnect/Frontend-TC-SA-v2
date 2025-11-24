import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/core/common/theme_provider.dart';
import 'package:tc_sa/core/extensions/failure_ext.dart';
import 'package:tc_sa/core/navigation/not_found_view.dart';
import 'package:tc_sa/features/detailPages/academics/presentation/academics_view.dart';
import 'package:tc_sa/features/detailPages/activities/presentation/activities_view.dart';
import 'package:tc_sa/features/detailPages/admission-timeline/data/entities/admission-model.dart';
import 'package:tc_sa/features/detailPages/admission-timeline/presentation/admission_timeline_view.dart';
import 'package:tc_sa/features/detailPages/admission-timeline/presentation/view_models/admission_view_model.dart';
import 'package:tc_sa/features/detailPages/alumini/presentation/alumini_view.dart';
import 'package:tc_sa/features/detailPages/amenity/presentation/amenity_view.dart';
import 'package:tc_sa/features/detailPages/faculty/presentation/faculty_view.dart';
import 'package:tc_sa/features/detailPages/feeAndScholarship/presentation/fees_scholarship_view.dart';
import 'package:tc_sa/features/detailPages/infrastructure/presentation/infrastructure_view.dart';
import 'package:tc_sa/features/detailPages/internationalExposure/presentation/international_view.dart';
import 'package:tc_sa/features/detailPages/otherDetails/presentation/other_details_view.dart';
import 'package:tc_sa/features/detailPages/overview/presentation/overview_view.dart';
import 'package:tc_sa/features/detailPages/overview/presentation/view_models/overview_view_model.dart';
import 'package:tc_sa/features/detailPages/overview/presentation/widgets/custom_tab.dart';
import 'package:tc_sa/features/detailPages/overview/presentation/widgets/info_chip_widget.dart';
import 'package:tc_sa/features/detailPages/overview/utils/enums.dart';
import 'package:tc_sa/features/detailPages/photos/photos_view.dart';
import 'package:tc_sa/features/detailPages/reviews/presentation/reviews_view.dart';
import 'package:tc_sa/features/detailPages/safetySecurity/presentation/safetySecurity_view.dart';
import 'package:tc_sa/features/detailPages/technologyAdaption/presentation/tech_adaption_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../common/models/user_pref.dart';
import '../../../../common/theme/s_colors.dart';
import '../../../../common/widgets/s_app_bar.dart';
import '../../../../common/widgets/s_button.dart';
import '../../../../common/widgets/s_icon.dart';
import '../../../../common/widgets/s_loading_indicator.dart';
import '../../../../core/common/app_state_provider.dart';
import '../../../../core/navigation/route_name.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/utils/toast.dart';
import '../../../application/forms/presentation/view_models/my_form_view_model.dart';
import '../../../application/forms/utils/enums.dart';
import '../../../users/shortlist/presentation/view_models/shortlist_view_model.dart';
import '../data/entities/applied_form_model.dart';
import '../data/entities/overview_model.dart';

class SchoolDetailView2 extends StatefulWidget {
  const SchoolDetailView2({super.key, required this.schoolId, this.distance});

  final String schoolId;
  final String? distance;

  @override
  State<SchoolDetailView2> createState() => _SchoolDetailViewState();
}

class _SchoolDetailViewState extends State<SchoolDetailView2> {
  final OverviewViewModel overviewViewModel = OverviewViewModel();
  final MyFormViewModel myFormViewModel = MyFormViewModel();
  final ShortlistViewModel shortlistViewModel = ShortlistViewModel();
  final appStateProvider = getIt<AppStateProvider>();
final AdmissionTimelineViewModel admissionVm = AdmissionTimelineViewModel();
// keep listener so we can remove it in dispose
VoidCallback? _admissionVmListener;

  final PageController pageController = PageController();

  final ScrollController _tabScrollController = ScrollController();
  late List<GlobalKey> _tabKeys;

  final ValueNotifier<bool> isSaved = ValueNotifier(false);
    int _userApplicationCount = 0;
@override
void dispose() {
  // remove admissionVm listener if attached
  try {
    if (_admissionVmListener != null) {
      admissionVm.removeListener(_admissionVmListener!);
      _admissionVmListener = null;
    }
  } catch (_) {}

  // dispose admission view model
  try {
    admissionVm.dispose();
  } catch (_) {}

  // existing controllers
  _tabScrollController.dispose();
  pageController.dispose();

  super.dispose();
}

  @override
  void initState() {
    super.initState();
WidgetsBinding.instance.addPostFrameCallback((_) async {
  // 1) load school
  final failure = await overviewViewModel.getSchoolsById(
    id: widget.schoolId,
  );
  failure?.showError(context);

  // 2) check if user already applied to this school
  await overviewViewModel.getIsAppliedSchool(schoolId: widget.schoolId);

  // 3) shortlist state
  isSaved.value = getIt<AppStateProvider>().isSaved(widget.schoolId);

  // --- NEW: prefetch student's generated PDFs so we know how many applications they have
  try {
    final studId = getIt<AppStateProvider>().user?.sId;
    if (studId != null && studId.isNotEmpty) {
      final pdfFailure = await myFormViewModel.fetchStudentPdfs(studId: studId);
      if (pdfFailure == null) {
        final pdfs = myFormViewModel.availablePdfs;
        if (pdfs != null) {
          setState(() {
            _userApplicationCount = pdfs.length;
          });
        }
      }
    }
  } catch (_) {
    // ignore prefetch errors — we'll fetch again when user presses Apply
  }

  // --- NEW: fetch admission timeline for this school so we can show application fees
  try {
    // start fetch
    admissionVm.getAdmissionTimelineBySchoolId(schoolId: widget.schoolId);

    // attach a listener so UI refreshes when timeline finishes loading
    _admissionVmListener = () {
      if (mounted) setState(() {});
    };
    admissionVm.addListener(_admissionVmListener!);
  } catch (_) {
    // ignore timeline fetch errors; UI will show '-' for fees
  }
});


    _tabKeys = List.generate(DetailTabEnum.values.length, (_) => GlobalKey());
  }

  @override
  Widget build(BuildContext context) {
     final colors = context.watch<ThemeProvider>().colors;
  return MultiProvider(
  providers: [
    ChangeNotifierProvider<OverviewViewModel>.value(value: overviewViewModel),
    ChangeNotifierProvider<MyFormViewModel>.value(value: myFormViewModel),
    ChangeNotifierProvider<ShortlistViewModel>.value(value: shortlistViewModel),
    // you can add more providers here if needed
  ],
  child: Consumer<OverviewViewModel>(
    builder: (vmContext, vm, _) {
          final school = vm.school;

          final size = MediaQuery.of(context).size;
          final isSmall = size.width < 600;
          final isMed = size.width >= 600 && size.width < 900;
          final bannerHeight = isSmall ? 170.0 : (isMed ? 200.0 : 220.0);
          final titleFont = isSmall ? 20.0 : (isMed ? 24.0 : 26.0);
          final infoFont = isSmall ? 16.0 : (isMed ? 18.0 : 20.0);
          final tabFont = isSmall ? 14.0 : (isMed ? 16.0 : 18.0);
          final pad = isSmall ? 14.0 : (isMed ? 16.0 : 16.0);

          if (vm.isLoading) {
            return Scaffold(body: Center(child: SLoadingIndicator()));
          }

          if (school == null) {
            return NotFoundView(isSchool: true);
          }

          final location = [
            school.city,
            school.state,
          ].where((e) => (e ?? '').isNotEmpty).join(", ");

          return Scaffold(
            appBar: SAppBar(
              leading: SIcon(
                icon: Icons.keyboard_arrow_left,
                onTap: () => context.pop(),
              ),
              title: school.name ?? "School",
              actions:
                  !getIt<AppStateProvider>().isGuest
                      ? [
                        ChangeNotifierProvider.value(
                          value: shortlistViewModel,
                          child: Selector<ShortlistViewModel, bool>(
                            selector: (_, vm) => vm.isLoading,
                            builder: (vmContext, isSaving, _) {
                              if (isSaving) {
                                return SLoadingIndicator(
                                  size: 24,
                                  thickness: 3,
                                );
                              }

                              return ValueListenableBuilder(
                                valueListenable: isSaved,
                                builder:
                                    (_, vIsSaved, __) => SIcon(
                                      icon:
                                          !vIsSaved
                                              ? Icons.bookmark_outline
                                              : Icons.bookmark,
                                      color: SColor.secTextColor,
                                      size: 28,
                                      onTap: () async {
                                        final failure;
                                        vIsSaved
                                            ? failure = await shortlistViewModel
                                                .removeShortlist(
                                                  schoolId: widget.schoolId,
                                                )
                                            : failure = await shortlistViewModel
                                                .addShortlist(
                                                  schoolId: widget.schoolId,
                                                );
                                        if (failure == null) {
                                          isSaved.value = !vIsSaved;
                                          Toasts.showSuccessToast(
                                            context,
                                            message:
                                                '${!vIsSaved ? 'Added to' : 'Removed from'} Shortlist',
                                          );
                                        }
                                      },
                                    ),
                              );
                            },
                          ),
                        ),
                      ]
                      : [],
            ),

            body: NestedScrollView(
              headerSliverBuilder:
                  (_, __) => [
                    SliverToBoxAdapter(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Stack(
                            children: [
                              // 📸 Background banner image
                              Container(
                                height: bannerHeight,
                                width: double.infinity,
                                child:
                                    (school.photos != null &&
                                            school.photos!.isNotEmpty)
                                        ? ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            2.0,
                                          ),
                                          child: Image.network(
                                            school.photos!.first.url ?? '',
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (_, __, ___) => Container(
                                                  color: Colors.grey[200],
                                                  child: const Icon(
                                                    Icons.broken_image,
                                                    size: 50,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                          ),
                                        )
                                        : Container(
                                          color: Colors.grey[200],
                                          child: const Center(
                                            child: Icon(
                                              Icons.school,
                                              size: 80,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                              ),

                              // 🎯 Positioned social media icons
                              // 🎯 Positioned social media icons (VERTICAL)
                              // 🎯 Positioned social media icons (VERTICAL with glow)
                              Positioned(
                                top: 8,
                                right: 18,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children:
                                      [
                                            if (school.website != null &&
                                                school.website!.isNotEmpty)
                                              _buildSocialIcon(
                                                assetPath:
                                                    'assets/icons/web.png',
                                                url: school.website!,
                                                // glowColor: Colors.yellow,
                                              ),
                                            if (school.instagramHandle !=
                                                    null &&
                                                school
                                                    .instagramHandle!
                                                    .isNotEmpty)
                                              _buildSocialIcon(
                                                assetPath:
                                                    'assets/icons/insta.png',
                                                url: school.instagramHandle!,
                                                // glowColor: Colors.yellow,
                                              ),
                                            if (school.twitterHandle != null &&
                                                school
                                                    .twitterHandle!
                                                    .isNotEmpty)
                                              _buildSocialIcon(
                                                assetPath:
                                                    'assets/icons/twitter.png',
                                                url: school.twitterHandle!,
                                                //  glowColor: Colors.yellow,
                                              ),
                                            if (school.linkedinHandle != null &&
                                                school
                                                    .linkedinHandle!
                                                    .isNotEmpty)
                                              _buildSocialIcon(
                                                assetPath:
                                                    'assets/icons/linkedIn.png',
                                                url: school.linkedinHandle!,
                                                //  glowColor: Colors.yellow,
                                              ),
                                          ]
                                          .expand(
                                            (widget) => [
                                              const SizedBox(height: 8),
                                              widget,
                                            ],
                                          )
                                          .skip(1)
                                          .toList(),
                                ),
                              ),
                            ],
                          ),
                          // Title + location + buttons
                          Padding(
                            padding: EdgeInsets.all(pad),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  school.name ?? "-",
                                  style: TextStyle(
                                    fontSize: titleFont,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 3),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on, size: 18),
                                    const SizedBox(width: 3),
                                    GestureDetector(
                                      onTap: () async {
                                        if (location.isNotEmpty) {
                                          final query = Uri.encodeComponent(
                                            location,
                                          );
                                          final url = Uri.parse(
                                            "https://www.google.com/maps/search/?api=1&query=${school.name?.split(' ').join('+')}+$query",
                                          );

                                          if (!await launchUrl(
                                            url,
                                            mode:
                                                LaunchMode.externalApplication,
                                          )) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  "Could not open Maps",
                                                ),
                                              ),
                                            );
                                          }
                                        }
                                      },
                                      child: Text(
                                        location.isEmpty ? "-" : location,
                                        style: TextStyle(
                                          fontSize: infoFont,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),

                                    if (widget.distance != null) ...[
                                      const SizedBox(width: 8),

                                      const SizedBox(width: 6),

                                      Text(
                                        "${widget.distance!} away",
                                        style: TextStyle(
                                          fontSize: infoFont - 2,
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: OutlinedButton(
                                        onPressed: () {
                                          context.pushNamed(
                                            RouteNames.compareWith,
                                            extra: {
                                              'id':
                                                  school.id?.toString() ??
                                                  widget.schoolId,
                                              'name': school.name ?? 'School',
                                            },
                                          );
                                        },
                                        style: OutlinedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 15,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                          ),
                                          side: const BorderSide(
                                            color: Colors.green,
                                          ),
                                        ),
                                        child: Text(
                                          "Compare",
                                          style: TextStyle(
                                            fontSize: infoFont,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                Expanded(
  child: ChangeNotifierProvider.value(
    value: myFormViewModel,
    child: Selector<MyFormViewModel, bool>(
      selector: (_, vm) => vm.isLoading,
      builder: (_, isLoading, __) {
        if (isLoading) {
          return const Center(child: SLoadingIndicator(color: Colors.blue));
        }
final isSingleAndApplied = (_userApplicationCount == 1) && (vm.isApplied == true);
       
return SButton(
  onPressed: () async {
    if (isSingleAndApplied) {
      // Show dialog that prompts user to add a new application (force new)
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: const Text('No additional application available'),
            content: const Text('You have already applied using the only available application. Would you like to add a new application?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.pushNamed(
                    RouteNames.addApplication,
                    extra: {'forceNew': true},
                  );
                },
                child: const Text('Fill form'),
              ),
            ],
          );
        },
      );
      return;
    }

    // --- original Apply flow (unchanged) ---
    if (appStateProvider.isGuest) {
      Toasts.showLoginToast(context);
      return;
    }

    final studId = getIt<AppStateProvider>().user?.sId;
    if (studId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Missing student ID.")),
      );
      return;
    }

    final pdfResult = await myFormViewModel.fetchStudentPdfs(studId: studId);
if (pdfResult != null) {
  Toasts.showErrorToast(context, message: pdfResult.message ?? "Failed to fetch PDFs");
  return;
}

final pdfs = myFormViewModel.availablePdfs;
if (pdfs == null || pdfs.isEmpty) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: const Text('No form available'),
            content: const Text('No generated PDFs available. Please fill the form first.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();

                  context.pushNamed(
                    RouteNames.addApplication,
                    extra: {
                      'forceNew': true,
                    },
                  );
                },
                child: const Text('Fill form'),
              ),
            ],
          );
        },
      );
      return;
    }
    await myFormViewModel.prefetchApplicationsForPdfs(pdfs);

    // STEP 2: pick desired application PDF
   final chosenPdfIndex = await showModalBottomSheet<int?>(
  context: context,
  isScrollControlled: true,
  builder: (ctx) {
    // <<< PROVIDE myFormViewModel to the modal subtree so Consumer finds it >>>
    return ChangeNotifierProvider<MyFormViewModel>.value(
  value: myFormViewModel,
  child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Select Application", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: MediaQuery.of(ctx).size.height * 0.6),
                child: Consumer<MyFormViewModel>(
                  builder: (cCtx, mfvm, __) {
                    return ListView.separated(
                      shrinkWrap: true,
                      itemCount: pdfs.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (_, i) {
                        final p = pdfs[i] as Map<String, dynamic>;
                        final title = p['applicationName'] ?? 'Application ${i + 1}';
                        final subtitle = p['createdAt']?.toString().split('T').first ?? '';

                        // 1) obtain applicationId from pdf object
                        final applicationId = (p['applicationId'] ?? p['_id'] ?? p['formId'] ?? '').toString();

                        // 2) get cached StudentApplication if available
                        final app = applicationId.isNotEmpty ? mfvm.applicationCache[applicationId] : null;

                        // 3) read the standard from StudentApplication
                        final pdfStandard = (app?.standard ?? '').toString().trim();

                        // 4) get timelines from admissionVm (typed TimelineEntryModel list)
                        final timelines = admissionVm.admissionTimeline?.timelines ?? <TimelineEntryModel>[];

                        // 5) compute feeText by matching admissionLevel == pdfStandard
                        String feeText = '-';
                        try {
                          if (pdfStandard.isNotEmpty && timelines.isNotEmpty) {
                            TimelineEntryModel? matched;
                            for (final t in timelines) {
                              final level = (t.eligibility?.admissionLevel ?? '').toLowerCase();
                              if (level.isNotEmpty && level == pdfStandard.toLowerCase()) {
                                matched = t;
                                break;
                              }
                            }
                            final feeNum = matched?.applicationFee;
                            if (feeNum != null) {
                              if (feeNum % 1 == 0) {
                                feeText = '₹${feeNum.toInt()}';
                              } else {
                                feeText = '₹${feeNum}';
                              }
                            }
                          }
                        } catch (_) {
                          feeText = '-';
                        }

                        final loading = applicationId.isNotEmpty && mfvm.isAppLoading(applicationId);

                        return ListTile(
                          title: Text(title.toString()),
                          subtitle: subtitle.isNotEmpty ? Text(subtitle) : null,
                          trailing: loading
                              ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2))
                              : Text(feeText, style: const TextStyle(fontWeight: FontWeight.w600)),
                          onTap: () async {
                            if (applicationId.isNotEmpty && mfvm.applicationCache[applicationId] == null) {
                              final err = await mfvm.fetchApplicationById(applicationId: applicationId);
                              if (err != null) {
                                if (ctx.mounted) {
                                  Toasts.showErrorToast(ctx, message: err.message ?? "Failed to load application");
                                }
                                return;
                              }
                            }
                            Navigator.of(ctx).pop(i);
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(null),
                child: const Text("Cancel"),
              ),
            ],
          ),
        ),
      ),
    );
  },
);
    if (chosenPdfIndex == null) return;

    final chosen = pdfs[chosenPdfIndex];

    final formId = chosen['_id']?.toString() ?? "";
    final applicationId = chosen['applicationId']?.toString() ?? "";

    if (formId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid PDF selected.")),
      );
      return;
    }

    // STEP 3: submit form
   final failure = await myFormViewModel.submitForm(
  schoolId: widget.schoolId,
  applicationId: applicationId,
  formId: formId,
);

// Debug: check whether this page is still current / mounted
// (works regardless of go_router version)
try {
  final isCurrent = ModalRoute.of(context)?.isCurrent ?? false;
  // ignore: avoid_print
  print('[Apply] after submit: ModalRoute.isCurrent = $isCurrent');

  final canPop = Navigator.of(context).canPop();
  // ignore: avoid_print
  print('[Apply] after submit: Navigator.canPop = $canPop');
} catch (e) {
  // ignore: avoid_print
  print('[Apply] debug check failed: $e');
}

// Only show UI when still mounted
if (!context.mounted) {
  // ignore: avoid_print
  print('[Apply] context not mounted after submit — page may have been popped.');
  return;
}

if (failure == null) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Application submitted successfully')),
  );
} else {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(failure.message ?? 'Failed to submit application')),
  );
}

  },
  backgroundColor: Colors.blue,
  padding: const EdgeInsets.symmetric(vertical: 14),
  label: '',
  max: true,
  text: Text(
    isSingleAndApplied ? "Apply for other" : "Apply",
    style: TextStyle(
      fontSize: infoFont,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  ),
);
      },
    ),
  ),
),

                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Chips
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: pad,
                              vertical: 6,
                            ),
                            child: Row(
                              spacing: 8,
                              children: [
                                Expanded(
                                  child: Builder(
                                    builder: (_) {
                                      final userPref =
                                          getIt<AppStateProvider>().userPref;
                                      int matchPercentage = 0;
                                      if (userPref != null) {
                                        matchPercentage =
                                            calculateMatchPercentage(
                                              school: school,
                                              userPref: userPref,
                                            );
                                      }
                                      return InfoChip(
                                        topText: "$matchPercentage%",
                                        bottomText: "Preferences",
                                        fontSize: infoFont,
                                        isSmallScreen: isSmall,
                                      );
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: InfoChip(
                                    topText: school.board ?? "-",
                                    bottomText: "Board",
                                    fontSize: infoFont,
                                    isSmallScreen: isSmall,
                                  ),
                                ),
                                Expanded(
                                  child: InfoChip(
                                    topText:
                                        school.createdAt?.split('-').first ??
                                        '-',
                                    bottomText: "Since",
                                    fontSize: infoFont,
                                    isSmallScreen: isSmall,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(color: Colors.grey, width: 0.4),
                                bottom: BorderSide(
                                  color: Colors.grey,
                                  width: 0.4,
                                ),
                              ),
                            ),
                            child: SingleChildScrollView(
                              padding: EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 8,
                              ),
                              scrollDirection: Axis.horizontal,
                              controller: _tabScrollController,

                              child: Row(
                                children: [
                                  ...DetailTabEnum.values.map((tab) {
                                    return GestureDetector(
                                      key:
                                          _tabKeys[tab
                                              .index], 

                                      onTap: () {
                                        vm.currentPageIndex = tab.index;
                                        pageController.animateToPage(
                                          tab.index,
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.ease,
                                        );
                                        _scrollToTab(tab.index);
                                      },
                                      child: CustomTab(
                                        tabName: tab.label,
                                        isSelected:
                                            tab.index == vm.currentPageIndex,
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

              body: PageView(
                controller: pageController,
                onPageChanged: (index) {
                  vm.currentPageIndex = index;
                  _scrollToTab(index);
                },
                children: [
                  OverviewTab(school: vm.school as SchoolModel),
                  AcademicsView(schoolId: widget.schoolId),
                  FacultyView(schoolId: widget.schoolId),
                  InfrastructureView(schoolId: widget.schoolId),
                  TechnologyAdoptionView(schoolId: widget.schoolId),
                  ActivityView(schoolId: widget.schoolId),
                  SafetyAndSecurityView(schoolId: widget.schoolId),
                  InternationalExposureView(schoolId: widget.schoolId),
                  FeesAndScholarshipsView(schoolId: widget.schoolId),
                  AdmissionTimelineView(schoolId: widget.schoolId),
                  AmenitiesView(
                    schoolId: widget.schoolId,
                    photos: school.photos ?? [],
                  ),
                  AlumniView(schoolId: widget.schoolId),
                  ReviewsView(schoolId: widget.schoolId),
                  OtherDetailsView(schoolId: widget.schoolId),
                  PhotosView(photos: vm.school?.photos ?? []),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSocialIcon({
    required String assetPath,
    required String url,
    double size = 32,
    //Color glowColor = Colors.yellow,
  }) {
    // 🚫 Don’t render if the link is missing or invalid
    if (url.isEmpty) return const SizedBox.shrink();

    return InkWell(
      onTap: () async {
        try {
          final uri = Uri.parse(url);
          if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Could not open link')),
              );
            }
          }
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Invalid link')));
          }
        }
      },
      child: Container(
        // decoration: BoxDecoration(
        //   shape: BoxShape.circle,
        //   boxShadow: [
        //     BoxShadow(
        //      // color: glowColor.withOpacity(0.7),
        //       blurRadius: 10,
        //       spreadRadius: 2,
        //     ),
        //   ],
        // ),
        child: ClipOval(
          child: Image.asset(
            assetPath,
            width: size,
            height: size,
            fit: BoxFit.cover,
            errorBuilder:
                (_, __, ___) => const Icon(
                  Icons.broken_image,
                  color: Colors.grey,
                  size: 28,
                ),
          ),
        ),
      ),
    );
  }

  void _scrollToTab(int index) {
    final keyContext = _tabKeys[index].currentContext;
    if (keyContext == null) return;

    // Get the RenderBox for the tab
    final box = keyContext.findRenderObject() as RenderBox?;
    if (box == null) return;

    // ✅ Correct way: use RenderObject of the scroll view as ancestor
    final scrollBox =
        _tabScrollController.position.context.notificationContext
                ?.findRenderObject()
            as RenderBox?;

    if (scrollBox == null) return;

    // Get tab’s position relative to the scrollable area
    final position = box.localToGlobal(Offset.zero, ancestor: scrollBox);

    final tabLeft = position.dx;
    final tabRight = tabLeft + box.size.width;
    final viewportWidth = scrollBox.size.width;

    double targetOffset = _tabScrollController.offset;

    // Scroll left if hidden on the left
    if (tabLeft < 0) {
      targetOffset += tabLeft - 16;
    }
    // Scroll right if hidden on the right
    else if (tabRight > viewportWidth) {
      targetOffset += (tabRight - viewportWidth) + 16;
    }

    _tabScrollController.animateTo(
      targetOffset.clamp(
        _tabScrollController.position.minScrollExtent,
        _tabScrollController.position.maxScrollExtent,
      ),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  int calculateMatchPercentage({
    required SchoolModel school,
    required UserPref userPref,
  }) {
    int totalCriteria = 6;
    int matched = 0;

    // 1. State
    if (userPref.state != null &&
        userPref.state!.isNotEmpty &&
        school.state != null &&
        school.state!.isNotEmpty) {
      if (userPref.state!.toLowerCase() == school.state!.toLowerCase()) {
        matched++;
      }
    }

    // 2. City
    if (userPref.city != null &&
        userPref.city!.isNotEmpty &&
        school.city != null &&
        school.city!.isNotEmpty) {
      if (userPref.city!.toLowerCase() == school.city!.toLowerCase()) {
        matched++;
      }
    }

    // 3. Board
    if (userPref.boards != null &&
        userPref.boards!.isNotEmpty &&
        school.board != null &&
        school.board!.isNotEmpty) {
      if (userPref.boards!.toLowerCase() == school.board!.toLowerCase()) {
        matched++;
      }
    }

    // 4. School Type (UserPref) vs School Tags (SchoolModel)
    if (userPref.schoolType != null &&
        userPref.schoolType!.isNotEmpty &&
        school.tags != null &&
        school.tags!.isNotEmpty) {
      if (school.tags!
          .map((e) => e.toLowerCase())
          .contains(userPref.schoolType!.toLowerCase())) {
        matched++;
      }
    }

    // 5. School Mode / Shift
    if (userPref.shift != null &&
        userPref.shift!.isNotEmpty &&
        school.shifts != null &&
        school.shifts!.isNotEmpty) {
      if (school.shifts!
          .map((e) => e.toLowerCase())
          .contains(userPref.shift!.toLowerCase())) {
        matched++;
      }
    }

    // 6. Specialist vs Interest
    if (userPref.interests != null &&
        userPref.interests!.isNotEmpty &&
        school.specialist != null &&
        school.specialist!.isNotEmpty) {
      if (school.specialist!
          .map((e) => e.toLowerCase())
          .contains(userPref.interests!.toLowerCase())) {
        matched++;
      }
    }

    return ((matched / totalCriteria) * 100).round();
  }
}
