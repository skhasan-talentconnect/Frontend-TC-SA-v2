// lib/features/application/applications/presentation/application_view.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart'
    show SAppBar, SIcon, SColor, STextStyles, SLoadingIndicator;
import 'package:tc_sa/core/index.dart' show getIt, AppStateProvider, RouteNames;
import 'package:tc_sa/features/application/applications/data/entities/applications_model.dart';
import 'package:tc_sa/features/application/applications/presentation/view_models/application_view_model.dart';
import 'package:tc_sa/features/application/pdfModule/presentation/view_models/pdf_view_model.dart';

class ApplicationFormView extends StatefulWidget {
  const ApplicationFormView({
    super.key,
    this.forceNew = false,
    this.initialApplication,
  });

  final bool forceNew;
  final StudentApplication? initialApplication;

  @override
  State<ApplicationFormView> createState() => _ApplicationFormViewState();
}

class _ApplicationFormViewState extends State<ApplicationFormView> {
  void _prefillParentAndAddress(StudentApplication app) {
    // Father
    _fatherNameCtrl.text = app.fatherName ?? '';
    _fatherAgeCtrl.text = app.fatherAge?.toString() ?? '';
    _fatherQualCtrl.text = app.fatherQualification ?? '';
    _fatherProfCtrl.text = app.fatherProfession ?? '';
    _fatherIncomeCtrl.text = app.fatherAnnualIncome ?? '';
    _fatherPhoneCtrl.text = app.fatherPhoneNo ?? '';
    _fatherAadharCtrl.text = app.fatherAadharNo ?? '';
    _fatherEmailCtrl.text = app.fatherEmail ?? '';

    // Mother
    _motherNameCtrl.text = app.motherName ?? '';
    _motherAgeCtrl.text = app.motherAge?.toString() ?? '';
    _motherQualCtrl.text = app.motherQualification ?? '';
    _motherProfCtrl.text = app.motherProfession ?? '';
    _motherIncomeCtrl.text = app.motherAnnualIncome ?? '';
    _motherPhoneCtrl.text = app.motherPhoneNo ?? '';
    _motherAadharCtrl.text = app.motherAadharNo ?? '';
    _motherEmailCtrl.text = app.motherEmail ?? '';

    // Addresses
    _presentAddressCtrl.text = app.presentAddress ?? '';
    _permanentAddressCtrl.text = app.permanentAddress ?? '';

    // If relationship/guardian fields are relevant, you may decide to prefill them too.
    // Currently we keep guardian fields untouched so the user can explicitly provide them when needed.

    if (mounted) setState(() {});
  }

  final _vm = ApplicationViewModel();
  final _formKey = GlobalKey<FormState>();
  bool _checkingExisting = true;
  StudentApplication? _application;

  String? _selectedStandard;

  @override
  void initState() {
    super.initState();

    // Run after first frame so context & provider are ready.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;

      // Case 1: If initialApplication provided, prefill and skip backend call
      if (widget.initialApplication != null) {
        _vm.setApplication(widget.initialApplication);
        _application = widget.initialApplication;
        _populateFromApplication(_application!);
        _checkingExisting = false;
        setState(() {});
        return;
      }

      // Case 2: Force new blank form BUT if user already has saved applications,
      // prefill parent & address sections from the first saved application.
      if (widget.forceNew) {
        // attempt to fetch existing applications (non-blocking for user, but we await here)
        await _checkExisting();

        if (_application != null) {
          // prefill only father, mother and address sections (fields remain editable)
          _prefillParentAndAddress(_application!);
        }

        _checkingExisting = false;
        setState(() {});
        return;
      }

      // Case 3: Normal case — fetch applications list for this student
      await _checkExisting();

      // if we fetched an existing application and want to prefill the form
      if (_application != null) {
        _populateFromApplication(_application!);
      }
    });
  }

  Future<void> _checkExisting() async {
    final studId = getIt<AppStateProvider>().user?.sId;
    if (studId != null && studId.isNotEmpty) {
      final failure = await _vm.getApplicationsByStudId(studId: studId);
      // if single application prefilling is still desired, you can pick the latest:
      if (_vm.applications.isNotEmpty) {
        _application = _vm.applications.first;
      }
    }
    if (mounted) setState(() => _checkingExisting = false);
  }

  void _populateFromApplication(StudentApplication app) {
    // basic fields (add more fields if your model has them)
    _nameCtrl.text = app.name ?? '';
    _locationCtrl.text = app.location ?? '';
    _dobCtrl.text =
        app.dob != null ? app.dob!.toIso8601String().split('T').first : '';
    _gender = app.gender ?? _gender;
    _motherTongueCtrl.text = app.motherTongue ?? '';
    _placeOfBirthCtrl.text = app.placeOfBirth ?? '';
    _speciallyAbled = app.speciallyAbled ?? false;
    _speciallyAbledTypeCtrl.text = app.speciallyAbledType ?? '';
    _nationalityCtrl.text = app.nationality ?? '';
    _religionCtrl.text = app.religion ?? '';
    _casteCtrl.text = app.caste ?? '';
    _subcasteCtrl.text = app.subcaste ?? '';
    _aadharCtrl.text = app.aadharNo ?? '';
    _bloodGroupCtrl.text = app.bloodGroup ?? '';
    _allergicToCtrl.text = app.allergicTo ?? '';
    _interestCtrl.text = app.interest ?? '';

    _lastSchoolNameCtrl.text = app.lastSchoolName ?? '';
    _classCompletedCtrl.text = app.classCompleted ?? '';
    _lastAcademicYearCtrl.text = app.lastAcademicYear ?? '';
    _reasonForLeavingCtrl.text = app.reasonForLeaving ?? '';
    _lastBoard = app.board;

    _fatherNameCtrl.text = app.fatherName ?? '';
    _fatherAgeCtrl.text = app.fatherAge?.toString() ?? '';
    _fatherQualCtrl.text = app.fatherQualification ?? '';
    _fatherProfCtrl.text = app.fatherProfession ?? '';
    _fatherIncomeCtrl.text = app.fatherAnnualIncome ?? '';
    _fatherPhoneCtrl.text = app.fatherPhoneNo ?? '';
    _fatherAadharCtrl.text = app.fatherAadharNo ?? '';
    _fatherEmailCtrl.text = app.fatherEmail ?? '';

    _motherNameCtrl.text = app.motherName ?? '';
    _motherAgeCtrl.text = app.motherAge?.toString() ?? '';
    _motherQualCtrl.text = app.motherQualification ?? '';
    _motherProfCtrl.text = app.motherProfession ?? '';
    _motherIncomeCtrl.text = app.motherAnnualIncome ?? '';
    _motherPhoneCtrl.text = app.motherPhoneNo ?? '';
    _motherAadharCtrl.text = app.motherAadharNo ?? '';
    _motherEmailCtrl.text = app.motherEmail ?? '';

    _relationshipStatus = app.relationshipStatus ?? _relationshipStatus;
    _guardianNameCtrl.text = app.guardianName ?? '';
    _guardianContactNoCtrl.text = app.guardianContactNo ?? '';
    _guardianRelationCtrl.text = app.guardianRelationToStudent ?? '';
    _guardianQualificationCtrl.text = app.guardianQualification ?? '';
    _guardianProfessionCtrl.text = app.guardianProfession ?? '';
    _guardianEmailCtrl.text = app.guardianEmail ?? '';
    _guardianAadharNoCtrl.text = app.guardianAadharNo ?? '';

    _presentAddressCtrl.text = app.presentAddress ?? '';
    _permanentAddressCtrl.text = app.permanentAddress ?? '';

    // siblings (clear and rebuild)
    for (final s in _siblings) s.dispose();
    _siblings.clear();
    if (app.siblings != null) {
      for (final s in app.siblings!) {
        final field = _SiblingField();
        field.name.text = s.name ?? '';
        field.age.text = s.age?.toString() ?? '';
        field.sex.text = s.sex ?? '';
        field.institute.text = s.nameOfInstitute ?? '';
        field.className.text = s.className ?? '';
        _siblings.add(field);
      }
    }

    _homeLanguageCtrl.text = app.homeLanguage ?? '';
    _yearlyBudgetCtrl.text = app.yearlyBudget ?? '';

    // trigger rebuild so UI reflects values
    if (mounted) setState(() {});
  }

  // -----------------------
  // Student core
  // -----------------------
  final _nameCtrl = TextEditingController();
  final _locationCtrl = TextEditingController();
  final _dobCtrl = TextEditingController(); // yyyy-MM-dd
  String? _gender = 'Male';
  final _motherTongueCtrl = TextEditingController();
  final _placeOfBirthCtrl = TextEditingController();
  bool _speciallyAbled = false;
  final _speciallyAbledTypeCtrl = TextEditingController();
  final _nationalityCtrl = TextEditingController();
  final _religionCtrl = TextEditingController();
  final _casteCtrl = TextEditingController();
  final _subcasteCtrl = TextEditingController();
  final _aadharCtrl = TextEditingController();
  final _bloodGroupCtrl = TextEditingController();
  final _standardCtrl = TextEditingController();

  final _allergicToCtrl = TextEditingController();
  final _interestCtrl = TextEditingController();

  // -----------------------
  // Last school
  // -----------------------
  final _lastSchoolNameCtrl = TextEditingController();
  final _classCompletedCtrl = TextEditingController();
  final _lastAcademicYearCtrl = TextEditingController();
  final _reasonForLeavingCtrl = TextEditingController();
  String? _lastBoard; // optional dropdown value

  // -----------------------
  // Father
  // -----------------------
  final _fatherNameCtrl = TextEditingController();
  final _fatherAgeCtrl = TextEditingController();
  final _fatherQualCtrl = TextEditingController();
  final _fatherProfCtrl = TextEditingController();
  final _fatherIncomeCtrl = TextEditingController();
  final _fatherPhoneCtrl = TextEditingController();
  final _fatherAadharCtrl = TextEditingController();
  final _fatherEmailCtrl = TextEditingController();

  // -----------------------
  // Mother
  // -----------------------
  final _motherNameCtrl = TextEditingController();
  final _motherAgeCtrl = TextEditingController();
  final _motherQualCtrl = TextEditingController();
  final _motherProfCtrl = TextEditingController();
  final _motherIncomeCtrl = TextEditingController();
  final _motherPhoneCtrl = TextEditingController();
  final _motherAadharCtrl = TextEditingController();
  final _motherEmailCtrl = TextEditingController();

  // -----------------------
  // Relationship & guardian
  // -----------------------
  String? _relationshipStatus = 'Married';
  final _guardianNameCtrl = TextEditingController();
  final _guardianContactNoCtrl = TextEditingController();
  final _guardianRelationCtrl = TextEditingController();
  final _guardianQualificationCtrl = TextEditingController();
  final _guardianProfessionCtrl = TextEditingController();
  final _guardianEmailCtrl = TextEditingController();
  final _guardianAadharNoCtrl = TextEditingController();

  // -----------------------
  // Addresses
  // -----------------------
  final _presentAddressCtrl = TextEditingController();
  final _permanentAddressCtrl = TextEditingController();

  // -----------------------
  // Siblings (dynamic list)
  // -----------------------
  final List<_SiblingField> _siblings = [];

  // -----------------------
  // Other
  // -----------------------
  final _homeLanguageCtrl = TextEditingController();
  final _yearlyBudgetCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _locationCtrl.dispose();
    _dobCtrl.dispose();
    _motherTongueCtrl.dispose();
    _placeOfBirthCtrl.dispose();
    _speciallyAbledTypeCtrl.dispose();
    _nationalityCtrl.dispose();
    _religionCtrl.dispose();
    _casteCtrl.dispose();
    _subcasteCtrl.dispose();
    _aadharCtrl.dispose();
    _bloodGroupCtrl.dispose();
    _allergicToCtrl.dispose();
    _interestCtrl.dispose();

    _lastSchoolNameCtrl.dispose();
    _classCompletedCtrl.dispose();
    _lastAcademicYearCtrl.dispose();
    _reasonForLeavingCtrl.dispose();
    _standardCtrl.dispose();

    _fatherNameCtrl.dispose();
    _fatherAgeCtrl.dispose();
    _fatherQualCtrl.dispose();
    _fatherProfCtrl.dispose();
    _fatherIncomeCtrl.dispose();
    _fatherPhoneCtrl.dispose();
    _fatherAadharCtrl.dispose();
    _fatherEmailCtrl.dispose();

    _motherNameCtrl.dispose();
    _motherAgeCtrl.dispose();
    _motherQualCtrl.dispose();
    _motherProfCtrl.dispose();
    _motherIncomeCtrl.dispose();
    _motherPhoneCtrl.dispose();
    _motherAadharCtrl.dispose();
    _motherEmailCtrl.dispose();

    _guardianNameCtrl.dispose();
    _guardianContactNoCtrl.dispose();
    _guardianRelationCtrl.dispose();
    _guardianQualificationCtrl.dispose();
    _guardianProfessionCtrl.dispose();
    _guardianEmailCtrl.dispose();
    _guardianAadharNoCtrl.dispose();

    _presentAddressCtrl.dispose();
    _permanentAddressCtrl.dispose();

    for (final s in _siblings) {
      s.dispose();
    }

    _homeLanguageCtrl.dispose();
    _yearlyBudgetCtrl.dispose();

    super.dispose();
  }

  // sibling helper
  void _addSibling() {
    setState(() => _siblings.add(_SiblingField()));
  }

  void _removeSibling(int i) {
    setState(() {
      _siblings[i].dispose();
      _siblings.removeAt(i);
    });
  }

  Future<void> _pickDob() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 5, now.month, now.day),
      firstDate: DateTime(now.year - 25),
      lastDate: now,
    );
    if (picked != null) {
      _dobCtrl.text =
          "${picked.year.toString().padLeft(4, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      setState(() {});
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    // Resolve studId from AppStateProvider
    final studId = getIt<AppStateProvider>().user?.sId;
    if (studId == null || studId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Missing logged-in student id.")),
      );
      return;
    }

    // Parse DOB
    DateTime? dob;
    if (_dobCtrl.text.trim().isNotEmpty) {
      dob = DateTime.tryParse(_dobCtrl.text.trim());
      if (dob == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Invalid DOB format. Use yyyy-MM-dd.")),
        );
        return;
      }
    }

    // Parse ints for ages safely
    int? fatherAge = int.tryParse(_fatherAgeCtrl.text.trim());
    int? motherAge = int.tryParse(_motherAgeCtrl.text.trim());

    // Siblings to model objects
    final List<Sibling> siblingList =
        _siblings
            .map(
              (s) => Sibling(
                name: s.name.text.trim().isEmpty ? null : s.name.text.trim(),
                age: int.tryParse(s.age.text.trim()),
                sex: s.sex.text.trim().isEmpty ? null : s.sex.text.trim(),
                nameOfInstitute:
                    s.institute.text.trim().isEmpty
                        ? null
                        : s.institute.text.trim(),
                className:
                    s.className.text.trim().isEmpty
                        ? null
                        : s.className.text.trim(),
              ),
            )
            .where((sib) => (sib.name ?? '').isNotEmpty)
            .toList();

    final payload = StudentApplication(
      studId: studId,
      // student core
      name: _nameCtrl.text.trim(),
      location: _locationCtrl.text.trim(),
      dob: dob,
      gender: _gender,
      motherTongue: _motherTongueCtrl.text.trim(),
      standard: _standardCtrl.text.trim(),

      placeOfBirth:
          _placeOfBirthCtrl.text.trim().isEmpty
              ? null
              : _placeOfBirthCtrl.text.trim(),
      speciallyAbled: _speciallyAbled,
      speciallyAbledType:
          _speciallyAbledTypeCtrl.text.trim().isEmpty
              ? null
              : _speciallyAbledTypeCtrl.text.trim(),
      nationality: _nationalityCtrl.text.trim(),
      religion: _religionCtrl.text.trim(),
      caste: _casteCtrl.text.trim(),
      subcaste:
          _subcasteCtrl.text.trim().isEmpty ? null : _subcasteCtrl.text.trim(),
      aadharNo: _aadharCtrl.text.trim(),
      bloodGroup: _bloodGroupCtrl.text.trim(),
      allergicTo:
          _allergicToCtrl.text.trim().isEmpty
              ? null
              : _allergicToCtrl.text.trim(),
      interest: _interestCtrl.text.trim(),

      // last school
      lastSchoolName:
          _lastSchoolNameCtrl.text.trim().isEmpty
              ? null
              : _lastSchoolNameCtrl.text.trim(),
      classCompleted:
          _classCompletedCtrl.text.trim().isEmpty
              ? null
              : _classCompletedCtrl.text.trim(),
      lastAcademicYear:
          _lastAcademicYearCtrl.text.trim().isEmpty
              ? null
              : _lastAcademicYearCtrl.text.trim(),
      reasonForLeaving:
          _reasonForLeavingCtrl.text.trim().isEmpty
              ? null
              : _reasonForLeavingCtrl.text.trim(),
      board: _lastBoard,

      // father
      fatherName: _fatherNameCtrl.text.trim(),
      fatherAge: fatherAge,
      fatherQualification: _fatherQualCtrl.text.trim(),
      fatherProfession: _fatherProfCtrl.text.trim(),
      fatherAnnualIncome: _fatherIncomeCtrl.text.trim(),
      fatherPhoneNo: _fatherPhoneCtrl.text.trim(),
      fatherAadharNo: _fatherAadharCtrl.text.trim(),
      fatherEmail: _fatherEmailCtrl.text.trim(),

      // mother
      motherName: _motherNameCtrl.text.trim(),
      motherAge: motherAge,
      motherQualification: _motherQualCtrl.text.trim(),
      motherProfession: _motherProfCtrl.text.trim(),
      motherAnnualIncome: _motherIncomeCtrl.text.trim(),
      motherPhoneNo: _motherPhoneCtrl.text.trim(),
      motherAadharNo: _motherAadharCtrl.text.trim(),
      motherEmail: _motherEmailCtrl.text.trim(),

      // relationship & guardian
      relationshipStatus: _relationshipStatus,
      guardianName:
          _needsGuardian()
              ? (_guardianNameCtrl.text.trim().isEmpty
                  ? null
                  : _guardianNameCtrl.text.trim())
              : null,
      guardianContactNo:
          _needsGuardian()
              ? (_guardianContactNoCtrl.text.trim().isEmpty
                  ? null
                  : _guardianContactNoCtrl.text.trim())
              : null,
      guardianRelationToStudent:
          _needsGuardian()
              ? (_guardianRelationCtrl.text.trim().isEmpty
                  ? null
                  : _guardianRelationCtrl.text.trim())
              : null,
      guardianQualification:
          _needsGuardian()
              ? (_guardianQualificationCtrl.text.trim().isEmpty
                  ? null
                  : _guardianQualificationCtrl.text.trim())
              : null,
      guardianProfession:
          _needsGuardian()
              ? (_guardianProfessionCtrl.text.trim().isEmpty
                  ? null
                  : _guardianProfessionCtrl.text.trim())
              : null,
      guardianEmail:
          _needsGuardian()
              ? (_guardianEmailCtrl.text.trim().isEmpty
                  ? null
                  : _guardianEmailCtrl.text.trim())
              : null,
      guardianAadharNo:
          _needsGuardian()
              ? (_guardianAadharNoCtrl.text.trim().isEmpty
                  ? null
                  : _guardianAadharNoCtrl.text.trim())
              : null,

      // addresses
      presentAddress: _presentAddressCtrl.text.trim(),
      permanentAddress: _permanentAddressCtrl.text.trim(),

      // siblings
      siblings: siblingList,

      // other
      homeLanguage: _homeLanguageCtrl.text.trim(),
      yearlyBudget: _yearlyBudgetCtrl.text.trim(),
    );
    final failure = await _vm.addApplication(payload);
    if (!mounted) return;

    if (failure != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(failure.message ?? "Something went wrong")),
      );
      return;
    }

    // Try to get the created application id from the returned model
    final created = _vm.application;
    String createdAppId = created?.applicationId?.toString() ?? '';

    // Debug log for visibility
    debugPrint('[ApplicationFormView] vm.application after add: $created');
    debugPrint(
      '[ApplicationFormView] initial createdAppId="$createdAppId" studId="$studId"',
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Application submitted successfully!")),
    );

    // If the backend didn't return applicationId, fetch user's applications as a fallback
    if (createdAppId.isEmpty) {
      try {
        debugPrint(
          '[ApplicationFormView] createdAppId empty. Fetching applications for studId: $studId',
        );

        // ensure studId exists
        if (studId != null && studId.isNotEmpty) {
          final fallbackFailure = await _vm.getApplicationsByStudId(
            studId: studId,
          );

          if (fallbackFailure != null) {
            debugPrint(
              '[ApplicationFormView] getApplicationsByStudId failed: ${fallbackFailure.message}',
            );
          } else {
            if (_vm.applications.isNotEmpty) {
              final mostRecent = _vm.applications.first;
              createdAppId =
                  mostRecent.applicationId?.toString() ??
                  mostRecent.applicationId?.toString() ??
                  mostRecent.applicationId?.toString() ??
                  '';
              debugPrint(
                '[ApplicationFormView] fallback found createdAppId="$createdAppId" from applications list',
              );
            } else {
              debugPrint(
                '[ApplicationFormView] fallback: no applications returned for studId',
              );
            }
          }
        } else {
          debugPrint(
            '[ApplicationFormView] studId missing; cannot run fallback fetch',
          );
        }
      } catch (e, st) {
        debugPrint(
          '[ApplicationFormView] exception during fallback fetch: $e\n$st',
        );
      }
    }

    // Now attempt PDF generation if we have an applicationId
    if (createdAppId.isNotEmpty && studId != null && studId.isNotEmpty) {
      try {
        final StudentPdfViewModel pdfVm =
            getIt.isRegistered<StudentPdfViewModel>()
                ? getIt<StudentPdfViewModel>()
                : StudentPdfViewModel();

        debugPrint(
          '[ApplicationFormView] calling pdfVm.generate(studId=$studId, applicationId=$createdAppId)',
        );

        final pdfFailure = await pdfVm.generate(
          context: context,
          studId: studId,
          applicationId: createdAppId,
        );

        if (pdfFailure != null) {
          debugPrint(
            '[ApplicationFormView] PDF generation failed: ${pdfFailure.message}',
          );
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(pdfFailure.message ?? "PDF generation failed"),
              ),
            );
          }
        } else {
          debugPrint(
            '[ApplicationFormView] PDF generated successfully for applicationId=$createdAppId',
          );
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("PDF generated successfully!")),
            );
          }
        }
      } catch (e, st) {
        debugPrint(
          '[ApplicationFormView] Exception during pdf generation: $e\n$st',
        );
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("PDF generation encountered an error."),
            ),
          );
        }
      }
    } else {
      debugPrint(
        '❌ Skipping PDF generation — missing createdAppId or studId. createdAppId="$createdAppId", studId="$studId"',
      );
    }

    // navigate to success page regardless (you can change this if you want to wait for PDF)
    if (!mounted) return;

    context.pushNamed(
      RouteNames.applicationSuccess,
      extra: {'applicationId': createdAppId},
    );
  }

  bool _needsGuardian() =>
      _relationshipStatus != null && _relationshipStatus != 'Married';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _vm,
      child: Consumer<ApplicationViewModel>(
        builder: (_, vm, __) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: SAppBar(
              title: "Application Form",
              leading: SIcon(
                icon: Icons.keyboard_arrow_left,
                onTap: () => context.pop(),
              ),
            ),

            body:
                _checkingExisting
                    ? const Center(child: SLoadingIndicator())
                    : (vm.applications.isNotEmpty && !widget.forceNew)
                    ? _AlreadyFilledMessage(applications: vm.applications)
                    : SafeArea(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ---------------- Student ----------------
                              Text(
                                "Student Details",
                                style: STextStyles.s18W600.copyWith(
                                  color: SColor.secTextColor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              _input("Full Name", _nameCtrl, req: true),
                              DropdownButtonFormField<String>(
                                value: _selectedStandard,
                                decoration: const InputDecoration(
                                  labelText: 'Standard / Class Applying For',
                                  border: OutlineInputBorder(),
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: 'KGs',
                                    child: Text('KGs'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Grade 1 - 5',
                                    child: Text('Grade 1 - 5'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Grade 6 - 10',
                                    child: Text('Grade 6 - 10'),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedStandard = value;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select a standard';
                                  }
                                  return null;
                                },
                              ),

                              _input("Location", _locationCtrl, req: true),
                              _dateInput(
                                "DOB (yyyy-MM-dd)",
                                _dobCtrl,
                                onPick: _pickDob,
                                req: true,
                              ),
                              _dropdown<String>(
                                label: "Gender",
                                value: _gender,
                                items: const ["Male", "Female", "Other"],
                                onChanged: (v) => setState(() => _gender = v),
                              ),
                              _input("Mother Tongue", _motherTongueCtrl),
                              _input(
                                "Place of Birth (optional)",
                                _placeOfBirthCtrl,
                              ),
                              // Specially abled switch + type
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Row(
                                  children: [
                                    Switch(
                                      value: _speciallyAbled,
                                      onChanged:
                                          (v) => setState(
                                            () => _speciallyAbled = v,
                                          ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Text("Specially Abled"),
                                  ],
                                ),
                              ),
                              if (_speciallyAbled)
                                _input(
                                  "Disability Type (optional)",
                                  _speciallyAbledTypeCtrl,
                                ),
                              _input(
                                "Nationality",
                                _nationalityCtrl,
                                req: true,
                              ),
                              _input("Religion", _religionCtrl, req: true),
                              _input("Caste", _casteCtrl),
                              _input("Subcaste (optional)", _subcasteCtrl),
                              _input("Aadhar No", _aadharCtrl, req: true),
                              _input("Blood Group", _bloodGroupCtrl),
                              _input("Allergic To (optional)", _allergicToCtrl),
                              _input("Interest", _interestCtrl, req: true),

                              const SizedBox(height: 16),
                              // ---------------- Last School ----------------
                              Text(
                                "Last School / Play School (if attended)",
                                style: STextStyles.s18W600.copyWith(
                                  color: SColor.secTextColor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              _input(
                                "School Name (optional)",
                                _lastSchoolNameCtrl,
                              ),
                              _input(
                                "Class Completed (optional)",
                                _classCompletedCtrl,
                              ),
                              _input(
                                "Last Academic Year (optional)",
                                _lastAcademicYearCtrl,
                              ),
                              _input(
                                "Reason For Leaving (optional)",
                                _reasonForLeavingCtrl,
                              ),
                              _dropdown<String>(
                                label: "Board (optional)",
                                value: _lastBoard,
                                items: const ["CBSE", "ICSE", "STATE", "OTHER"],
                                onChanged:
                                    (v) => setState(() => _lastBoard = v),
                              ),

                              const SizedBox(height: 16),
                              // ---------------- Father ----------------
                              Text(
                                "Father Details",
                                style: STextStyles.s18W600.copyWith(
                                  color: SColor.secTextColor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              _input("Name", _fatherNameCtrl, req: true),
                              _input(
                                "Age",
                                _fatherAgeCtrl,
                                keyboard: TextInputType.number,
                              ),
                              _input("Qualification", _fatherQualCtrl),
                              _input("Profession", _fatherProfCtrl),
                              _input("Annual Income", _fatherIncomeCtrl),
                              _input(
                                "Phone No",
                                _fatherPhoneCtrl,
                                keyboard: TextInputType.phone,
                              ),
                              _input("Aadhar No", _fatherAadharCtrl),
                              _input(
                                "Email",
                                _fatherEmailCtrl,
                                keyboard: TextInputType.emailAddress,
                              ),

                              const SizedBox(height: 16),
                              // ---------------- Mother ----------------
                              Text(
                                "Mother Details",
                                style: STextStyles.s18W600.copyWith(
                                  color: SColor.secTextColor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              _input("Name", _motherNameCtrl, req: true),
                              _input(
                                "Age",
                                _motherAgeCtrl,
                                keyboard: TextInputType.number,
                              ),
                              _input("Qualification", _motherQualCtrl),
                              _input("Profession", _motherProfCtrl),
                              _input("Annual Income", _motherIncomeCtrl),
                              _input(
                                "Phone No",
                                _motherPhoneCtrl,
                                keyboard: TextInputType.phone,
                              ),
                              _input("Aadhar No", _motherAadharCtrl),
                              _input(
                                "Email",
                                _motherEmailCtrl,
                                keyboard: TextInputType.emailAddress,
                              ),

                              const SizedBox(height: 16),
                              // ---------------- Relationship & Guardian ----------------
                              Text(
                                "Family & Address",
                                style: STextStyles.s18W600.copyWith(
                                  color: SColor.secTextColor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              _dropdown<String>(
                                label: "Relationship Status",
                                value: _relationshipStatus,
                                items: const [
                                  "Married",
                                  "Divorced",
                                  "Single Mother",
                                  "Single Father",
                                  "Widowed",
                                  "Other",
                                ],
                                onChanged:
                                    (v) =>
                                        setState(() => _relationshipStatus = v),
                              ),
                              if (_needsGuardian()) ...[
                                _input(
                                  "Guardian Name (optional)",
                                  _guardianNameCtrl,
                                ),
                                _input(
                                  "Guardian Contact No (optional)",
                                  _guardianContactNoCtrl,
                                  keyboard: TextInputType.phone,
                                ),
                                _input(
                                  "Relation To Student (optional)",
                                  _guardianRelationCtrl,
                                ),
                                _input(
                                  "Guardian Qualification (optional)",
                                  _guardianQualificationCtrl,
                                ),
                                _input(
                                  "Guardian Profession (optional)",
                                  _guardianProfessionCtrl,
                                ),
                                _input(
                                  "Guardian Email (optional)",
                                  _guardianEmailCtrl,
                                  keyboard: TextInputType.emailAddress,
                                ),
                                _input(
                                  "Guardian Aadhar No (optional)",
                                  _guardianAadharNoCtrl,
                                ),
                              ],
                              _input(
                                "Present Address",
                                _presentAddressCtrl,
                                req: true,
                                maxLines: 2,
                              ),
                              _input(
                                "Permanent Address",
                                _permanentAddressCtrl,
                                req: true,
                                maxLines: 2,
                              ),

                              const SizedBox(height: 16),
                              // ---------------- Siblings ----------------
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Siblings",
                                    style: STextStyles.s18W600.copyWith(
                                      color: SColor.secTextColor,
                                    ),
                                  ),
                                  TextButton.icon(
                                    onPressed: _addSibling,
                                    icon: const Icon(Icons.add),
                                    label: const Text("Add"),
                                  ),
                                ],
                              ),
                              if (_siblings.isEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Text(
                                    "No siblings added.",
                                    style: STextStyles.s12W400.copyWith(
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                              for (int i = 0; i < _siblings.length; i++)
                                _siblingCard(i, _siblings[i]),

                              const SizedBox(height: 16),
                              // ---------------- Other ----------------
                              Text(
                                "Other Info",
                                style: STextStyles.s18W600.copyWith(
                                  color: SColor.secTextColor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              _input(
                                "Home Language",
                                _homeLanguageCtrl,
                                req: true,
                              ),
                              _input(
                                "Yearly Budget",
                                _yearlyBudgetCtrl,
                                req: true,
                              ),

                              const SizedBox(height: 24),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: _submit,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: SColor.primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                  ),
                                  child: Text(
                                    "Submit Application",
                                    style: STextStyles.s16W600.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
          );
        },
      ),
    );
  }

  // ---------- UI helpers ----------

  Widget _siblingCard(int index, _SiblingField s) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _input("Name", s.name, req: false),
          Row(
            children: [
              Expanded(
                child: _input(
                  "Age",
                  s.age,
                  keyboard: TextInputType.number,
                  req: false,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(child: _input("Sex", s.sex, req: false)),
            ],
          ),

          _input("Institute Name", s.institute, req: false),
          _input("Class", s.className, req: false),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () => _removeSibling(index),
              icon: const Icon(Icons.delete_outline),
              tooltip: "Remove",
            ),
          ),
        ],
      ),
    );
  }

  Widget _input(
    String label,
    TextEditingController controller, {
    bool req = false,
    int maxLines = 1,
    TextInputType? keyboard,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboard,
        maxLines: maxLines,
        validator: (v) {
          if (req && (v == null || v.trim().isEmpty)) {
            return '$label is required';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
        ),
      ),
    );
  }

  Widget _dateInput(
    String label,
    TextEditingController controller, {
    required VoidCallback onPick,
    bool req = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        validator: (v) {
          if (req && (v == null || v.trim().isEmpty)) {
            return '$label is required';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: onPick,
          ),
          border: const OutlineInputBorder(),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
        ),
      ),
    );
  }

  Widget _dropdown<T>({
    required String label,
    required T? value,
    required List<T> items,
    required ValueChanged<T?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 4,
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<T>(
            value: value,
            isExpanded: true,
            items:
                items
                    .map(
                      (e) => DropdownMenuItem<T>(
                        value: e,
                        child: Text(e.toString()),
                      ),
                    )
                    .toList(),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}

class _AlreadyFilledMessage extends StatelessWidget {
  final List<StudentApplication> applications;
  const _AlreadyFilledMessage({required this.applications});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, size: 64, color: Colors.green),
            const SizedBox(height: 12),
            Text(
              "You’ve already submitted ${applications.length} application(s).",
              textAlign: TextAlign.center,
              style: STextStyles.s16W600.copyWith(color: SColor.secTextColor),
            ),
            const SizedBox(height: 8),
            Text(
              "Generate pdf for your application to add it in your eligible applications.Choose an application to generate or download its PDF.",
              textAlign: TextAlign.center,
              style: STextStyles.s12W400.copyWith(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // List of existing applications (compact)
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 260),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: applications.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, i) {
                  final app = applications[i];
                  final title =
                      (app.name?.isNotEmpty == true)
                          ? app.name!
                          : (app.studId ?? 'Application ${i + 1}');
                  final subtitle =
                      app.createdAt != null
                          ? app.createdAt.toString().split('T').first
                          : '';
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    title: Text(title, style: STextStyles.s14W600),
                    subtitle: subtitle.isNotEmpty ? Text(subtitle) : null,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          tooltip: "View PDF",
                          icon: const Icon(Icons.picture_as_pdf),
                          onPressed: () {
                            // Navigate to PDF view and pass applicationId
                            context.pushNamed(
                              RouteNames.applicationPdf,
                              extra: {'applicationId': app.applicationId},
                            );
                          },
                        ),
                        IconButton(
                          tooltip: "Download PDF",
                          icon: const Icon(Icons.download),
                          onPressed: () {
                            // Navigate to same route but with download intent OR call a download helper.
                            // We'll push route and pass download flag — implement handling in pdf screen.
                            context.pushNamed(
                              RouteNames.applicationPdf,
                              extra: {
                                'applicationId': app.applicationId,
                                'download': true,
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      // quick tap opens view
                      context.pushNamed(
                        RouteNames.applicationPdf,
                        extra: {'applicationId': app.applicationId},
                      );
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Actions row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Add Another Application
                SizedBox(
                  width: 160,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // open form page in force-new mode
                      context.pushNamed(
                        RouteNames.addApplication,
                        extra: {'forceNew': true},
                      );
                    },
                    icon: const Icon(Icons.add, color: Colors.black),
                    label: Text(
                      "Add another",
                      style: STextStyles.s14W600.copyWith(
                        color: SColor.secTextColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Go Back
                SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: SColor.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      "Go Back",
                      style: STextStyles.s14W600.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SiblingField {
  final name = TextEditingController();
  final age = TextEditingController();
  final sex = TextEditingController();
  final institute = TextEditingController();
  final className = TextEditingController();

  void dispose() {
    name.dispose();
    age.dispose();
    sex.dispose();
    institute.dispose();
    className.dispose();
  }
}
