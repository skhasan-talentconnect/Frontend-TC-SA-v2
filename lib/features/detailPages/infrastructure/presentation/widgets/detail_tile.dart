import 'package:flutter/material.dart';

class DetailTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const DetailTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey.shade700),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: Text(
        value,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      contentPadding: EdgeInsets.zero,
    );
  }
}