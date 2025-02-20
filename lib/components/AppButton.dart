import 'package:flutter/material.dart';
import 'package:friendlywar/components/AppColors.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = AppColors.primaryColor,
    this.textColor = AppColors.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: textColor,
            backgroundColor: color,
            padding: EdgeInsets.all(16),
            textStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Text(text),
        ),
      ),
    );
  }
}
