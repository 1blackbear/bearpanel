import 'package:bearpanel/core/app_colors.dart';
import 'package:bearpanel/core/app_text_styles.dart';
import 'package:bearpanel/models/lesson.dart';
import 'package:bearpanel/models/user.dart';
import 'package:bearpanel/screens/shared/navigator_base.dart';
import 'package:bearpanel/screens/widgets/app_buttons.dart';
import 'package:bearpanel/screens/widgets/app_cards.dart';
import 'package:bearpanel/services/database.dart';
import 'package:flutter/material.dart';

class DisciplinDetail extends StatefulWidget {
  UserData user;
  int index;
  DisciplinDetail({Key? key, required this.user, required this.index}) : super(key: key);

  @override
  _DisciplinDetailState createState() => _DisciplinDetailState();
}

class _DisciplinDetailState extends State<DisciplinDetail> {

  List<int> getList() {
    List<int>? list_period = [1];
    for (int i = 2; i <= widget.user.periods; i++) list_period.add(i);
    return list_period;
  }

  List<Lesson> getAtividades() {
    List<Lesson> list = [];
    Lesson les;
    widget.user.disciplines[widget.index]['Atividades'].forEach((e) {
      les = new Lesson(title: e['Titulo'], current: e['Nota Atual'], total: e['Nota Total']);
      list.add(les);
    });
    return list;
  }


  @override
  Widget build(BuildContext context) {
    //return Center(child: Container(child: Text(widget.user.disciplines[widget.index]['Nome']),));
    return Padding(
      padding: const EdgeInsets.only(top: 70.0, left: 25, right: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.user.disciplines[widget.index]['Nome'], style: AppTextStyles.titleDetailPage),
          SizedBox(height: 35,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MiniCard(title: "${widget.user.disciplines[widget.index]['Nota Atual']}/100"),
              MiniCard(title: "${widget.user.disciplines[widget.index]['Nota Atual']}%"),
              MiniCard(title: widget.user.disciplines[widget.index]['Status']),
            ],
          ),
          SizedBox(height: 30,),

          Text('Período', style: AppTextStyles.descForm),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            child: DropdownButton<int>(
              isExpanded: true,
              value: widget.user.disciplines[widget.index]['Período'],
              icon: const Icon(Icons.arrow_drop_down_outlined),
              underline: Container(
                height: 1,
                color: AppColors.black_pattern,
              ),
              onChanged: (int? newValue) {
                setState(() {
                  widget.user.disciplines[widget.index]['Período'] = newValue!;
                });
              },
              items: getList().map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 30,),

          Text('Atividades', style: AppTextStyles.descForm),
          Expanded(
            child: ListView(
              children: getAtividades().map(
                  (item) => Container(
                    color: AppColors.white,
                    child: ListTile(
                      title: Text(item.title),
                      trailing: Icon(Icons.delete),
                    ),
                  )
              ).toList(),
            ),
          ),

          CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('Disciplina finalizada?',
                  style: AppTextStyles.descForm),
              activeColor: AppColors.black_pattern,
              value: widget.user.disciplines[widget.index]['Finalizada?'],
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (value) {
                setState(() {
                  widget.user.disciplines[widget.index]['Finalizada?'] = value!;
                });
              }),
          SizedBox(
            height: 20,
          ),
          CustomButton(title: 'Salvar',
              onPressed: () async {
                //widget.user.disciplines.add(disciplin_data);
                await DatabaseService(uid: widget.user.uid).updateUserData(
                    widget.user.name,
                    widget.user.disciplines,
                    widget.user.course_name,
                    widget.user.periods
                );
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NavigatorBase(spin_animation: true,)));
              }
          ),
          SizedBox(
            height: 30,
          ),

        ],
      ),
    );
  }
}
