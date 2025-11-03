import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tc_sa/common/index.dart'; // Assuming SAppBar and SIcon are here
import 'package:url_launcher/url_launcher.dart'; // Add 'url_launcher' to your pubspec.yaml

class SupportView extends StatelessWidget {
  const SupportView({super.key});

  // Helper method to launch URLs
 Future<void> _launchUrl(String url) async {
  Uri uri;

  if (url.contains('@') && !url.startsWith('mailto:')) {
    // 📧 If it's an email address, convert to mailto link
    uri = Uri(
      scheme: 'mailto',
      path: url,
    );
  } else {
    // 🌐 For normal URLs
    uri = Uri.parse(url);
  }

  if (!await launchUrl(uri)) {
    print('Could not launch $url');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SAppBar(
        title: "Support & About",
        leading: SIcon(
          icon: Icons.keyboard_arrow_left,
          onTap: () => context.pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // --- Main Header ---
          Center(
            child: Icon(
              Icons.support_agent,
              size: 80,
              color: Colors.amber.shade700,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'How can we help?',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Get in touch with us for any admission consultancy or app questions.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey.shade600,
                ),
          ),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 24),

          // --- Admission Consultancy Card ---
          _TitledCard(
            title: "Admission Consultancy",
            icon: Icons.school_outlined,
            iconColor: Colors.amber.shade800,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'For any admission-related consultancy, feel free to contact us directly. Our team is ready to assist you with your application process.',
                  style: TextStyle(fontSize: 16, height: 1.5),
                ),
                const SizedBox(height: 20),
                // --- EMAIL ROW REMOVED ---
                _ContactRow(
                  icon: Icons.phone_outlined,
                  text: '+91 84314 72672',
                  onTap: () => _launchUrl('tel:+918431472672'),
                ),
                  const SizedBox(height: 20),
                // --- EMAIL ROW REMOVED ---
               _ContactRow(
  icon: Icons.email,
  text: 'synzy2025@gmail.com',
  onTap: () => _launchUrl('synzy2025@gmail.com'),
),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // --- About App Card ---
          _TitledCard(
            title: "About Our App",
            icon: Icons.info_outline,
            iconColor: Colors.blueGrey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'This app is designed to be your one-stop solution for finding the best schools. You can search, filter, and compare schools based on your preferences, and apply directly through the app.',
                  style: const TextStyle(fontSize: 16, height: 1.5),
                ),
                const SizedBox(height: 16),
                Text(
                  'Version 1.0.0', // You can make this dynamic later
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- Local Helper Widget for Titled Cards ---
class _TitledCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;
  final Color iconColor;

  const _TitledCard({
    required this.title,
    required this.icon,
    required this.child,
    this.iconColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200, width: 1),
      ),
      shadowColor: Colors.black.withOpacity(0.05),
      color: Colors.white,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: iconColor, size: 28),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(height: 24, thickness: 1, color: Color(0xFFF1F5F9)),
            child,
          ],
        ),
      ),
    );
  }
}

// --- Local Helper Widget for Clickable Contact Info ---
class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const _ContactRow({required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue.shade700, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}