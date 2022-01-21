import 'package:bearpanel/core/app_routes.dart';
import 'package:bearpanel/models/user.dart';
import 'package:bearpanel/screens/widgets/app_loading.dart';
import 'package:bearpanel/services/auth.dart';
import 'package:bearpanel/services/database.dart';
import 'package:flutter/material.dart';

class AppNavigator {
  static bool activate_detail = false;
  static bool activate_detail_static = false;
  static String uid = '';
}

//ignore: must_be_immutable
class NavigatorBase extends StatefulWidget {
  AuthService auth;
  NavigatorBase({Key? key, required this.auth}) : super(key: key);

  @override
  _NavigatorBaseState createState() => _NavigatorBaseState();
}

class _NavigatorBaseState extends State<NavigatorBase>{

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: widget.auth.user_state!.uid).userData,
      builder: (context, snapshot) {
        UserData? userData = snapshot.data;
        if (snapshot.hasData) {
          return AppRoutes(spin_animation: false, userData: userData!, auth: widget.auth);
        } else {
          return Loading();
        }
      },
    );
  }
}
