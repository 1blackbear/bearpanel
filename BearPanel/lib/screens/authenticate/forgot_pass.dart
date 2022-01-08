import 'package:bearpanel/core/app_text_styles.dart';
import 'package:bearpanel/screens/authenticate/auth_screen.dart';
import 'package:bearpanel/screens/widgets/app_buttons.dart';
import 'package:bearpanel/screens/widgets/app_dialog.dart';
import 'package:bearpanel/screens/widgets/app_form.dart';
import 'package:bearpanel/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String email = "", error = '';
  final AuthService _auth = AuthService();
  final auth = FirebaseAuth.instance;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return AuthScreen(widgets: [
      AuthCard(
        widgets: [
          const SizedBox(
            height: 25,
          ),

          Text('Esqueci minha senha', style: AppTextStyles.titleForm),
          const SizedBox(
            height: 30,
          ),

          //Email Form
          Text('Email', style: AppTextStyles.descForm),
          CustomForm(
            enabled: true,
            hintText: 'Digite o seu email',
            onChanged: (val) {
              setState(() => email = val);
            },
            keyboardType: TextInputType.emailAddress,
            initialValue: '',
          ),
          const SizedBox(
            height: 30,
          ),

          CustomButton(
            title: 'Enviar',
            onPressed: () async {
              await _auth.sendPasswordResetEmail(email);
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return ShowDialogUntil(
                      title_msg: 'Verifique seu email',
                      desc_msg:
                          'Um email para redefinir sua senha foi enviado para $email.',
                    );
                  });
            },
          ),
          const SizedBox(
            height: 30,
          ),

          GestureDetector(
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Voltar ao login', style: AppTextStyles.linkForm),
              ],
            ),
          ),
          const SizedBox(
            height: 150,
          ),
        ],
      )
    ]);
  }
}
