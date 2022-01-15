import 'package:bearpanel/core/app_colors.dart';
import 'package:bearpanel/core/app_date.dart';
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
            decoration: BoxDecoration(
              image: DecorationImage(
               image: AssetImage('images/background.jpg'),
                  fit: BoxFit.fill
              )
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 65,
                  child: Text.rich(TextSpan(
                      text: '${CurrentDateTime.getHour()}, ',
                      style: AppTextStyles.timeStyle,
                      children: [
                        TextSpan(
                          text: '\n${user!.name.split(" ")[0]}',
                          style: AppTextStyles.nameStyle,
                        )
                      ])),
                ),
                Positioned(
                  right: 0,
                  top: 70,
                  child: GestureDetector(
                    onTap: () async {
                      await auth.signOut();
                    },
                    child: Icon(Icons.logout, size: 32, color: AppColors.white)
                  ),
                ),

              ],
            ),
          ),
          Align(alignment: Alignment(0, 2), child: ScoreCardWidget(user: user,)),
        ],
      ),
    ),
  );
}
