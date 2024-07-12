import 'package:flutter/material.dart';

class DynamicButton extends StatefulWidget {

  final dynamic label;
  final dynamic iconData;
  final dynamic nav;

  const DynamicButton({super.key, required this.label,required this.iconData, required this.nav});

  @override
  _DynamicButtonState createState() => _DynamicButtonState();
}

class _DynamicButtonState extends State<DynamicButton> {

  bool isHovered = false;
  

  @override
  Widget build(BuildContext context) {

    Orientation orientation = MediaQuery.of(context).orientation;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: isHovered ? Matrix4.rotationZ(0.05) : Matrix4.identity(),
        child: ElevatedButton(
          onPressed: () {
            widget.nav();
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: isHovered ? Colors.white : Colors.grey, backgroundColor: isHovered ? Colors.blue : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 12,
            ),
            elevation: isHovered ? 12 : 8,
            shadowColor: Colors.black.withOpacity(0.2),
          ),
          // Use splashColor and highlightColor directly on the ElevatedButton
          /* splashColor: Colors.white.withOpacity(0.3),
          highlightColor: Colors.transparent, */
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isHovered ? Colors.white : Colors.black,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  widget.iconData,
                  color: isHovered ? Colors.white : Colors.grey,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(widget.label, style: TextStyle(fontSize: (orientation == Orientation.landscape ? 18 : 16)),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
