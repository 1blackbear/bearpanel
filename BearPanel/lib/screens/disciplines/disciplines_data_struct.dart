import 'package:bearpanel/models/user.dart';
import '../../models/draggable_list.dart';

class DisciplinesListData {
  static List<DraggableList> getLists(UserData data) {
    return [
      DraggableList(
          header: 'Disciplinas Cadastradas',
          items: getList(data)
      )
    ];
  }

  static List<DraggableListItem> getList(UserData data) {
    List<DraggableListItem> list = [];
    for (int i = 0; i < data.disciplines.length; i++)
      if (!data.disciplines[i]['Finalizada?'])
        list.add(new DraggableListItem(title: data.disciplines[i]['Nome']));
    return list;
  }

  static int getIndexList(UserData user, String current) {
    int index = 0;
    try {
      user.disciplines.forEach((e) {
        if (e['Nome'] == current)
          throw "";
        index++;
      });
    } catch (e) {}
    return index;
  }
}