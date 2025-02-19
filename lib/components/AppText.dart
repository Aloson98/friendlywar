import 'package:flutter/material.dart';
import 'package:friendlywar/components/AppColors.dart';

class ParagraphText extends StatelessWidget {
  final String text;
  final aligner;
  final TextStyle? style;
  final Color color;

  const ParagraphText({
    Key? key,
    required this.text,
    this.aligner = TextAlign.start,
    this.style,
    this.color = const Color.fromARGB(221, 90, 90, 90),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: aligner,
      style: TextStyle(
        fontSize: 16,
        color: color,
        overflow: TextOverflow.clip,
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final aligner;

  const TitleText({
    Key? key,
    required this.text,
    this.aligner,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 24,
        color: AppColors.primaryColor,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.clip,
      ),
    );
  }
}

class subTitle extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final aligner;

  const subTitle({
    Key? key,
    required this.text,
    this.aligner,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: aligner,
      style: TextStyle(
        fontSize: 18,
        color: AppColors.borderColor,
        overflow: TextOverflow.clip,
      ),
    );
  }
}
