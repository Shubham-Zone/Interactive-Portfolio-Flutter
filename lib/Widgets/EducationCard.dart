import 'package:flutter/material.dart';

class EducationCard extends StatelessWidget {
  final String imageUrl;
  final String institution;
  final String degree;
  final String duration;

  const EducationCard({
    required this.imageUrl,
    required this.institution,
    required this.degree,
    required this.duration,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          color: Colors.transparent,
          elevation: 0,
          child: Container(
            padding: const EdgeInsets.all(16),
            alignment: constraints.maxWidth > 600 ? Alignment.center : Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width:constraints.maxWidth > 600 ? MediaQuery.of(context).size.width * 0.15 : 0,),
                Container(
                  width: constraints.maxWidth * 0.2 < 100 ? constraints.maxWidth * 0.2 : 100,
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.contain,
                    height: constraints.maxWidth * 0.2 < 100 ? constraints.maxWidth * 0.2 : 100,
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  width: constraints.maxWidth * 0.6 < 300 ? constraints.maxWidth * 0.6 : 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        institution,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        degree,
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        duration,
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
