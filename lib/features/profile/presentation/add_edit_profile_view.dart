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
  GlobalKey formKey = GlobalKey<FormState>();
  ValueNotifier<String> date = ValueNotifier<String>('');
  final AddEditProfileViewModel addEditProfileViewModel =
      AddEditProfileViewModel();
  final appStateProvider = getIt<AppStateProvider>();

  late final nameController = TextEditingController(
    text: appStateProvider.user?.name ?? '',
  );
  late final emailController = TextEditingController(
    text: appStateProvider.userEmail ?? '',
  );
  late final phoneController = TextEditingController(
    text: appStateProvider.user?.contactNo ?? '',
  );
  late final genderController = TextEditingController(
    text: appStateProvider.user?.gender ?? '',
  );
  late final dateOfBirthController = TextEditingController(
    text: appStateProvider.user?.dateOfBirth ?? '',
  );
  late final stateController = TextEditingController(
    text: appStateProvider.user?.state ?? '',
  );
  late final cityController = TextEditingController(
    text: appStateProvider.user?.city ?? '',
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: addEditProfileViewModel,
      child: Scaffold(
        appBar: widget.isEdit ? SAppBar(title: 'Edit Profile') : null,

        body: SafeArea(
          child: Selector<AddEditProfileViewModel, bool>(
            selector: (_, vm) => vm.isLoading,
            builder:
                (vmContext, isLoading, _) =>
                    isLoading
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
                                      enable: widget.isEdit,
                                      prefixIcon: Icon(Icons.email),
                                    ),
                                    STextField(
                                      controller: phoneController,
                                      label: 'Phone Number*',
                                      hint: 'Enter number',
                                      prefixIcon: Icon(Icons.phone),
                                    ),
                                    Selector<
                                      AddEditProfileViewModel,
                                      DateTime?
                                    >(
                                      selector: (_, vm) => vm.pickedDate,
                                      builder:
                                          (_, pickedDate, __) => STextField(
                                            controller: dateOfBirthController,
                                            label: 'Date of Birth*',
                                            hint: 'Select',
                                            enable: false,
                                            prefixIcon: Icon(
                                              Icons.calendar_today,
                                            ),
                                            suffixIcon: SIcon(
                                              icon: Icons.calendar_month,
                                              onTap: () async {
                                                final date =
                                                    await showDatePicker(
                                                      context: context,
                                                      firstDate: DateTime(1900),
                                                      initialDate:
                                                          DateTime.now(),
                                                      lastDate: DateTime.now(),
                                                    );

                                                if (date != null) {
                                                  addEditProfileViewModel
                                                      .pickedDate = date;
                                                  dateOfBirthController.text =
                                                      addEditProfileViewModel
                                                          .displayPickedDate;
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
                                      items: [
                                        'Maharashtra',
                                        'Gujarat',
                                        'Rajasthan',
                                        'Punjab',
                                        'Haryana',
                                        'Uttar Pradesh',
                                        'Bihar',
                                        'West Bengal',
                                        'Tamil Nadu',
                                        'Karnataka',
                                        'Andhra Pradesh',
                                        'Telangana',
                                        'Kerala',
                                        'Odisha',
                                        'Chhattisgarh',
                                        'Jharkhand',
                                        'Assam',
                                        'Himachal Pradesh',
                                        'Uttarakhand',
                                        'Goa',
                                        'Arunachal Pradesh',
                                      ],
                                      controller: stateController,
                                      label: 'State*',
                                      hint: 'Select',
                                      prefixIcon: Icon(Icons.pin_drop),
                                    ),
                                    STextField.dropdown(
                                      items: [
                                        'Mumbai',
                                        'Pune',
                                        'Nagpur',
                                        'Nashik',
                                        'Thane',
                                        'Aurangabad',
                                        'Solapur',
                                        'Amravati',
                                        'Kolhapur',
                                        'Latur',
                                      ],
                                      controller: cityController,
                                      label: 'City*',
                                      hint: 'Select',
                                      prefixIcon: Icon(Icons.location_city),
                                    ),
                                  ],
                                ),
                              ),
                              SButton(
                                label: 'Submit',
                                onPressed: () async {
                                  String name = nameController.text.trim();
                                  String email = emailController.text.trim();
                                  String phone = phoneController.text.trim();
                                  String gender = genderController.text.trim();
                                  String state = stateController.text.trim();
                                  String city = cityController.text.trim();
                                  String dateOfBirth =
                                      dateOfBirthController.text.trim();

                                  if (name.isEmpty ||
                                      email.isEmpty ||
                                      phone.isEmpty ||
                                      gender.isEmpty ||
                                      state.isEmpty ||
                                      city.isEmpty ||
                                      dateOfBirth.isEmpty) {
                                    Toasts.showErrorToast(
                                      context,
                                      message:
                                          'Kindly fill all the required field.',
                                    );
                                  } else {
                                    final failure =
                                        await addEditProfileViewModel
                                            .addProfile(
                                              name: name,
                                              email: email,
                                              phone: phone,
                                              state: state,
                                              city: city,
                                              gender: gender,
                                              dateOfBirth: dateOfBirth,
                                            );
                                    Toasts.showSuccessOrFailureToast(
                                      context,
                                      failure: failure,
                                      successMsg:
                                          'Profile Register Successfully',
                                      successCallback: () {
                                        if (widget.isEdit) {
                                          context.pop();
                                        } else {
                                          context.pushReplacementNamed(
                                            RouteNames.home,
                                          );
                                        }
                                      },
                                    );
                                  }
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
