import 'package:bearpanel/models/user.dart';
import 'package:flutter/cupertino.dart';

class AppBarWidget extends PreferredSize {
  final UserData user;
  AppBarWidget({Key? key, required this.user})
      : super(key: key,
    preferredSize: const Size.fromHeight(250),
    child: SizedBox(
      height: 250,
      child: Stack(
        children: [
          Container(
            height: 161,
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(TextSpan(
                    text: 'Olá, ',
                    //style: AppTextStyles.title,
                    children: [
                      TextSpan(
                        text: user.name,
                        //style: AppTextStyles.titleBold,
                      )
                    ])),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
