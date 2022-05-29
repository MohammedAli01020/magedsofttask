
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';




Widget defaultTextFiled({

  String? initValue,
  String hint = "",
  required TextInputType inputType,
  String? Function(String?)? validator,
  required BuildContext context,
  List<TextInputFormatter>? inputFormatter,
  int? minLines,
  int? maxLines = 1,
  int? maxLength,
  Widget? prefix,
  Widget? suffixIcon,
  bool obSecure = false,
  // Color fillColor = AppColor.white,
  TextEditingController? controller,
  TextCapitalization capitalization =  TextCapitalization.none,
}) {
  return TextFormField(


    controller: controller,
    minLines: minLines,
    maxLines: maxLines,
    obscureText: obSecure,
    inputFormatters: inputFormatter ?? [],
    initialValue: initValue,

    textCapitalization: capitalization,
    keyboardType: inputType,
    maxLength: maxLength,
    decoration: InputDecoration(
      prefixIcon: prefix,
      suffixIcon: suffixIcon,
      hintText: hint,
      fillColor: Colors.blue,
      contentPadding: const EdgeInsets.symmetric(horizontal: 5.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
    ),
    validator: validator,
  );
}
