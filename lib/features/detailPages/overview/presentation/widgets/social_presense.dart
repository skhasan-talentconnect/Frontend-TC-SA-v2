import 'package:flutter/material.dart';
import 'package:tc_sa/features/detailPages/overview/data/entities/overview_model.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialLinksSection extends StatelessWidget {
  final SchoolModel school;
  const SocialLinksSection({required this.school});

  @override
  Widget build(BuildContext context) {
    final links = <_SocialLink>[
      _SocialLink(
        name: 'Website',
        url: school.website,
        icon: Icons.language_outlined,
      color: Colors.blueAccent,
      ),
      _SocialLink(
        name: 'LinkedIn',
        url: school.linkedinHandle,
        icon: Icons.linked_camera_outlined,
        color: Colors.indigo,
      ),
      _SocialLink(
        name: 'Instagram',
        url: school.instagramHandle,
        icon: Icons.camera_alt_outlined,
        color: Colors.pinkAccent,
      ),
      _SocialLink(
        name: 'Twitter',
        url: school.twitterHandle,
        icon: Icons.alternate_email_outlined,
        color: Colors.lightBlue,
      ),
    ].where((e) => e.url?.trim().isNotEmpty ?? false).toList();

    if (links.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text(
          "No online profiles available",
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
            fontStyle: FontStyle.italic,
          ),
        ),
      );
    }

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: links
          .map(
            (link) => InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () async {
                final url = Uri.parse(
                  link.url!.startsWith('http')
                      ? link.url!
                      : 'https://${link.url!}',
                );
                if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Could not open ${link.name}")),
                  );
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    colors: [
                      link.color.withOpacity(0.1),
                      link.color.withOpacity(0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(color: link.color.withOpacity(0.4)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(link.icon, color: link.color, size: 22),
                    const SizedBox(width: 8),
                    Text(
                      link.name,
                      style: TextStyle(
                        color: link.color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.arrow_outward_rounded,
                        color: Colors.black45, size: 18),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _SocialLink {
  final String name;
  final String? url;
  final IconData icon;
  final Color color; // ✅ changed from MaterialColor → Color


  _SocialLink({
    required this.name,
    required this.url,
    required this.icon,
    required this.color,
  });
}
