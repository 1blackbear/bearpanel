import 'package:bearpanel/models/lesson.dart';
import 'package:bearpanel/models/user.dart';

class LessonsData {
  dynamic discipline;
  UserData user;
  LessonsData({required this.discipline, required this.user});

  LessonsData.onlyUser({required this.user});

  List<int> getList() {
    List<int>? list_period = [1];
    for (int i = 2; i <= user.periods; i++) list_period.add(i);
    return list_period;
  }

  List<Lesson>? getLessons() {
    List<Lesson> list = [];
    Lesson les;
    discipline['Atividades'].forEach((e) {
      les = new Lesson(
          title: e['Titulo'], current: e['Nota Atual'], total: e['Nota Total']);
      list.add(les);
    });
    return list;
  }

  int getIndexList(String current) {
    int index = 0;
    try {
      discipline['Atividades'].forEach((e) {
        if (e['Titulo'] == current) throw "";
        index++;
      });
    } catch (e) {}
    return index;
  }
}