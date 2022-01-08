import 'package:bearpanel/core/app_text_styles.dart';
import 'package:bearpanel/screens/authenticate/sign_up.dart';
import 'package:bearpanel/screens/authenticate/sing_in.dart';
import 'package:bearpanel/screens/widgets/app_bar_login.dart';
import 'package:bearpanel/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String email = "";
  String error = '';

  final AuthService _auth = AuthService();
  final auth = FirebaseAuth.instance;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Color(0xFF707070),
        body: SingleChildScrollView(
          child: Column(children: [
            AppBarLoginWidget(),
            Container(
                height: MediaQuery.of(context).size.height / 1.4516,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF4e4e4e),
                        spreadRadius: 0,
                        blurRadius: 55,
                        offset: Offset(0, -16), // changes position of shadow
                      ),
                    ],
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0),
                    )),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        Text('Esqueci minha senha',
                            style: AppTextStyles.titleForm),
                        const SizedBox(
                          height: 30,
                        ),
                        Text('Email', style: AppTextStyles.descForm),
                        TextFormField(
                          //form field name
                          cursorColor: Color(0xFF707070),
                          decoration: InputDecoration(
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF525151),
                                width: 2.0,
                              ),
                            ),
                            contentPadding: EdgeInsets.only(top: 8, bottom: 8),
                            hintText: 'Digite o seu email',
                            hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.4),
                              fontSize: 14.0,
                            ),
                          ),
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              await _auth.sendPasswordResetEmail(email);
                              _showDialog();
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 5,
                              primary: const Color(0xFF707070),
                              padding: const EdgeInsets.all(15.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                            child: Text(
                              'Enviar',
                              style: AppTextStyles.btnLogin,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignIn()),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Voltar ao login',
                                  style: AppTextStyles.linkForm),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 150,
                        ),
                      ],
                    ),
                  ),
                )),
            ]
          ),
        ),
      ),
    );
  }

  void _showDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Verifique seu email'),
          content:
              Text('Um email para redefinir sua senha foi enviado para $email'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: Text(
                'Voltar',
                style: TextStyle(
                  color: Color(0xFF707070),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
