import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/profile/presentation/location_fetching.dart';
import 'package:tc_sa/features/profile/presentation/location_utils.dart';
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
  
  double? _latitude;
  double? _longitude;

  static const List<String> defaultAreas = [
  "Main Area",
  "Central",
  "Station Road",
  "Market"
];
// 🧩 Mapping of frontend (short) values to backend (enum) strings
final Map<String, String> interestMap = {
  'Academics': 'Focusing on Academics',
  'Practical Learning': 'Focuses on Practical Learning',
  'Theoretical Learning': 'Focuses on Theoretical Learning',
  'Sports': 'Empowering in Sports',
  'Arts': 'Empowering in Arts',
  'Mathematics': 'Special Focus on Mathematics',
  'Science': 'Special Focus on Science',
  'Physical Education': 'Special Focus on Physical Education',
  'Leadership Development': 'Leadership Development',
  'STEM Activities': 'STEM Activities',
  'Cultural Education': 'Cultural Education',
  'Technology Integration': 'Technology Integration',
  'Environmental Awareness': 'Environmental Awareness',
};


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

    // if (kDebugMode) {
    //   standardController.text = 'PlaySchool';
    //   interestController.text = 'Focusing on Academics';
    //   schoolTypeController.text = 'Convent';
    //   shiftController.text = 'Morning';
    //   boardController.text = 'SSC';
    //   //Guest Flow
    //   stateController.text = 'Maharashtra';
    //   selectedState = 'Maharashtra';
    //   selectedCity = 'Mumbai';
    //   selectedArea = 'Bandra';
    //   cityController.text = 'Mumbai';
    //   areaController.text = 'Bandra';
    //   genderController.text = 'Male';
    // }
    _setPrefDefaults();
    super.initState();
  }
void _setPrefDefaults() {
  final pref = appStateProvider.userPref;
  if (pref == null) return;

  setState(() {
    boardController.text = pref.boards ?? '';
    standardController.text = pref.preferredStandard?.toCapitalise ?? '';
    final backendInterest = pref.interests ?? '';
final frontendInterest = interestMap.entries
    .firstWhere(
      (entry) => entry.value == backendInterest,
      orElse: () => const MapEntry('', ''),
    )
    .key;
interestController.text = frontendInterest.isNotEmpty ? frontendInterest : backendInterest;

    schoolTypeController.text = pref.schoolType?.toCapitalise ?? '';
    shiftController.text = pref.shift?.toCapitalise ?? '';
  });

  // Also set guest details if applicable
  final user = appStateProvider.user;
  if (user != null) {
    stateController.text = user.state ?? '';
    cityController.text = user.city ?? '';
    areaController.text = user.area ?? '';
    genderController.text = user.gender ?? '';

    selectedState = user.state;
    selectedCity = user.city;
    selectedArea = user.area;
  }
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
        'Delhi': ['Delhi', 'New Delhi'],

    'Haryana': ['Gurugram', 'Faridabad', 'Panipat'],
    'Karnataka': ['Bengaluru', 'Mysore', 'Mangalore'],
    'Tamil Nadu': ['Chennai', 'Coimbatore', 'Madurai'],
    'Uttar Pradesh': ['Lucknow', 'Kanpur', 'Varanasi'],
  };

  final Map<String, List<String>> cityAreas = {
    // Maharashtra
      'Delhi': ['Connaught Place', 'Karol Bagh', 'Dwarka', 'Saket', 'Rohini'],

  'Panaji': ['Altinho', 'Campal', 'Fontainhas'],
  'Madgaon': ['Fatorda', 'Colva Road', 'Borda'],
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
  items: interestMap.keys.toList(), // show short values only
  label: 'Interests',
  hint: 'Focuses On',
  onChanged: (value) {
    if (value != null && interestMap.containsKey(value)) {
      interestController.text = value; // frontend text
    }
  },
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
                                        prefixIcon: Icon(Icons.person),
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
        if(appStateProvider.isGuest)...
          [

                          SButton(
            label: "Fetch From G-Locations for seeing schools near you",
            onPressed: _fetchFromGoogleLocation,
          ),
          ],
                              SButton(
                                label: widget.isEdit ? 'Edit' : 'Submit',
                                onPressed: () async {
                                  String boards = boardController.text.trim();
                                  String standard =
                                      standardController.text.trim();
String frontendInterest = interestController.text.trim();
String interest = interestMap[frontendInterest] ?? frontendInterest;

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
                                            latitude: _latitude,
              longitude: _longitude,
                                          
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
                                      successCallback: () async {
                                        print(
                                          appStateProvider.userPref?.toJson(),
                                        );
                                       Toasts.showSuccessOrFailureToast(
  context,
  failure: failure,
  successMsg: 'Preferences ${widget.isEdit ? 'Updated' : 'Added'}',
  popOnSuccess: false,
  successCallback: () {
    print(appStateProvider.userPref?.toJson());

    // ✅ Only redirect when preferences are updated
    if (widget.isEdit) {
      context.pushReplacementNamed(RouteNames.home);
    } else {
      // Keep existing behavior for add
      context.pushReplacementNamed(RouteNames.home);
    }
  },
);

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
  Future<void> _fetchFromGoogleLocation() async {
  try {

    // 1. Request location permission
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Toasts.showErrorToast(context, message: "Location services are disabled.");
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Toasts.showErrorToast(context, message: "Location permission denied.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Toasts.showErrorToast(context,
          message:
              "Location permission permanently denied. Enable it from settings.");
      return;
    }

    // 2. Fetch state and city using your LocationUtils
    final place = await LocationUtils.getCurrentPlace();

    print("Fetched place: $place"); // Debug

    if (place == null ||
        (place['state'] == null && place['city'] == null)) {
      Toasts.showErrorToast(context,
          message: "Could not detect state or city from Google.");
      return;
    }

    final fetchedState = place['state'] ?? '';
    final fetchedCity = place['city'] ?? '';
    final fetchedArea = place['area'] ?? '';
        final double? fetchedLat = place['latitude'] as double?;
      final double? fetchedLon = place['longitude'] as double?;

    setState(() {
      stateController.text = fetchedState;
      selectedState = fetchedState;
           _latitude = fetchedLat;
        _longitude = fetchedLon;
      cityItems = StateCityAreaUtils.getCities(fetchedState);

      if (cityItems.contains(fetchedCity)) {
        cityController.text = fetchedCity;
        selectedCity = fetchedCity;
        areaItems = StateCityAreaUtils.getAreas(fetchedCity);
      } else if (cityItems.isNotEmpty) {
        cityController.text = cityItems.first;
        selectedCity = cityItems.first;
        areaItems = StateCityAreaUtils.getAreas(cityItems.first);
      }

      if (areaItems.isNotEmpty) {
        if (areaItems.contains(fetchedArea)) {
          areaController.text = fetchedArea;
          selectedArea = fetchedArea;
        } else {
          areaController.text = areaItems.first;
          selectedArea = areaItems.first;
        }
      } else {
        areaItems = defaultAreas;
        areaController.text = defaultAreas.first;
        selectedArea = defaultAreas.first;
      }
    });

    Toasts.showSuccessToast(context, message: "Location fetched successfully.");
  } catch (e) {
    Toasts.showErrorToast(context, message: "Error fetching location: $e");
  }
}

}
