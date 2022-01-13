import 'package:bearpanel/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ChartWidget extends StatelessWidget {
  const ChartWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double value = 67;
    return CircularPercentIndicator(
      radius: 120.0,
      animation: true,
      animationDuration: 1500,
      lineWidth: 25.0,
      percent: value / 100,
      arcType: ArcType.HALF,
      center: Text.rich(
        TextSpan(
            text: value.toString().substring(0, 2),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.0),
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
