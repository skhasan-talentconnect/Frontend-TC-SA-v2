import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tc_sa/common/index.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    const String supportEmail = "synzy2025@gmail.com";
    const String officeAddress = "Bangalore, India";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SAppBar(
        title: "Contact Us",
        leading: SIcon(
          icon: Icons.keyboard_arrow_left,
          onTap: () => context.pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // --- Header ---
          Center(
            child: Icon(
              Icons.contact_mail_outlined,
              size: 80,
              color: Colors.amber.shade700,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Get in Touch',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'We would love to hear from you. Here’s how you can reach us.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey.shade600,
                ),
          ),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 24),

          // --- App Support Card ---
          _TitledCard(
            title: "App Support",
            icon: Icons.email_outlined,
            iconColor: Colors.amber.shade800,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'For technical issues, bug reports, or feedback about the app, please send us an email.',
                  style: TextStyle(fontSize: 16, height: 1.5),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () => _launchUrl('mailto:$supportEmail?subject=App Support Request'),
                    icon: const Icon(Icons.mail_outline),
                    label: const Text('Mail Us'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber.shade700,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // --- Address Card ---
          _TitledCard(
            title: "Our Office",
            icon: Icons.location_on_outlined,
            iconColor: Colors.blueGrey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  officeAddress,
                  style: TextStyle(fontSize: 16, height: 1.5),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),

          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 24),

          // --- Follow Us Section ---
          Text(
            'Follow Us',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // --- Social Icons with custom asset images ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _SocialIconWithLabel(
                assetPath: 'assets/icons/linkedIn.png',
                label: 'LinkedIn',
                onTap: () => _launchUrl('https://www.linkedin.com/company/talentsconnectss/'),
              ),
              _SocialIconWithLabel(
                assetPath: 'assets/icons/insta.png',
                label: 'Instagram',
                onTap: () => _launchUrl('https://www.instagram.com/synzy_ai/'),
              ),
              _SocialIconWithLabel(
                assetPath: 'assets/icons/facebook.png',
                label: 'Facecook',
                onTap: () => _launchUrl('https://www.facebook.com/people/SYNZY/61583168018071/'),
              ),
            ],
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

// --- Local Helper Widgets ---

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
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
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

// --- UPDATED SOCIAL ICON WIDGET ---
class _SocialIconWithLabel extends StatelessWidget {
  final String assetPath;
  final String label;
  final VoidCallback onTap;

  const _SocialIconWithLabel({
    required this.assetPath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(100),
          child: Image.asset(
            assetPath,
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
