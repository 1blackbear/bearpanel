import 'package:bearpanel/core/app_colors.dart';
import 'package:bearpanel/core/app_navigator.dart';
import 'package:bearpanel/core/app_text_styles.dart';
import 'package:bearpanel/models/user.dart';
import 'package:bearpanel/screens/disciplines/lesson/lesson_data_struct.dart';
import 'package:bearpanel/screens/widgets/app_buttons.dart';
import 'package:bearpanel/services/database.dart';
import 'package:flutter/material.dart';

//ignore: must_be_immutable
class EditDisciplineModal extends StatefulWidget {
  UserData user;
  dynamic discipline;
  EditDisciplineModal({Key? key, required this.user, required this.discipline})
      : super(key: key);

  @override
  _EditDisciplineModalState createState() => _EditDisciplineModalState();
}

class _EditDisciplineModalState extends State<EditDisciplineModal> {
  bool _edit_title = false, _edit_period = false, _edit_finalized = false;

  @override
  Widget build(BuildContext context) {
    LessonsData lessons_data = LessonsData.onlyUser(user: widget.user);
    return Container(
      width: double.infinity,
      height: 480,
      color: AppColors.background,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Material(
          color: AppColors.background,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Editar Disciplina', style: AppTextStyles.titleForm),
              SizedBox(height: 30),

              //Nome da disciplina
              Text('Nome', style: AppTextStyles.descForm),
              TextFormField(
                initialValue: widget.discipline['Nome'],
                validator: (val) => val!.isEmpty ? '' : null,
                onChanged: (val) {
                  setState(() => widget.discipline['Nome'] = val);
                },
                readOnly: !_edit_title,
                keyboardType: TextInputType.name,
                enableInteractiveSelection: !_edit_title,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.black_pattern,
                      width: 1.0,
                    ),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _edit_title = !_edit_title;
                      });
                    },
                    child: Icon(
                      _edit_title ? Icons.edit_off : Icons.edit,
                      color: AppColors.black_pattern_dark,
                    ),
                  ),
                  contentPadding:
                      const EdgeInsets.only(top: 14.0, bottom: 8.0, left: 6),
                  hintText: 'Digite o nome da disciplina',
                  hintStyle: TextStyle(
                    color: AppColors.password,
                    fontSize: 14.0,
                  ),
                ),
              ),
              SizedBox(height: 30),

              Text('Período', style: AppTextStyles.descForm),
              Container(
                width: double.infinity,
                child: DropdownButton<int>(
                  isExpanded: true,
                  value: widget.discipline['Período'],
                  icon: const Icon(Icons.arrow_drop_down_outlined),
                  underline: Container(
                    height: 1,
                    color: AppColors.black_pattern,
                  ),
                  onChanged: (int? newValue) {
                    setState(() {
                      widget.discipline['Período'] = newValue!;
                      _edit_period = true;
                    });
                  },
                  items: lessons_data
                      .getList()
                      .map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 30),

              CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('Disciplina finalizada?',
                      style: AppTextStyles.descForm),
                  activeColor: AppColors.black_pattern,
                  value: widget.discipline['Finalizada?'],
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (value) {
                    setState(() {
                      widget.discipline['Finalizada?'] = value!;
                      _edit_finalized = true;
                    });
                  }),
              SizedBox(height: 50),

              //Atualizar
              CustomButton(
                  isEnabled: _edit_title || _edit_period || _edit_finalized,
                  title: 'Atualizar',
                  onPressed: () async {
                    setState(() {
                      AppNavigator.activate_detail = false;
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NavigatorBase(
                                  spin_animation: true,
                                )));
                    await DatabaseService(uid: widget.user.uid).updateUserData(
                        widget.user.name,
                        widget.user.disciplines,
                        widget.user.course_name,
                        widget.user.periods);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
