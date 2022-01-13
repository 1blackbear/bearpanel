import 'package:bearpanel/models/user.dart';

import '../../../models/draggable_list.dart';
class AllDisciplinList {
  static List<DraggableList> getLists(UserData data) {
    return [
      DraggableList(
          header: 'Disciplinas Cadastradas',
          items: data.disciplines.map((disciplin) =>
             DraggableListItem(title: disciplin['Nome'])).toList()
      )
    ];
  }
}
