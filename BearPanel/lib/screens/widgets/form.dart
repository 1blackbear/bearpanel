import 'package:flutter/material.dart';


class CustomForm extends StatefulWidget {
  Function(String) onChanged;
  dynamic validator;
  TextInputType  keyboardType;
  String initialValue;
  final bool enabled;
  final String hintText;
  CustomForm ({ Key ?key, required this.enabled, required this.initialValue, required this.hintText, required this.onChanged, required this.keyboardType, required this.validator}): super(key: key);
  @override
  _CustomFormState createState() => _CustomFormState();
}
class _CustomFormState extends State<CustomForm> {
  String formValue = '';

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      //form field name
      cursorColor: const Color(0xFF707070),
      decoration: InputDecoration(
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF525151),
            width: 2.0,
          ),
        ),
        contentPadding: const EdgeInsets.only(top: 8, bottom: 8),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: Colors.black.withOpacity(0.4),
          fontSize: 14.0,
        ),
      ),
      keyboardType: widget.keyboardType,
      initialValue: widget.initialValue,
      enabled: widget.enabled,
      validator:widget.validator,
      onChanged: (val) {
        widget.onChanged(formValue = val);
      },
    );
  }
}