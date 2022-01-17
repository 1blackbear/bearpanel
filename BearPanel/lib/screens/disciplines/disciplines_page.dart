import 'package:bearpanel/core/app_colors.dart';
import 'package:bearpanel/core/app_navigator.dart';
import 'package:bearpanel/core/app_text_styles.dart';
import 'package:bearpanel/models/user.dart';
import 'package:bearpanel/screens/disciplines/disciplines_crud/add_discipline_widget.dart';
import 'package:bearpanel/screens/disciplines/lesson/lessons_page.dart';
import 'package:bearpanel/services/database.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import '../../models/draggable_list.dart';
import 'disciplines_data_struct.dart';

//ignore: must_be_immutable
class DisciplinesPage extends StatefulWidget {
  UserData user;
  DisciplinesPage({Key? key, required this.user}) : super(key: key);

  @override
  _DisciplinesPageState createState() => _DisciplinesPageState();
}

class _DisciplinesPageState extends State<DisciplinesPage> {
  late List<DragAndDropList> lists;

  @override
  void initState() {
    super.initState();
    lists = widget.user.disciplines.isEmpty ? [] :
    DisciplinesListData.getList(widget.user).isEmpty ? [] :
    DisciplinesListData.getLists(widget.user).map(buildList).toList();
  }

  @override
  Widget build(BuildContext context) {
    return AppNavigator.activate_detail ? LessonsPage(discipline: widget.user.disciplines[DisciplinesListData.getIndexList(widget.user, AppNavigator.uid)], user: widget.user, return_page: widget,) : Stack (
      children: [
        SizedBox(
          child: DragAndDropLists(
            addLastItemTargetHeightToTop: true,
              lastItemTargetHeight: 30,
            listPadding: EdgeInsets.only(top: 50, left: 16, right: 16),
            listInnerDecoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(10),
            ),
            children: lists,
            itemDivider:
                Divider(thickness: 10, height: 5, color: AppColors.background),
            itemDecorationWhileDragging: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
            ),
            listDragOnLongPress: false,
            onItemReorder: onReorderListItem,
            onListReorder: onReorderList,
            contentsWhenEmpty: Padding(padding: EdgeInsets.only(top: 150),
            child: Center(child: Text("Nenhuma disciplina\n cadastrada", style: AppTextStyles.emptyStyle,textAlign: TextAlign.center,)),)
          ),
        ),
       AddDiscipline(user: widget.user)
      ],
    );
  }

  DragAndDropList buildList(DraggableList list) => DragAndDropList(
        header: Container(
          child: Text(
            list.header,
            style: AppTextStyles.descForm,
          ),
        ),
        children: list.items
            .map((item) => DragAndDropItem(
                  child: Container(
                    color: AppColors.white,
                    child: ListTile(
                      onTap: () {
                        setState(() {
                          AppNavigator.uid = item.title;
                          AppNavigator.activate_detail = true;
                        });
                      },
                      trailing: GestureDetector(
                          child: Icon(Icons.delete),
                        onTap: () async {
                            widget.user.disciplines.removeAt(DisciplinesListData.getIndexList(widget.user, item.title));
                            await DatabaseService(uid: widget.user.uid).updateUserData(
                                widget.user.name,
                                widget.user.disciplines,
                                widget.user.course_name,
                                widget.user.periods
                            );
                            setState(() {
                              lists = widget.user.disciplines.isEmpty ? [] :
                              DisciplinesListData.getList(widget.user).isEmpty ? [] :
                              DisciplinesListData.getLists(widget.user).map(buildList).toList();
                            });
                        },
                      ),
                      title: Text(item.title),
                    ),
                  ),
                ))
            .toList(),
      );

  void onReorderListItem(int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      var movedItem = lists[oldListIndex].children.removeAt(oldItemIndex);
      lists[newListIndex].children.insert(newItemIndex, movedItem);
    });
  }

  void onReorderList(int oldListIndex, int newListIndex) {
    setState(() {
      var movedList = lists.removeAt(oldListIndex);
      lists.insert(newListIndex, movedList);
    });
  }
}