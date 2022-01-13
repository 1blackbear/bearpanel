import 'package:bearpanel/models/user.dart';

import '../../../models/draggable_list.dart';
class AllDisciplinList {

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
}
