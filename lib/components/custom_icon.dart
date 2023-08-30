import 'package:flutter/material.dart';

class CustomIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color unselectedColor;
  final Color selectedColor;

  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.unselectedColor,
    required this.selectedColor,
  });

  @override
  _CustomIconButtonState createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        widget.icon,
        color: isSelected ? widget.selectedColor : widget.unselectedColor,
      ),
      onPressed: () {
        setState(() {
          isSelected = !isSelected;
        });
        widget.onPressed();
      },
    );
  }
}
