import 'package:bearpanel/core/app_colors.dart';
import 'package:bearpanel/core/app_text_styles.dart';
import 'package:bearpanel/models/user.dart';
import 'package:bearpanel/screens/disciplines/disciplin_detail_page.dart';
import 'package:bearpanel/screens/widgets/app_modal.dart';
import 'package:bearpanel/services/database.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'add_disciplin_modal.dart';
import '../../models/draggable_list.dart';
import 'data/individual_card_data.dart';

class DisciplinesPage extends StatefulWidget {
  UserData user;
  AnimationController animationController;
  DisciplinesPage({Key? key, required this.user, required this.animationController}) : super(key: key);

  @override
  _DisciplinesPageState createState() => _DisciplinesPageState();
}

class _DisciplinesPageState extends State<DisciplinesPage> {
  late List<DragAndDropList> lists;
  bool pressed = false;
  String current = '';

  @override
  void initState() {
    super.initState();
    lists = widget.user.disciplines.isEmpty ? [] : AllDisciplinList.getLists(widget.user).map(buildList).toList();
  }

  @override
  Widget build(BuildContext context) {
    return pressed ? DisciplinDetail(user: widget.user, index: this.getIndexList(current)) : Stack (
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
            //listDragHandle: buildDragHandle(isList: true),
            listDragOnLongPress: false,
            //itemDragHandle: buildDragHandle(),
            onItemReorder: onReorderListItem,
            onListReorder: onReorderList,
            contentsWhenEmpty: Padding(padding: EdgeInsets.only(top: 150),
            child: Center(child: Text("Nenhuma disciplina\n cadastrada", style: AppTextStyles.emptyStyle,textAlign: TextAlign.center,)),)
          ),
        ),
        Positioned(
          right: 50,
          bottom: 50,
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            tooltip: 'Adicionar Disciplina',
            onPressed: () {
              showDialog<int>(
                //backgroundColor: Colors.transparent,
                context: context,
                builder: (context) {
                  return  ModalViewr(
                    child: AddDisciplinModal(user: widget.user)
                  );
                },
              );
            },
            child: Icon(
              Icons.add,
              color: AppColors.black_pattern_dark,
              size: 45,
            ),
          ),
        ),
      ],
    );
  }

  /*DragHandle buildDragHandle({bool isList = false}) {
    final verticalAlignment = isList
        ? DragHandleVerticalAlignment.top
        : DragHandleVerticalAlignment.center;
    final color = isList ? Colors.white : Colors.black26;

    return DragHandle(
      verticalAlignment: verticalAlignment,
      child: Container(
        padding: EdgeInsets.only(right: 10),
        child: Icon(Icons.menu, color: color),
      ),
    );
  }*/

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
                          current = item.title;
                          pressed = true;
                        });
                      },
                      trailing: GestureDetector(
                          child: Icon(Icons.delete),
                        onTap: () async {
                            widget.user.disciplines.removeAt(getIndexList(item.title));
                            await DatabaseService(uid: widget.user.uid).updateUserData(
                                widget.user.name,
                                widget.user.disciplines,
                                widget.user.course_name,
                                widget.user.periods
                            );
                            setState(() {
                              lists = widget.user.disciplines.isEmpty ? [] : AllDisciplinList.getLists(widget.user).map(buildList).toList();
                            });
                        },
                      ),
                      title: Text(item.title),
                    ),
                  ),
                ))
            .toList(),
      );

  void onDelete() async {

  }

  int getIndexList(String current) {
    int index = 0;
    try {
      widget.user.disciplines.forEach((e) {
        if (e['Nome'] == current)
          throw "";
        index++;
      });
    } catch (e) {
      // leave it
    }
    return index;
  }

  void onReorderListItem(
    int oldItemIndex,
    int oldListIndex,
    int newItemIndex,
    int newListIndex,
  ) {
    setState(() {
      var movedItem = lists[oldListIndex].children.removeAt(oldItemIndex);
      lists[newListIndex].children.insert(newItemIndex, movedItem);
    });
  }

  void onReorderList(
    int oldListIndex,
    int newListIndex,
  ) {
    setState(() {
      var movedList = lists.removeAt(oldListIndex);
      lists.insert(newListIndex, movedList);
    });
  }
}
