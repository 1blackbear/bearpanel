import 'package:bearpanel/models/user.dart';
import 'package:bearpanel/screens/disciplines/disciplines_page.dart';
import 'package:bearpanel/screens/home/home_page.dart';
import 'package:bearpanel/screens/profile/profile.dart';
import 'package:bearpanel/screens/statistic/statistic_page.dart';
import 'package:bearpanel/screens/widgets/app_navigator_bar.dart';
import 'package:bearpanel/screens/widgets/check_spin.dart';
import 'package:bearpanel/services/auth.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';

//ignore: must_be_immutable
class AppRoutes extends StatefulWidget {
  bool spin_animation;
  AuthService auth;
  UserData userData;
  AppRoutes({Key? key, required this.spin_animation, required this.userData, required this.auth}) : super(key: key);

  @override
  _AppRoutesState createState() => _AppRoutesState();
}

class _AppRoutesState extends State<AppRoutes> {

  final pageViewController = PageController();

  @override
  Widget build(BuildContext context) {
    return widget.spin_animation ? SpinCheck(userData: widget.userData, auth: widget.auth, spin_animation: widget.spin_animation) : Scaffold(
        backgroundColor: AppColors.background,
        bottomNavigationBar: AnimatedBuilder(
            animation: pageViewController,
            builder:(context, snapshot) { return BottomNavigator(controller: pageViewController);}
        ),
        body: PageView(
          controller: pageViewController,
          children: [
            HomePage(data: widget.userData, auth: widget.auth, pageViewController: pageViewController),
            DisciplinesPage(user: widget.userData, auth: widget.auth),
            StatisticPage(),
            ProfilePage(auth: widget.auth),
          ],
        )
    );
  }
}