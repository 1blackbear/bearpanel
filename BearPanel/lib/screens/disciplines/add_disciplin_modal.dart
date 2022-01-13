import 'package:bearpanel/core/app_colors.dart';
import 'package:bearpanel/core/app_text_styles.dart';
import 'package:bearpanel/models/user.dart';
import 'package:bearpanel/screens/shared/navigator_base.dart';
import 'package:bearpanel/screens/widgets/app_buttons.dart';
import 'package:bearpanel/screens/widgets/app_form.dart';
import 'package:bearpanel/services/database.dart';
import 'package:flutter/material.dart';

class AddDisciplinModal extends StatefulWidget {
  UserData user;
  AddDisciplinModal({Key? key, required this.user}) : super(key: key);

  @override
  _AddDisciplinModalState createState() => _AddDisciplinModalState();
}

class _AddDisciplinModalState extends State<AddDisciplinModal> {
  String name = '';
  bool finalized = false;
  int current_period = 1;
  int limit_period = 8;
  late List<String> disciplines;

  List<int> getList() {
    List<int>? list_period = [1];
    for (int i = 2; i <= limit_period; i++) list_period.add(i);
    return list_period;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height - 190,
      color: AppColors.background,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Material(
          color: AppColors.background,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Adicionar Disciplina',
                style: AppTextStyles.titleForm,
              ),
              SizedBox(
                height: 30,
              ),
              Text('Nome', style: AppTextStyles.descForm),
              const SizedBox(
                height: 10,
              ),
              CustomForm(
                enabled: true,
                hintText: 'Digite o nome da disciplina',
                onChanged: (val) {
                  setState(() => name = val);
                },
                keyboardType: TextInputType.name,
                initialValue: '',
              ),
              SizedBox(
                height: 30,
              ),
              Text('Período', style: AppTextStyles.descForm),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                child: DropdownButton<int>(
                  isExpanded: true,
                  value: current_period,
                  icon: const Icon(Icons.arrow_drop_down_outlined),
                  underline: Container(
                    height: 1,
                    color: AppColors.black_pattern,
                  ),
                  onChanged: (int? newValue) {
                    setState(() {
                      current_period = newValue!;
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
              SizedBox(
                height: 30,
              ),
              CheckboxListTile(
                  title: Text('Disciplina finalizada?',
                      style: AppTextStyles.descForm),
                  activeColor: AppColors.black_pattern,
                  value: finalized,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (value) {
                    setState(() {
                      finalized = value!;
                    });
                  }),
              SizedBox(
                height: 170,
              ),
              CustomButton(title: 'Adicionar',
                  onPressed: () async {
                    widget.user.disciplines.add(name);
                    await DatabaseService(uid: widget.user.uid).updateUserData(
                      widget.user.name,
                        widget.user.disciplines
                    );
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NavigatorBase(pressed: true,)));
                  }
                  )
            ],
          ),
        ),
      ),
    );
  }
}
