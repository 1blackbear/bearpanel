import 'package:bearpanel/models/user.dart';
import 'package:bearpanel/services/auth.dart';
import 'package:bearpanel/services/auth_files.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AppWidget extends StatelessWidget {
  AppWidget({Key? key}) : super(key: key);
  Users u = Users(uid: "default");
    @override
    Widget build(BuildContext context) {
      return StreamProvider<Users?>.value(
        value: AuthService().user,
        initialData: u,
        child: MaterialApp(
          home: Authenticate(),
          debugShowCheckedModeBanner: false,
          title: 'BearPanel',
        ),
      );
  }
}
