import 'package:build/view/components/constant.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefualtForm extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final bool isPassword;
  final VoidCallback? function;
  final String? initValue;
  final TextInputType? inputType;
  final bool read;
  final int? maxLength;
  final String? hint;
  List<TextInputFormatter>? inputFormatter;
  DefualtForm({
    Key? key,
    this.inputFormatter,
    this.hint,
    required this.controller,
    this.maxLength,
    required this.label,
    this.suffixIcon,
    this.prefixIcon,
    required this.isPassword,
    this.function,
    this.initValue,
    this.inputType,
    required this.read,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 10),
          child: Text(
            label,
            style:
                const TextStyle(color: CustomColors.KmainColor, fontSize: 18),
          ),
        ),
        TextFormField(
          textAlignVertical: TextAlignVertical.center,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: CustomColors.KmainColor,
          ),
          readOnly: read,
          inputFormatters: inputFormatter,
          maxLength: maxLength,
          keyboardType: inputType,
          initialValue: initValue,
          obscureText: isPassword,
          controller: controller,
          textAlign: TextAlign.start,
          decoration: InputDecoration(
            hintText: hint,
            counterText: "",
            suffixIcon: GestureDetector(
              onTap: () => function,
              child: Icon(
                suffixIcon,
                color: CustomColors.KmainColor,
              ),
            ),
            prefixIcon: Icon(
              prefixIcon,
              color: CustomColors.KmainColor,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please Fill the Form';
            }
            return null;
          },
        ),
      ],
    );
  }
}

class LoginText extends StatelessWidget {
  final String title;
  final String message;
  const LoginText({Key? key, required this.title, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            title,
            style: CustomTextStyle.KHugeFormLabes,
          ),
        ),
        const SizedBox(
          height: 14,
        ),
        Text(
          message,
          style: CustomTextStyle.KsmallReg,
        )
      ],
    );
  }
}
