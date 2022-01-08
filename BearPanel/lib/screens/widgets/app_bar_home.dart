import 'dart:math';
import 'package:bearpanel/core/app_text_styles.dart';
import 'package:bearpanel/models/user.dart';
import 'package:bearpanel/services/auth.dart';
import 'package:flutter/material.dart';
import 'app_cards.dart';

class AppBarHome extends PreferredSize {
  final UserData? user;
  final AuthService auth;

  AppBarHome({required this.user, required this.auth})
      : super(
    preferredSize: Size.fromHeight(250),
    child: Container(
      height: 250,
      child: Stack(
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(gradient: LinearGradient(colors: [
              Color(0xFF707070),
              Colors.white
            ], stops: [
              0.0,
              0.695
            ], transform: GradientRotation(2.13959913 * pi))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(TextSpan(
                    text: 'Boa tarde, ',
                    style: AppTextStyles.timeStyle,
                    children: [
                      TextSpan(
                        text: '\n${user!.name.split(" ")[0]}',
                        style: AppTextStyles.nameStyle,
                      )
                    ])),
                GestureDetector(
                  onTap: () async {
                    await auth.signOut();
                  },
                  child: Icon(Icons.logout, size: 30, color: Colors.black)
                ),

              ],
            ),
          ),
          Align(alignment: Alignment(0, 2), child: ScoreCardWidget()),
        ],
      ),
    ),
  );
}
