import 'package:bearpanel/core/app_text_styles.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'data/draggable_list.dart';
import 'data/individual_card_data.dart';

class DisciplinesPage extends StatefulWidget {
  const DisciplinesPage({Key? key}) : super(key: key);

  @override
  _DisciplinesPageState createState() => _DisciplinesPageState();
}

class _DisciplinesPageState extends State<DisciplinesPage> {
  late List<DragAndDropList> lists;

  @override
  void initState() {
    super.initState();
    lists = allLists.map(buildList).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          child: DragAndDropLists(
            addLastItemTargetHeightToTop: true,
              lastItemTargetHeight: 30,
            listPadding: EdgeInsets.only(top: 50, left: 16, right: 16),
            listInnerDecoration: BoxDecoration(
              color: Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(10),
            ),
            children: lists,
            itemDivider:
                Divider(thickness: 10, height: 5, color: Color(0xFFF5F5F5)),
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
            onPressed: () {},
            child: const Icon(
              Icons.add,
              color: Color(0xFF4e4e4e),
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
                    color: Colors.white,
                    child: ListTile(
                      trailing: Icon(Icons.delete),
                      title: Text(item.title),
                    ),
                  ),
                ))
            .toList(),
      );

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
