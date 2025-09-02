import 'package:flutter/material.dart';
import 'package:tc_sa/common/index.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SAppBar(
        title: 'My Profile',
        leading: SIcon(icon: Icons.keyboard_arrow_left),
      ),

      body: const Center(child: Text('Profile View')),
    );
  }
}
