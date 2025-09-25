import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/preferences/index.dart' show PrefViewModel;

class PrefView extends StatefulWidget {
  const PrefView({required this.isEdit, super.key});
  final bool isEdit;

  @override
  State<PrefView> createState() => _PrefViewState();
}

class _PrefViewState extends State<PrefView> {
  final AppStateProvider appStateProvider = getIt<AppStateProvider>();
  final standardController = TextEditingController();
  final interestController = TextEditingController();
  final schoolTypeController = TextEditingController();
  final shiftController = TextEditingController();
  final boardController = TextEditingController();
  //Guest Flow
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final areaController = TextEditingController();
  final genderController = TextEditingController();

  @override
  void initState() {
    standardController.text =
        appStateProvider.userPref?.preferredStandard?.toCapitalise ?? '';
    interestController.text = appStateProvider.userPref?.interests ?? '';
    schoolTypeController.text =
        appStateProvider.userPref?.schoolType?.toCapitalise ?? '';
    shiftController.text = appStateProvider.userPref?.shift?.toCapitalise ?? '';
    boardController.text = appStateProvider.userPref?.boards ?? '';
    //Guest Flow
    stateController.text = appStateProvider.user?.state ?? '';
    cityController.text = appStateProvider.user?.city ?? '';
    areaController.text = appStateProvider.user?.area ?? '';
    genderController.text = appStateProvider.user?.gender ?? '';

    if (kDebugMode) {
      standardController.text = 'PlaySchool';
      interestController.text = 'Focusing on Academics';
      schoolTypeController.text = 'Convent';
      shiftController.text = 'Morning';
      boardController.text = 'SSC';
      //Guest Flow
      stateController.text = 'Maharashtra';
      selectedState = 'Maharashtra';
      selectedCity = 'Mumbai';
      selectedArea = 'Bandra';
      cityController.text = 'Mumbai';
      areaController.text = 'Bandra';
      genderController.text = 'Male';
    }
    super.initState();
  }

  final PrefViewModel prefViewModel = PrefViewModel();

  // --- maps ---
  final Map<String, List<String>> stateCities = {
    'Maharashtra': [
      'Mumbai',
      'Pune',
      'Nagpur',
      'Nashik',
      'Thane',
      'Aurangabad',
      'Kolhapur',
      'Amravati',
    ],
    'Gujarat': ['Ahmedabad', 'Surat', 'Vadodara', 'Rajkot'],
    'Rajasthan': ['Jaipur', 'Jodhpur', 'Udaipur'],
    'Punjab': ['Chandigarh', 'Ludhiana', 'Amritsar'],
    'Haryana': ['Gurugram', 'Faridabad', 'Panipat'],
    'Karnataka': ['Bengaluru', 'Mysore', 'Mangalore'],
    'Tamil Nadu': ['Chennai', 'Coimbatore', 'Madurai'],
    'Uttar Pradesh': ['Lucknow', 'Kanpur', 'Varanasi'],
  };

  final Map<String, List<String>> cityAreas = {
    // Maharashtra
    'Mumbai': ['Bandra', 'Mahim', 'South Bombay', 'Andheri', 'Juhu', 'Powai'],
    'Pune': [
      'Kothrud',
      'Shivaji Nagar',
      'Viman Nagar',
      'Kalyani Nagar',
      'Hinjewadi',
    ],
    'Nagpur': ['Sitabuldi', 'Dharampeth', 'Civil Lines'],
    'Nashik': ['CIDCO', 'Satpur', 'Dwarka'],
    'Thane': ['Wagle Estate', 'Ghodbunder', 'Majiwada'],
    'Aurangabad': ['CIDCO', 'Waluj', 'Shendra'],
    'Kolhapur': ['Shivaji Nagar', 'Udyamnagar', 'Shivajiwadi'],
    'Amravati': ['Mangoan', 'Bhadaj', 'Shivaji Chowk'],

    // Gujarat
    'Ahmedabad': ['Navrangpura', 'Satellite', 'Prahlad Nagar', 'Maninagar'],
    'Surat': ['Udhna', 'Varachha', 'Adajan'],
    'Vadodara': ['Alkapuri', 'Manjalpur', 'Gotri'],
    'Rajkot': ['Rajpath', 'Kalavad Road', 'Rander'],

    // Rajasthan
    'Jaipur': ['C Scheme', 'Malviya Nagar', 'Vaishali Nagar'],
    'Jodhpur': ['Sardar Market', 'Ratanada', 'Sojati Gate'],
    'Udaipur': ['Hiran Magri', 'Bapu Bazaar', 'City Palace Area'],

    // Punjab
    'Chandigarh': ['Sector 17', 'Sector 22', 'Sector 9'],
    'Ludhiana': ['Model Town', 'Ferozepur Road', 'Industrial Area'],
    'Amritsar': ['Hall Bazaar', 'Ranjit Avenue', 'Wagah Road'],

    // Haryana
    'Gurugram': ['DLF Phase 1', 'Sohna Road', 'Cyber City'],
    'Faridabad': ['Sector 15', 'Ballabhgarh', 'NIT Faridabad'],
    'Panipat': ['Karnal Road', 'Karnal Bypass', 'Civil Lines'],

    // Karnataka
    'Bengaluru': ['Koramangala', 'Indiranagar', 'Whitefield', 'Jayanagar'],
    'Mysore': ['Gokulam', 'Hebbal', 'Vijayanagar'],
    'Mangalore': ['Bajpe', 'Kadri', 'Balmatta'],

    // Tamil Nadu
    'Chennai': ['Adyar', 'T. Nagar', 'Velachery', 'Anna Nagar'],
    'Coimbatore': ['RS Puram', 'Saibaba Colony', 'Gandhipuram'],
    'Madurai': ['Tirupparankundram', 'Anna Nagar', 'K.K. Nagar'],

    // Uttar Pradesh
    'Lucknow': ['Hazratganj', 'Indira Nagar', 'Gomti Nagar'],
    'Kanpur': ['Kalyanpur', 'Swaroop Nagar', 'Civil Lines'],
    'Varanasi': ['Bhelupur', 'Sigra', 'Kashi Vishwanath Area'],
  };

  List<String> cityItems = [];
  List<String> areaItems = [];

  String? selectedState;
  String? selectedCity;
  String? selectedArea;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider.value(
        value: prefViewModel,
        child: Selector<PrefViewModel, bool>(
          selector: (_, vm) => vm.isLoading,
          builder:
              (vmContext, isLoading, __) =>
                  isLoading
                      ? Center(child: SLoadingIndicator())
                      : SafeArea(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(
                            vertical: widget.isEdit ? 0 : 16,
                            horizontal: widget.isEdit ? 0 : 20,
                          ),
                          child: Column(
                            spacing: 16,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 8,
                                children: [
                                  SizedBox.shrink(),
                                  Text(
                                    '${widget.isEdit ? 'Edit' : 'Add'} your preferences',
                                    style: STextStyles.s20W600,
                                  ),
                                  Text(
                                    'Kindly fill all the details to get your preferred schools.',
                                    style: STextStyles.s16W400,
                                  ),
                                ],
                              ),
                              Form(
                                child: Column(
                                  spacing: 16,
                                  children: [
                                    STextField.dropdown(
                                      controller: boardController,
                                      items: [
                                        'CBSE',
                                        'ICSE',
                                        'CISCE',
                                        'NIOS',
                                        'SSC',
                                        'IGCSE',
                                        'IB',
                                        'KVS',
                                        'JNV',
                                        'DBSE',
                                        'MSBSHSE',
                                        'UPMSP',
                                        'KSEEB',
                                        'WBBSE',
                                        'GSEB',
                                        'RBSE',
                                        'BSEB',
                                        'PSEB',
                                        'BSE',
                                        'SEBA',
                                        'MPBSE',
                                        'STATE',
                                        'OTHER',
                                      ],
                                      label: 'Preferred Board',
                                      hint: 'Select Board',
                                    ),
                                    STextField.dropdown(
                                      controller: standardController,
                                      items: [
                                        'PlaySchool',
                                        'Pre-Primary',
                                        'Primary',
                                        'Secondary',
                                      ],
                                      label: 'Preferred Standard',
                                      hint: 'Select Standard',
                                    ),
                                    STextField.dropdown(
                                      controller: interestController,
                                      items: [
                                        'Focusing on Academics',
                                        'Focuses on Practical Learning',
                                        'Focuses on Theoretical Learning',
                                        'Empowering in Sports',
                                        'Empowering in Arts',
                                        'Special Focus on Mathematics',
                                        'Special Focus on Science',
                                        'Special Focus on Physical Education',
                                        'Leadership Development',
                                        'STEM Activities',
                                        'Cultural Education',
                                        'Technology Integration',
                                        'Environmental Awareness',
                                      ],
                                      label: 'Interests',
                                      hint: 'Select Interest',
                                    ),
                                    STextField.dropdown(
                                      controller: schoolTypeController,
                                      items: [
                                        'Convent',
                                        'Private',
                                        'Government',
                                      ],
                                      label: 'Preferred School Type',
                                      hint: 'Select School Type',
                                    ),
                                    STextField.dropdown(
                                      controller: shiftController,
                                      items: [
                                        'Morning',
                                        'Afternoon',
                                        'Night school',
                                      ],
                                      label: 'Preferred Shifts',
                                      hint: 'Select Shift',
                                    ),
                                    if (getIt<AppStateProvider>().isGuest) ...[
                                      STextField.dropdown(
                                        items: ['Male', 'Female', 'Other'],
                                        controller: genderController,
                                        label: 'Gender*',
                                        hint: 'Select',
                                        prefixIcon: Icon(Icons.male),
                                      ),

                                      // --------------------
                                      // STATE dropdown
                                      // --------------------
                                      STextField.dropdown(
                                        items: stateCities.keys.toList(),
                                        controller: stateController,
                                        label: 'State*',
                                        hint: 'Select',
                                        prefixIcon: Icon(Icons.pin_drop),
                                        onChanged: (String? val) {
                                          if (val == null) return;
                                          final key = val.trim();
                                          setState(() {
                                            selectedState = key;
                                            stateController.text = key;

                                            // load cities for the selected state
                                            cityItems =
                                                stateCities[key] != null
                                                    ? List.from(
                                                      stateCities[key]!,
                                                    )
                                                    : [];

                                            // reset city & area
                                            selectedCity = null;
                                            cityController.text = '';
                                            areaItems = [];
                                            selectedArea = null;
                                            areaController.text = '';
                                          });
                                        },
                                      ),

                                      // --------------------
                                      // CITY dropdown
                                      // --------------------
                                      STextField.dropdown(
                                        items: cityItems,
                                        controller: cityController,
                                        label: 'City*',
                                        hint: 'Select',
                                        enable: cityItems.isNotEmpty,
                                        prefixIcon: Icon(Icons.location_city),
                                        onChanged: (String? val) {
                                          if (val == null) return;
                                          final key = val.trim();
                                          setState(() {
                                            selectedCity = key;
                                            cityController.text = key;

                                            // load areas for the chosen city
                                            areaItems =
                                                cityAreas[key] != null
                                                    ? List.from(cityAreas[key]!)
                                                    : [];

                                            // reset area
                                            selectedArea = null;
                                            areaController.text = '';
                                          });
                                        },
                                      ),

                                      // --------------------
                                      // AREA dropdown
                                      // --------------------
                                      STextField.dropdown(
                                        items:
                                            areaItems.isNotEmpty
                                                ? areaItems
                                                : ['Other'],
                                        controller: areaController,
                                        label: 'Area*',
                                        hint: 'Select',
                                        enable: areaItems.isNotEmpty,
                                        prefixIcon: Icon(Icons.map),
                                        onChanged: (String? val) {
                                          if (val == null) return;
                                          final key = val.trim();
                                          setState(() {
                                            selectedArea = key;
                                            areaController.text = key;
                                          });
                                        },
                                      ),
                                    ],
                                  ],
                                ),
                              ),

                              SButton(
                                label: widget.isEdit ? 'Edit' : 'Submit',
                                onPressed: () async {
                                  String boards = boardController.text.trim();
                                  String standard =
                                      standardController.text.trim();
                                  String interest =
                                      interestController.text.trim();
                                  String schoolType =
                                      schoolTypeController.text.trim();
                                  String shifts = shiftController.text.trim();
                                  //Guest
                                  String gender = genderController.text.trim();

                                  if (standard.isEmpty ||
                                      interest.isEmpty ||
                                      schoolType.isEmpty ||
                                      shifts.isEmpty ||
                                      boards.isEmpty) {
                                    Toasts.showErrorToast(
                                      context,
                                      message: 'Please fill all the fields',
                                    );
                                  } else {
                                    Failure? failure;
                                    if (appStateProvider.isGuest) {
                                      if (gender.isEmpty ||
                                          (selectedArea ?? '').isEmpty ||
                                          (selectedState ?? '').isEmpty ||
                                          (selectedCity ?? '').isEmpty) {
                                        failure = APIFailure(
                                          message: 'Please fill all the fields',
                                          statusCode: 303,
                                        );
                                      } else {
                                        appStateProvider.user = User(
                                          name: 'Guest',
                                          userType: UserType.guest,
                                          state: selectedState,
                                          city: selectedCity,
                                          area: selectedArea,
                                          gender: gender,
                                        );
                                        appStateProvider.userPref = UserPref(
                                          boards: boards,
                                          preferredStandard: standard,
                                          interests: interest,
                                          schoolType: schoolType,
                                          shift: shifts,
                                        );
                                      }
                                    } else {
                                      if (widget.isEdit) {
                                        failure = await prefViewModel
                                            .updatePreferences(
                                              boards: boards,
                                              preferredStandard: standard,
                                              interests: interest,
                                              schoolType: schoolType,
                                              shift: shifts,
                                            );
                                      } else {
                                        failure = await prefViewModel
                                            .addPreferences(
                                              boards: boards,
                                              preferredStandard: standard,
                                              interests: interest,
                                              schoolType: schoolType,
                                              shift: shifts,
                                            );
                                      }
                                    }
                                    Toasts.showSuccessOrFailureToast(
                                      context,
                                      failure: failure,
                                      successMsg:
                                          'Preferences ${widget.isEdit ? 'Updated' : 'Added'}',
                                      popOnSuccess: false,
                                      successCallback: () {
                                        print(
                                          appStateProvider.userPref?.toJson(),
                                        );
                                        if (!widget.isEdit) {
                                          context.pushReplacementNamed(
                                            RouteNames.home,
                                          );
                                        }
                                      },
                                    );
                                  }
                                },
                              ),

                              SizedBox(height: 1),
                            ],
                          ),
                        ),
                      ),
        ),
      ),
    );
  }
}
