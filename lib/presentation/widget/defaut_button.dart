import 'package:flutter/material.dart';
import 'package:magdsoft_flutter_structure/presentation/styles/colors.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({Key? key, required this.text,
    required this.onPressedCallback, this.backgroundColor = AppColor.grey,
    this.textColor = AppColor.white}) : super(key: key);


  final String text;
  final Function onPressedCallback;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
      elevation: 5.0,
      child: MaterialButton(
        onPressed: () {
          onPressedCallback();
        },

        child: Text(text, style: TextStyle(color: textColor),),
      ),
    );
  }
}
