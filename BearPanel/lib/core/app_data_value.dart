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

/*static double getTotal(UserData user, int index) {
    double total = 0.0;
    for(int i = 0; i < user.disciplines[index]['Atividades'].length;i++)
      total += user.disciplines[index]['Atividades'][i]['Nota Total'];
    return total;
  }*/

/*static double getAtual(UserData user, int index) {
    double atual = 0.0;
    for(int i = 0; i < user.disciplines[index]['Atividades'].length;i++)
      atual += user.disciplines[index]['Atividades'][i]['Nota Atual'];
    return atual;
  }*/
/*static double getMedia(UserData user, int index) {
    return getAtual(user, index) / getTotal(user, index);
  }*/
}