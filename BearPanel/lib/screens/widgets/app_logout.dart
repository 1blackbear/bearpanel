import 'package:bearpanel/services/auth.dart';
import 'package:bearpanel/services/auth_file.dart';
import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_navigator.dart';

//ignore: must_be_immutable
class Logout extends StatefulWidget {
  AuthService auth;
  Logout({Key? key, required this.auth}) : super(key: key);

  @override
  _LogoutState createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          await widget.auth.signOut();
          if (AppNavigator.activate_detail_static)
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) => AuthFile()),(route) => false);
        },
        child: Icon(Icons.logout, size: 32, color: AppColors.white)
    );
  }
}
