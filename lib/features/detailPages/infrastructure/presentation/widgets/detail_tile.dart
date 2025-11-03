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
      leading: Icon(icon, color: Colors.yellow.shade600), // Slightly lighter icon
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
      trailing: Text(
        value,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0),
    );
  }
}