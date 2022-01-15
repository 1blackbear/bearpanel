import 'package:bearpanel/core/app_text_styles.dart';
import 'package:bearpanel/models/user.dart';
import 'package:bearpanel/screens/disciplines/disciplines_page.dart';
import 'package:bearpanel/screens/shared/app_navigator.dart';
import 'package:bearpanel/screens/widgets/app_bar_home.dart';
import 'package:bearpanel/screens/widgets/app_cards.dart';
import 'package:bearpanel/services/auth.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  UserData data;
  AuthService auth;
  HomePage({Key? key, required this.data, required this.auth})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pageViewController = PageController();

  @override
  void dispose() {
    super.dispose();
    pageViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int length = widget.data.disciplines.length;
    return Column(children: [
      AppBarHome(
        user: widget.data,
        auth: widget.auth,
      ),
      SizedBox(height: 100),
      length > 0 ? CarouselSlider.builder(
        itemCount: length,
        itemBuilder: (context, index, pageViewIndex) => GestureDetector(onTap: () {
          setState(() {
            AppNavigator.current = widget.data.disciplines[index]['Nome'];
            AppNavigator.pressed = true;
          });
          AppNavigator.pageViewController.jumpToPage(1);
          },child: InitialCard(disciplin: widget.data.disciplines[index])),
        options: CarouselOptions(height: 150, viewportFraction: 0.5),
      ) :
      Container(
        width: 250,
        height: 120,
        child: Center(child: Text("Nenhuma disciplina cadastrada",style: AppTextStyles.emptyStyle, textAlign: TextAlign.center,)),
      ),
    ]
    );
  }
}
