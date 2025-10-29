import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/profile/presentation/location_fetching.dart';
import 'package:tc_sa/features/profile/presentation/location_utils.dart';
import 'package:tc_sa/features/profile/presentation/view_models/add_edit_profile_view_model.dart';


class AddEditProfileView extends StatefulWidget {
  const AddEditProfileView({required this.isEdit, super.key});
  final bool isEdit;

  @override
  State<AddEditProfileView> createState() => _AddEditProfileViewState();
}

class _AddEditProfileViewState extends State<AddEditProfileView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AddEditProfileViewModel addEditProfileViewModel =
      AddEditProfileViewModel();
  final appStateProvider = getIt<AppStateProvider>();

  late final TextEditingController nameController = TextEditingController(
    text: appStateProvider.user?.name ?? '',
  );
  late final TextEditingController emailController = TextEditingController(
    text: appStateProvider.userEmail ?? '',
  );
  late final TextEditingController phoneController = TextEditingController(
    text: appStateProvider.user?.contactNo ?? '',
  );
  late final TextEditingController genderController = TextEditingController(
    text: appStateProvider.user?.gender ?? '',
  );
  late final TextEditingController dateOfBirthController = TextEditingController(
    text: appStateProvider.user?.dateOfBirth?.toDDMMYYYY ?? '',
  );
  late final TextEditingController stateController = TextEditingController(
    text: appStateProvider.user?.state ?? '',
  );
  late final TextEditingController cityController = TextEditingController(
    text: appStateProvider.user?.city ?? '',
  );
  late final TextEditingController areaController = TextEditingController(
    text: appStateProvider.user?.area ?? '',
  );
    double? _latitude;
  double? _longitude;

  // ----- simple state variables -----
  List<String> cityItems = [];
  List<String> areaItems = [];

  String? selectedState;
  String? selectedCity;
  String? selectedArea;

static const List<String> defaultAreas = [
  "Main Area",
  "Central",
  "Station Road",
  "Market"
];
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


  @override
  void initState() {
    super.initState();
  _latitude = appStateProvider.user?.latitude;
    _longitude = appStateProvider.user?.longitude;
    // initialize from controllers (pre-filled user values)
    selectedState = stateController.text.isNotEmpty ? stateController.text.trim() : null;
    selectedCity = cityController.text.isNotEmpty ? cityController.text.trim() : null;
    selectedArea = areaController.text.isNotEmpty ? areaController.text.trim() : null;

    if (selectedState != null) {
      cityItems = StateCityAreaUtils.getCities(selectedState!);
    }
    if (selectedCity != null) {
      areaItems = StateCityAreaUtils.getAreas(selectedCity!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: addEditProfileViewModel,
      child: Scaffold(
        appBar: widget.isEdit
            ? SAppBar(
                leading: SIcon(
                  icon: Icons.keyboard_arrow_left,
                  onTap: () => context.pop(),
                ),
                title: 'Edit Profile',
              )
            : null,
        body: SafeArea(
          child: Selector<AddEditProfileViewModel, bool>(
            selector: (_, vm) => vm.isLoading,
            builder: (vmContext, isLoading, _) => isLoading
                ? Center(child: SLoadingIndicator())
                : SingleChildScrollView(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      spacing: 16,
                      children: [
                        if (!widget.isEdit) ...[
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 8,
                            children: [
                              const SizedBox.shrink(),
                              Text(
                                'Complete your profile',
                                style: STextStyles.s20W600,
                              ),
                              Text(
                                'Kindly fill all the details to complete your registration.',
                                style: STextStyles.s16W400,
                              ),
                            ],
                          ),
                        ],
                        Form(
                          key: formKey,
                          child: Column(
                            spacing: 16,
                            children: [
                              STextField(
                                controller: nameController,
                                label: 'Name*',
                                hint: 'Enter name',
                                prefixIcon: Icon(Icons.person),
                              ),
                              STextField(
                                controller: emailController,
                                label: 'Email*',
                                hint: 'Enter email',
                                enable:
                                    getIt<AppStateProvider>().authModel?.email != null,
                                prefixIcon: Icon(Icons.email),
                              ),
                              STextField(
                                controller: phoneController,
                                label: 'Phone Number*',
                                hint: 'Enter number',
                                prefixIcon: Icon(Icons.phone),
                              ),
                              Selector<AddEditProfileViewModel, DateTime?>(
                                selector: (_, vm) => vm.pickedDate,
                                builder: (_, pickedDate, __) => STextField(
                                  controller: dateOfBirthController,
                                  label: 'Date of Birth*',
                                  hint: 'Select',
                                  enable: false,
                                  prefixIcon: Icon(Icons.calendar_today),
                                  suffixIcon: SIcon(
                                    icon: Icons.calendar_month,
                                    onTap: () async {
                                      final date = await showDatePicker(
                                        context: context,
                                        firstDate: DateTime(1900),
                                        initialDate: DateTime.now(),
                                        lastDate: DateTime.now(),
                                      );
                                      if (date != null) {
                                        addEditProfileViewModel.pickedDate = date;
                                        dateOfBirthController.text =
                                            addEditProfileViewModel.displayPickedDate;
                                      }
                                    },
                                  ),
                                ),
                              ),
                              STextField.dropdown(
                                items: ['Male', 'Female', 'Other'],
                                controller: genderController,
                                label: 'Gender*',
                                hint: 'Select',
                                prefixIcon: Icon(Icons.male),
                              ),
                              STextField.dropdown(
                                items: StateCityAreaUtils.states,
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
                                    cityItems = StateCityAreaUtils.getCities(key);
                                    selectedCity = null;
                                    cityController.text = '';
                                    areaItems = [];
                                    selectedArea = null;
                                    areaController.text = '';
                                  });
                                },
                              ),
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
                                    areaItems = StateCityAreaUtils.getAreas(key);
                                    selectedArea = null;
                                    areaController.text = '';
                                  });
                                },
                              ),
                              STextField.dropdown(
                                items: areaItems.isNotEmpty ? areaItems : ['Other'],
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

                              SButton(
  label: "Fetch from Google Location (to see schools near you)",
  onPressed: _fetchFromGoogleLocation,
),
                            ],
                          ),
                        ),
                        SButton(
                          label: 'Submit',
                          onPressed: () async {
                            final name = nameController.text.trim();
                            final email = emailController.text.trim();
                            final phone = phoneController.text.trim();
                            final gender = genderController.text.trim();
                            final state = stateController.text.trim();
                            final city = cityController.text.trim();
                            final area = areaController.text.trim();
                            final dateOfBirth = addEditProfileViewModel.apiPickedDate;

                            if (name.isEmpty ||
                                email.isEmpty ||
                                phone.isEmpty ||
                                gender.isEmpty ||
                                state.isEmpty ||
                                city.isEmpty ||
                                area.isEmpty ||
                                dateOfBirth.isEmpty) {
                              Toasts.showErrorToast(
                                context,
                                message: 'Kindly fill all the required field.',
                              );
                              return;
                            }

                            final failure;
                            if (widget.isEdit) {
                              failure = await addEditProfileViewModel.updateProfile(
                                name: name,
                                email: email,
                                phone: phone,
                                state: state,
                                city: city,
                                gender: gender,
                                area: area,
                                dateOfBirth: dateOfBirth,
                                latitude: _latitude,
              longitude: _longitude,
                              );
                            } else {
                              failure = await addEditProfileViewModel.addProfile(
                                name: name,
                                email: email,
                                phone: phone,
                                state: state,
                                city: city,
                                gender: gender,
                                area: area,
                                dateOfBirth: dateOfBirth,
                                  latitude: _latitude,
              longitude: _longitude,
                              );
                            }

                            Toasts.showSuccessOrFailureToast(
                              context,
                              failure: failure,
                              successMsg:
                                  'Profile ${widget.isEdit ? "Updated" : 'Registered'} Successfully',
                              popOnSuccess: false,
                              successCallback: () {
                                if (widget.isEdit) {
                                  context.pop();
                                } else {
                                  if (appStateProvider.isPrefRemaining) {
                                    context.pushReplacementNamed(
                                      RouteNames.preferences,
                                      extra: false,
                                    );
                                  } else {
                                    context.pushReplacementNamed(
                                      RouteNames.home,
                                    );
                                  }
                                }
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}