import 'package:bearpanel/core/app_colors.dart';
import 'package:bearpanel/core/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'charts.dart';

class ScoreCardWidget extends StatelessWidget {
  const ScoreCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: MediaQuery.of(context).size.width - 110,
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(15)),
      child: Stack(
        children: [
          Positioned(top: 20, left: 0, right: 0, child: ChartWidget()),
          Positioned(
            right: 0,
            left: 0,
            bottom: 12,
            child: Center(
              child: Text(
                "MÉDIA GERAL",
                style: AppTextStyles.mediaStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MiniCard extends StatelessWidget {
  String title;
  MiniCard({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 95,
      height: 30,
      decoration: BoxDecoration(
        color: AppColors.black_pattern,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Center(child: Text(title, style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 15),)),
    );
  }
}
