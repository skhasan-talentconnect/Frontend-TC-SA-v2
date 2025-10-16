import 'package:flutter/material.dart';
import 'package:tc_sa/common/index.dart';

class NoInternetView extends StatelessWidget {
  const NoInternetView({this.onTab, super.key});

  final VoidCallback? onTab;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.info, color: Colors.red, size: 92),
                const SizedBox(height: 16),
                Text('No Internet Connection', style: STextStyles.s24W600),
                Text(
                  'Make sure you have a stable internet\nconnection.',
                  textAlign: TextAlign.center,
                  style: STextStyles.s12W400,
                ),
                const SizedBox(height: 16),
                SButton(
                  label: 'Reload',
                  backgroundColor: Colors.red,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
