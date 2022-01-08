import 'package:bearpanel/core/app_text_styles.dart';
import 'package:bearpanel/screens/widgets/app_bar_login.dart';
import 'package:bearpanel/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email = "";
  String password = "", error = '';
  bool _showPassword = false;
  final AuthService _auth = AuthService();
  final auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF707070),
        appBar: AppBarLoginWidget(),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                color: Color(0xFFF5F5F5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                )),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Text('Realizar Cadastro', style: AppTextStyles.titleForm),

                  const SizedBox(
                    height: 30,
                  ),

                  Text('Email', style:AppTextStyles.descForm),
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
                    height: 20,
                  ),

                  Text('Senha', style:AppTextStyles.descForm),
                  TextFormField(
                    obscureText: !_showPassword,
                    validator: (val) => val!.isEmpty ? '' : null,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: (){
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                        child: Icon(
                          _showPassword ? Icons.visibility : Icons.visibility_off,
                          color: const Color(0xFF4e4e4e),
                        ),
                      ),
                      contentPadding: const EdgeInsets.only(top: 14.0, bottom: 8.0),
                      hintText: 'Digite sua senha',
                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.4),
                        fontSize: 14.0,
                      ),
                    ),
                  ),


                  Container(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        /*Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ForgotPassword()),
                        );*/
                      },
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.only(right: 0.0)
                      ),
                      child: Text(
                          'Esqueceu a senha?',
                          style: AppTextStyles.miniForm
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 23,
                  ),

                  SizedBox (
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });
                        if (_formkey.currentState!.validate()) {
                          dynamic result =
                          await _auth.signInWithEmailAndPassword(email, password);
                          switch (result) {
                            case 1:
                              loading = false;
                              setState(() => error = 'Email ou senha incorretos');
                              break;
                            case 2:
                              loading = false;
                              _auth.signOut();
                              _showDialog();
                              break;
                            default:
                              loading = true;
                              break;
                          }
                        }
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
                        'Login',
                        style: AppTextStyles.btnLogin,
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 5,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Não possui uma conta? ',
                        style: AppTextStyles.mediumForm,
                      ),
                      TextButton(
                        onPressed: () {
                          /*Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ForgotPassword()),
                        );*/
                        },
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.only(right: 0.0)
                        ),
                        child: Text(
                            'Cadastre-se!',
                            style: AppTextStyles.linkForm
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 1,
                        width: 85,
                        color: Color(0xFF525151),
                      ),
                      Text(
                          '     Ou faça log-in com     ',
                          style: AppTextStyles.miniForm
                      ),
                      Container(
                        height: 1,
                        width: 85,
                        color: Color(0xFF525151),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {print('click on edit');},
                          child: const Icon(Icons.facebook_rounded, color: Color(0xFF707070),size: 50,)
                      ),
                      const SizedBox(
                        width: 30,
                      ),

                      Container(
                        width: 43,
                        height: 43,
                        decoration: const BoxDecoration(
                          color: Color(0xFF707070),
                          shape: BoxShape.circle,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("G", style: AppTextStyles.googleBtn,)
                          ],),
                      ),
                    ],
                  ),
                ],
              ),
            )
        )
    );
  }
  void _showDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Verifique seu email'),
          content: Text(
              'Por favor, verifique o seu email para continuar.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {

              },
              child: Text(
                'Voltar',
                style: TextStyle(
                  color: Color(0xFF6848AE),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

