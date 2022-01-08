import 'package:bearpanel/services/auth_file.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  AppWidget({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        home: AuthFile(),
        debugShowCheckedModeBanner: false,
        title: 'BearPanel',
      );
  }
}
