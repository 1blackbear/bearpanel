import 'package:bearpanel/core/app_colors.dart';
import 'package:bearpanel/core/app_data_value.dart';
import 'package:bearpanel/core/app_text_styles.dart';
import 'package:bearpanel/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'charts.dart';

class ScoreCardWidget extends StatelessWidget {
  final UserData user;
  const ScoreCardWidget({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: MediaQuery.of(context).size.width - 110,
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(spreadRadius: -10,blurRadius: 17, color: AppColors.black_pattern)]
      ),
      child: Stack(
        children: [
          Positioned(top: 20, left: 0, right: 0, child: ChartWidget(user: user,)),
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
  final String title;
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

//ignore: must_be_immutable
class InitialCard extends StatelessWidget {
  dynamic discipline;
  InitialCard({Key? key, required this.discipline}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(spreadRadius: -14,blurRadius: 17, color: AppColors.black_pattern)]
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(discipline['Nome'], style: AppTextStyles.descForm,),
            SizedBox(height: 10),
            Text("Nota atual: ${AppGetValue.getAtual(discipline) == 100 ? 100 : AppGetValue.getAtual(discipline).toStringAsFixed(1)}/${AppGetValue.getTotal(discipline) == 100 ? 100 : AppGetValue.getTotal(discipline).toStringAsFixed(1)}"
            ,style: TextStyle(color: Color(0xFF8b8b8b), fontSize: 12),),
            SizedBox(height: 5),
            Text("Média: ${AppGetValue.getMedia(discipline) == 0.0 || AppGetValue.getMedia(discipline).isNaN ? 0 : AppGetValue.getMedia(discipline) == 1 ? 100 : AppGetValue.getMedia(discipline).toStringAsFixed(2).substring(2)}%",
                style: TextStyle(color: Color(0xFF8b8b8b), fontSize: 12)),
            SizedBox(height: 5),
            Text("Status: ${AppGetValue.getStatus(discipline)}", style: TextStyle(color: Color(0xFF8b8b8b), fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

