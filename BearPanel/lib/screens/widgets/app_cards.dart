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
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
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
