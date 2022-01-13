import 'package:animated_check/animated_check.dart';
import 'package:bearpanel/core/app_colors.dart';
import 'package:bearpanel/models/user.dart';
import 'package:bearpanel/screens/disciplines/disciplines_page.dart';
import 'package:bearpanel/screens/home/home_page.dart';
import 'package:bearpanel/screens/profile/profile.dart';
import 'package:bearpanel/screens/statistic/statistic_page.dart';
import 'package:bearpanel/screens/widgets/app_navigator.dart';
import 'package:bearpanel/screens/widgets/loading.dart';
import 'package:bearpanel/services/auth.dart';
import 'package:bearpanel/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigatorBase extends StatefulWidget {
  bool spin_animation;
  NavigatorBase({Key? key, required this.spin_animation}) : super(key: key);

  @override
  _NavigatorBaseState createState() => _NavigatorBaseState();
}

class _NavigatorBaseState extends State<NavigatorBase>  with SingleTickerProviderStateMixin {

  final pageViewController = PageController(); 
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1800));
    _animation = new Tween<double>(begin: 0, end: 1).animate(new CurvedAnimation(parent: _animationController, curve: Curves.easeInOutCirc));
    if(widget.spin_animation) {
      _animationController.reverse();
      _animationController.forward().then((value) => Navigator.push(context,
          MaterialPageRoute(builder: (context) => NavigatorBase(spin_animation: false,))));
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    pageViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: auth.user_state!.uid).userData,
      builder: (context, snapshot) {
        UserData? userData = snapshot.data;
        if (snapshot.hasData) {
          return
            widget.spin_animation ? Scaffold(
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
            ) : Scaffold(
                backgroundColor: AppColors.background,
                bottomNavigationBar: AnimatedBuilder(
                  animation: pageViewController,
                    builder:(context, snapshot) { return BottomNavigator(controller: pageViewController);}
                ),
                body: PageView(
                  controller: pageViewController,
                  children: [
                    HomePage(data: userData!, auth: auth,),
                    DisciplinesPage(user: userData, animationController: _animationController,),
                    StatisticPage(),
                    ProfilePage(auth: auth,)
                  ],
                )
            );
        } else {
          return Loading();
        }
      },
    );
  }
}
