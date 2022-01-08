import 'package:bearpanel/screens/widgets/app_bar_login.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  List<Widget> widgets;
  AuthScreen({Key? key, required this.widgets}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  @override
  Widget build(BuildContext context) {
    List<Widget> new_widgets = [AppBarLoginWidget()];
    new_widgets.addAll(widget.widgets);
    return Container(
      child: Scaffold(
        backgroundColor: Color(0xFF707070),
        body:
        SingleChildScrollView(
          child: Column(
              children: new_widgets
          ),
        ),
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  List<Widget> widgets;
  AuthCard({Key? key, required this.widgets}) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.4516,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0xFF4e4e4e),
              spreadRadius: 0,
              blurRadius: 55,
              offset: Offset(0, -16), // changes position of shadow
            ),
          ],
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.widgets
        ),
      ),
    );
  }
}

