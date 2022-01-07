import 'package:bearpanel/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarLoginWidget extends PreferredSize {
  AppBarLoginWidget({Key? key})
      : super(key: key,
    preferredSize: const Size.fromHeight(350),
    child: SizedBox(
      height: 350,
      child: Container(
            color: const Color(0xFF707070),
          ),
          //Align(alignment: Alignment(0, 1), child: ScoreCardWidget()),
    ),
  );
}
