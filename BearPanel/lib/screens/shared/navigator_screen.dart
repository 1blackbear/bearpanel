import 'package:bearpanel/models/user.dart';
import 'package:bearpanel/screens/disciplines/disciplines_page.dart';
import 'package:bearpanel/screens/home/home_page.dart';
import 'package:bearpanel/screens/widgets/app_navigator.dart';
import 'package:bearpanel/screens/widgets/loading.dart';
import 'package:bearpanel/services/auth.dart';
import 'package:bearpanel/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigatorBase extends StatefulWidget {
  NavigatorBase({Key? key}) : super(key: key);

  @override
  _NavigatorBaseState createState() => _NavigatorBaseState();
}

class _NavigatorBaseState extends State<NavigatorBase> {

  final pageViewController = PageController();

  @override
  void dispose() {
    super.dispose();
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
            Scaffold(
                backgroundColor: Color(0xFFF5F5F5),
                bottomNavigationBar: BottomNavigator(controller: pageViewController),
                body: PageView(
                  controller: pageViewController,
                  children: [
                    HomePage(data: userData!, auth: auth,),
                    DisciplinesPage()
                  ],
                ) /*Column(children: [
                AppBarHome(
                  user: userData,
                  auth: auth,
                ),
              ]),*/
            );
        } else {
          return Loading();
        }
      },
    );
  }
}
