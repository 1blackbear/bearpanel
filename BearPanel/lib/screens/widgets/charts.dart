import 'package:bearpanel/core/app_colors.dart';
import 'package:bearpanel/models/user.dart';
import 'package:bearpanel/core/app_data_value.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ChartWidget extends StatelessWidget {
  final UserData user;
  ChartWidget({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return CircularPercentIndicator(
      radius: 120.0,
      animation: true,
      animationDuration: 1500,
      lineWidth: 25.0,
      percent: AppGetValue.getMediaGeral(user),
      arcType: ArcType.HALF,
      center: Text.rich(
        TextSpan(
            text: AppGetValue.getPercentTitle(AppGetValue.getMediaGeral(user)),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
            children: [
              TextSpan(text: "%", style: TextStyle(fontSize: 15)),
            ]),
      ),
      circularStrokeCap: CircularStrokeCap.butt,
      backgroundColor: Colors.transparent,
      progressColor: AppColors.black_pattern,
      arcBackgroundColor: Color(0xFFA3A3A3),
    );
  }
}
