import 'package:flutter/material.dart';

class AppBarLoginWidget extends PreferredSize {
  AppBarLoginWidget({Key? key})
      : super(key: key,
    preferredSize: const Size.fromHeight(250),
    child: SizedBox(
      height: 250,
      child: Container(
            color: const Color(0xFF707070),
          ),
    ),
  );
}
