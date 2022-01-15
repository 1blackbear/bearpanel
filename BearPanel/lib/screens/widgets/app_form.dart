import 'package:bearpanel/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//ignore: must_be_immutable
class CustomForm extends StatefulWidget {
  Function(String) onChanged;
  TextInputType  keyboardType;
  String initialValue;
  final bool enabled;
  final String hintText;
  CustomForm ({ Key ?key, required this.enabled, required this.initialValue, required this.hintText, required this.onChanged, required this.keyboardType}): super(key: key);
  @override
  _CustomFormState createState() => _CustomFormState();
}
class _CustomFormState extends State<CustomForm> {
  String formValue = '';

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      //form field name
      cursorColor: AppColors.black_pattern,
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp(r'[,]')),
      ],
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.black_pattern,
            width: 2.0,
          ),
        ),
        contentPadding: const EdgeInsets.only(top: 8, bottom: 8, left: 5),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: AppColors.password,
          fontSize: 14.0,
        ),
      ),
      keyboardType: widget.keyboardType,
      initialValue: widget.initialValue,
      enabled: widget.enabled,
      onChanged: (val) {
        widget.onChanged(formValue = val);
      },
    );
  }
}