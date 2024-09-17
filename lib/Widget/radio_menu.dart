import 'package:flutter/material.dart';

class CustomRadioMenu extends StatelessWidget {
  final dynamic value;
  final dynamic groupValue;
  final ValueChanged onChanged;
  final String text;
  final TextStyle? style;
  const CustomRadioMenu({super.key,required this.value,required this.groupValue,
    required this.onChanged, required this.text, this.style});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: RadioMenuButton(
          style: ButtonStyle(
              padding: WidgetStateProperty.all(EdgeInsets.zero),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact
          ),
          value: value,
          groupValue: groupValue,
          onChanged: (value) {
            onChanged(value);
          },
          child: Text(
              text,
              style:style?? TextStyle(color: Colors.white70))),
    );
  }
}