import 'package:animated_check/animated_check.dart';
import 'package:bearpanel/core/app_colors.dart';
import 'package:bearpanel/core/app_navigator.dart';
import 'package:bearpanel/core/app_routes.dart';
import 'package:bearpanel/models/user.dart';
import 'package:bearpanel/services/auth.dart';
import 'package:flutter/material.dart';

//ignore: must_be_immutable
class SpinCheck extends StatefulWidget {
  bool spin_animation;
  AuthService auth;
  UserData userData;
  SpinCheck({Key? key, required this.spin_animation, required this.auth, required this.userData}) : super(key: key);

  @override
  _SpinCheckState createState() => _SpinCheckState();
}

class _SpinCheckState extends State<SpinCheck> with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1800));
    _animation = new Tween<double>(begin: 0, end: 1).animate(new CurvedAnimation(parent: _animationController, curve: Curves.easeInOutCirc));
    if(widget.spin_animation) {
      _animationController.reverse();
      setState(() {
        AppNavigator.activate_detail_static = true;
      });
      _animationController.forward().then((value) => Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => AppRoutes(spin_animation: false, userData: widget.userData, auth:  widget.auth,)),(route) => false));
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 170,
                width: 170,
                decoration: BoxDecoration(
                    color: AppColors.black_pattern,
                    borderRadius: BorderRadius.all(Radius.circular(170))
                ),
                child: AnimatedCheck(
                  color: Colors.white,//Color(0xFF6848AE),
                  progress: _animation,
                  size: 170,
                ),
              ),
            ]  ,
          )
      ),
    );
  }
}
