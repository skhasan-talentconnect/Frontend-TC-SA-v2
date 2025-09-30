// lib/features/application/applications/presentation/application_view.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart'
    show SAppBar, SIcon, SColor, STextStyles, SLoadingIndicator;
import 'package:tc_sa/core/index.dart' show getIt, AppStateProvider, RouteNames;
import 'package:tc_sa/features/application/applications/data/entities/applications_model.dart';
import 'package:tc_sa/features/application/applications/presentation/view_models/application_view_model.dart';

class ApplicationFormView extends StatefulWidget {
  const ApplicationFormView({super.key});

  @override
  State<ApplicationFormView> createState() => _ApplicationFormViewState();
}

class _ApplicationFormViewState extends State<ApplicationFormView> {
  final _vm = ApplicationViewModel();
  final _formKey = GlobalKey<FormState>();
  bool _checkingExisting = true; // NEW

  @override
  void initState() {
    super.initState();
    _checkExisting();
  }

  Future<void> _checkExisting() async {
    final studId = getIt<AppStateProvider>().user?.sId;
    // If we have a logged-in user, ask the backend if they already filled
    if (studId != null && studId.isNotEmpty) {
      await _vm.getApplicationByStudId(studId: studId);
    }
    if (mounted) setState(() => _checkingExisting = false);
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

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Application submitted successfully!")),
    );
    Navigator.of(context).pop(); // go back after success (optional)
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
                    : (vm.application != null)
                    ? _AlreadyFilledMessage() // <— show this instead of the form
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
  const _AlreadyFilledMessage();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, size: 64, color: Colors.green),
            const SizedBox(height: 12),
            Text(
              "You’ve already submitted this application.",
              textAlign: TextAlign.center,
              style: STextStyles.s16W600.copyWith(color: SColor.secTextColor),
            ),
            const SizedBox(height: 8),
            Text(
              "If you need changes, contact support or open the edit flow.",
              textAlign: TextAlign.center,
              style: STextStyles.s12W400.copyWith(color: Colors.black54),
            ),
            const SizedBox(height: 20),

            // Go Back button
            SizedBox(
              width: 180,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: SColor.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  "Go Back",
                  style: STextStyles.s14W600.copyWith(color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // New View PDF button
            // SButton.outlined(
            //   label: 'View PDF',
            //   text: Text("View PDF"),
            //   onPressed: () => context.pushNamed(RouteNames.applicationPdf),
            // ),
            SizedBox(
              width: 180,
              child: OutlinedButton.icon(
                onPressed: () => context.pushNamed(RouteNames.applicationPdf),
                icon: Icon(Icons.picture_as_pdf, color: Colors.black),
                label: Text(
                  "View PDF",
                  style: STextStyles.s14W600.copyWith(
                    color: SColor.secTextColor,
                  ),
                ),
              ),
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
