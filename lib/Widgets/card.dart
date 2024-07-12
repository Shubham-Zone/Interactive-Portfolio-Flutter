import 'package:flutter/material.dart';

class SkillsCard extends StatefulWidget {
  final String title;
  final String skills;

  const SkillsCard({super.key, required this.title, required this.skills});

  @override
  _SkillsCardState createState() => _SkillsCardState();
}

class _SkillsCardState extends State<SkillsCard> {

  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        width: isHovered
            ? MediaQuery.of(context).size.width > 800
            ? 420
            : 320
            : MediaQuery.of(context).size.width > 800
            ? 400
            : 300,
        height: isHovered ? 300 : 250,
        transform: Matrix4.rotationZ(isHovered ? 0.02 : 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: isHovered ? 20 : 16,
              offset: isHovered ? const Offset(0, 10) : const Offset(0, 8),
            ),
          ],
          gradient: LinearGradient(
            colors: isHovered
                ? [Colors.white12, Colors.white70]
                : [Colors.white70, Colors.white12],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.skills,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 16),
              
            ],
          ),
        ),
      ),
    );
  }
}
