import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaHandlesWidget extends StatelessWidget {
  const SocialMediaHandlesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8, // Adjust width as needed
        child: Card(
          elevation: 4, // Add elevation for a raised effect
          color: Colors.transparent,
          child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: [
              _buildSocialMediaCard(
                icon: Icons.chat,
                title: 'Linkedin',
                url: 'https://www.linkedin.com/in/shubham-kumar-33748a229/',
              ),
              _buildSocialMediaCard(
                icon: Icons.adb_rounded,
                title: 'Github',
                url: 'https://github.com/Shubham-Zone',
              ),
              _buildSocialMediaCard(
                icon: Icons.computer,
                title: 'Coding Ninjas',
                url: 'https://www.naukri.com/code360/profile/Shubham_kumar05',
              ),
              _buildSocialMediaCard(
                icon: Icons.computer,
                title: 'LeetCode',
                url: 'https://leetcode.com/u/DeveloperShubham_/',
              ),
              _buildSocialMediaCard(
                icon: Icons.computer,
                title: 'GeeksForGeeks',
                url: 'https://www.geeksforgeeks.org/user/devshubbhc4/',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialMediaCard({
    required IconData icon,
    required String title,
    required String url,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: InkWell(
        onTap: () => _launchURL(url),
        hoverColor: Colors.grey.withOpacity(0.1),
        child: ListTile(
          leading: Icon(icon),
          title: Text(title),
          trailing: const Icon(Icons.arrow_forward),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
