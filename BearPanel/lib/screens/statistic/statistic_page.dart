import 'package:bearpanel/core/app_text_styles.dart';
import 'package:flutter/material.dart';

class StatisticPage extends StatefulWidget {
  const StatisticPage({Key? key}) : super(key: key);

  @override
  _StatisticPageState createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Página de Estatísticas\n em breve", style: AppTextStyles.emptyStyle,textAlign: TextAlign.center,)
      ],
    );
  }
}
