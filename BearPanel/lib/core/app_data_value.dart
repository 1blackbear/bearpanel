import 'package:bearpanel/models/user.dart';

class AppGetValue {

  static double getTotal(dynamic discipline) {
    double total = 0.0;
    for(int i = 0; i < discipline['Atividades'].length;i++)
      total += discipline['Atividades'][i]['Nota Total'];
    return total;
  }

  static double getAtual(dynamic discipline) {
    double atual = 0.0;
    for(int i = 0; i < discipline['Atividades'].length;i++)
      atual += discipline['Atividades'][i]['Nota Atual'];
    return atual;
  }

  static double getMedia(dynamic discipline) {
    return getAtual(discipline) / getTotal(discipline);
  }

  static double getMediaGeral(UserData user) {
    double media = 0.0;
    for (int i = 0; i < user.disciplines.length;i++) {
      getMedia(user.disciplines[i]).isNaN ?
      media += 0.0
          :
      media += getMedia(user.disciplines[i]);
    }
    if(user.disciplines.length > 0) media /= user.disciplines.length;
    return media;
  }

  static String getStatus(dynamic discipline){
    return AppGetValue.getMedia(discipline) >= 0.6 ? 'aprovado' : 'reprovado';
  }

  static String getPercentTitle(double value){
    if (value.toString().length > 4)
      return "${value.toStringAsFixed(2).substring(2)}.${value.toStringAsFixed(3).substring(4)}";
    else if (value == 0 || value.isNaN)
      return 0.toString();
    else if (value == 1)
      return 100.toString();
    else
      return value.toStringAsFixed(2).substring(2);
  }

}