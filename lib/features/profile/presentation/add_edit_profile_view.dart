import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';
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

  // --- maps ---
  final Map<String, List<String>> stateCities = {
    'Maharashtra': ['Mumbai', 'Pune', 'Nagpur', 'Nashik', 'Thane', 'Aurangabad', 'Kolhapur', 'Amravati'],
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
    'Pune': ['Kothrud', 'Shivaji Nagar', 'Viman Nagar', 'Kalyani Nagar', 'Hinjewadi'],
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

  // ----- simple state variables -----
  List<String> cityItems = [];
  List<String> areaItems = [];

  String? selectedState;
  String? selectedCity;
  String? selectedArea;

  @override
  void initState() {
    super.initState();

    // initialize from controllers (pre-filled user values)
    selectedState = stateController.text.isNotEmpty ? stateController.text.trim() : null;
    selectedCity = cityController.text.isNotEmpty ? cityController.text.trim() : null;
    selectedArea = areaController.text.isNotEmpty ? areaController.text.trim() : null;

    if (selectedState != null && stateCities.containsKey(selectedState)) {
      cityItems = List.from(stateCities[selectedState!]!);
    }
    if (selectedCity != null && cityAreas.containsKey(selectedCity)) {
      areaItems = List.from(cityAreas[selectedCity!]!);
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
                                    getIt<AppStateProvider>().authModel?.email != Null,
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
                                        stateCities[key] != null ? List.from(stateCities[key]!) : [];

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
                                    areaItems = cityAreas[key] != null ? List.from(cityAreas[key]!) : [];

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
                            ],
                          ),
                        ),

                        // Submit button
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
                            final dateOfBirth = dateOfBirthController.text.trim();

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
                              );
                            }

                            Toasts.showSuccessOrFailureToast(
                              context,
                              failure: failure,
                              successMsg:
                                  'Profile ${widget.isEdit ? "Updated" : 'Register'} Successfully',
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
