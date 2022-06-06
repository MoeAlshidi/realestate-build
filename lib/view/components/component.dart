import 'package:build/view/components/constant.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../shared/cubit/home_cubit.dart';

class DefualtForm extends StatefulWidget {
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
  State<DefualtForm> createState() => _DefualtFormState();
}

class _DefualtFormState extends State<DefualtForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 10),
          child: Text(
            widget.label,
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
          readOnly: widget.read,
          inputFormatters: widget.inputFormatter,
          maxLength: widget.maxLength,
          keyboardType: widget.inputType,
          initialValue: widget.initValue,
          obscureText: widget.isPassword,
          controller: widget.controller,
          textAlign: TextAlign.start,
          decoration: InputDecoration(
            hintText: widget.hint,
            counterText: "",
            suffixIcon: GestureDetector(
              onTap: widget.function,
              child: Icon(
                widget.suffixIcon,
                color: CustomColors.KmainColor,
              ),
            ),
            prefixIcon: Icon(
              widget.prefixIcon,
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

class BalanceBottomSheet extends StatefulWidget {
  const BalanceBottomSheet({
    Key? key,
    required this.screenSize,
    required GlobalKey<FormState> dialogFormKey,
    required TextEditingController textEditingController,
    required this.homeCubit,
  })  : _dialogFormKey = dialogFormKey,
        _textEditingController = textEditingController,
        super(key: key);

  final Size screenSize;
  final GlobalKey<FormState> _dialogFormKey;
  final TextEditingController _textEditingController;
  final HomeCubit homeCubit;

  @override
  State<BalanceBottomSheet> createState() => _BalanceBottomSheetState();
}

class _BalanceBottomSheetState extends State<BalanceBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Container(
      padding: mediaQueryData.viewInsets,
      color: const Color(0xff737373),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 56,
                  height: 9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xffc4c4c4),
                  ),
                ),
              ),
              Form(
                key: widget._dialogFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Project Progress',
                      // style: constants.KbigLabes,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 90,
                      width: MediaQuery.of(context).size.width,
                      child: CupertinoPicker(
                        itemExtent: 30,
                        children: [
                          for (int i = 1; i <= 10; i++)
                            Text(
                              "${i * 10}%",
                              // style: const TextStyle(
                              //   color: constants.KtextColor,
                              // ),
                            ),
                        ],
                        onSelectedItemChanged: (int index) {
                          setState(() {
                            widget.homeCubit.projectModel?.progress = index + 1;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Cancel',
                      ),
                    ),
                    const SizedBox(
                      width: 26,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: CustomColors.KmainColor,
                      ),
                      onPressed: () {
                        // homeCubit.updateIncomeDay();
                        // print(widget.homeCubit.projectModel?.progress);

                        Navigator.pop(
                            context, widget.homeCubit.projectModel?.progress);
                      },
                      child: const Text(
                        'Ok',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
