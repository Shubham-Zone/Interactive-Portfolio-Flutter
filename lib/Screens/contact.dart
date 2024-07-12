import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/Helpers/ThemeProvider.dart';

class ContactWidget extends StatelessWidget {
  ContactWidget({super.key});

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  void sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'shubhamanuj652@gmail.com',
      queryParameters: {
        'subject': _subjectController.text,
        'body': 'Name: ${_nameController.text}\nEmail: ${_emailController.text}\n\n${_messageController.text}',
      },
    );

    if (await canLaunch(emailUri.toString())) {
      await launch(emailUri.toString());
    } else {
      throw 'Could not launch email';
    }
  }

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);

    Widget buildTextField({
      required TextEditingController controller,
      required String labelText,
      int? maxLines, // Added maxLines parameter
    }) {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: TextField(
          controller: controller,
          maxLines: maxLines, // Use provided maxLines parameter
          style: TextStyle(color: themeProvider.isDarkMode ? Colors.white : Colors.white),
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(color: themeProvider.isDarkMode ? Colors.white : Colors.white), // Hint text color
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: themeProvider.isDarkMode ? Colors.white : Colors.white), // Active border color
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: themeProvider.isDarkMode ? Colors.white : Colors.white), // Border color when not focused
              borderRadius: BorderRadius.circular(10),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: themeProvider.isDarkMode ? Colors.white : Colors.white), // Default border color
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color:Colors.black.withOpacity(0.3),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Contact',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 16),
            buildTextField(
              controller: _nameController,
              labelText: 'Name',
              maxLines: 1,
            ),
            const SizedBox(height: 8),
            buildTextField(
              controller: _emailController,
              labelText: 'Email',
              maxLines: 1,
            ),
            const SizedBox(height: 8),
            buildTextField(
              controller: _subjectController,
              labelText: 'Subject',
              maxLines: 1,
            ),
            const SizedBox(height: 8),
            buildTextField(
              controller: _messageController,
              labelText: 'Message',
              maxLines: 5, // Set maxLines to 5 for larger text area
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: sendEmail,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text(
                'Send Email',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
