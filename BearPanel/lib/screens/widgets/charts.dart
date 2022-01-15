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

    String getTitle(){
      double value = AppGetValue.getMediaGeral(user);
      if (value.toString().length > 4)
        return "${value.toStringAsFixed(2).substring(2)}.${value.toStringAsFixed(3).substring(4)}";
      else if (value == 0)
        return 0.toString();
      else if (value == 1)
        return 100.toString();
      else
        return value.toStringAsFixed(2).substring(2);
    }

    return CircularPercentIndicator(
      radius: 120.0,
      animation: true,
      animationDuration: 1500,
      lineWidth: 25.0,
      percent: AppGetValue.getMediaGeral(user),
      arcType: ArcType.HALF,
      center: Text.rich(
        TextSpan(
            text: getTitle(),
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
