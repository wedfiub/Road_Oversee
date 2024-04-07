import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:road_oversee/pages/login_page.dart';

import '../services/firebase_auth.dart';
import 'welcome_screen.dart';
class WelcomeScreen extends StatefulWidget {
  // создание контроллеров для использования их в информаций пользователя
   TextEditingController controllerEmail =  TextEditingController();
   TextEditingController controllerPassword =  TextEditingController();
   TextEditingController controllerName =  TextEditingController();
   TextEditingController controllerSurname =  TextEditingController();
   TextEditingController controllerConfirm =  TextEditingController();
   TextEditingController controllerCity =  TextEditingController();
   // создание конструктора
   WelcomeScreen({Key? key, controllerEmail, controllerPassword, controllerName, controllerSurname, controllerConfirm, controllerCity}) : super(key: key);
  //создание State для динамичности изминяемости данных в классе
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  // переменные
  final FocusNode _focusNode = FocusNode();
  bool _isFilled = false;
  String errorMessage = '';
  bool isLogin = true;
  bool _passwordVisible = false;
  final mainColor = Colors.green.shade300;
  String email = '';
  String login = '';
  String city = '';
  Auth auth = Auth();
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    _focusNode.addListener(() {
      setState(() {
        _isFilled = widget.controllerEmail.text.isNotEmpty &&
            widget.controllerPassword.text.isNotEmpty;
      });
    });
  }
  Future<void> rfwerf() async {}
  // регистрация пользователя
  Future<void> createUserWithEmailAndPassword() async {
    try {
      if (_passwordConfirmed()) {
        await Auth().createUserWithEmailAndPassword(
            email: widget.controllerEmail.text,
            password: widget.controllerPassword.text
        ).then((value) {
          users.add({
            'Email': widget.controllerEmail.text,
            'Password': widget.controllerPassword.text,
            'uid': auth.currentUser!.uid,
            'Name': widget.controllerName.text,
            'Surname': widget.controllerSurname.text,
            'City': widget.controllerCity.text
          });
          Navigator.push(context, MaterialPageRoute(builder: (context) => const HelloScreen()));
        }
        ).catchError((error) {
          setState(() {
            errorMessage = error.toString();
          });
        });
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message!;
      });
    }
  }
    // функция dispose активируется при выключений приложения, выполняет отключение потоков
    @override
    void dispose() {
      super.dispose();
      widget.controllerPassword.dispose();
      widget.controllerEmail.dispose();
      widget.controllerSurname.dispose();
      widget.controllerName.dispose();
      _focusNode.dispose();
    }
    Widget _errorMessage() {
      return Text(errorMessage == '' ? '' : '$errorMessage');
    }
    bool _passwordConfirmed() {
      if (widget.controllerPassword.text.trim() ==
          widget.controllerConfirm.text.trim()) {
        return true;
      } else {
        return false;
      }
    }
    Widget _submitButton() {
      return InkWell(
        onTap: createUserWithEmailAndPassword,
        child: Container(
          width: 250,
          height: 61,
          decoration: BoxDecoration(
            color: Color(0xFF6874E8),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text('РЕГИСТРАЦИЯ', style: TextStyle(fontSize: 18),),
          ),
        ),
      );
    }
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(60, 70, 60, 46),
                child: Column(
                  children: [
                    Text(
                      'РЕГИСТРАЦИЯ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24
                      ),
                    ),
                    SizedBox(height: 46,),
                    Column(
                      children: [
                        TextFormField(
                          controller: widget.controllerName,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.green.shade300
                                  )
                              ),
                              labelText: 'Введите имя',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: _isFilled ? Colors.white : Colors.green
                                        .shade300
                                ),
                              )
                          ),
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          controller: widget.controllerSurname,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.green.shade300
                                  )
                              ),
                              labelText: 'Введите фамилию',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: _isFilled ? Colors.white : Colors.green
                                        .shade300
                                ),
                              )
                          ),
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          controller: widget.controllerCity,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.green.shade300
                                  )
                              ),
                              labelText: 'Введите ваш город',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: _isFilled ? Colors.white : Colors.green
                                        .shade300
                                ),
                              )
                          ),
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          controller: widget.controllerEmail,
                          validator: (email) =>
                          email != null && !EmailValidator.validate(email) ?
                          'Введите правильный Email' : null,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.green.shade300
                                  )
                              ),
                              labelText: 'Введите почту',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: _isFilled ? Colors.white : Colors.green
                                        .shade300
                                ),
                              )
                          ),
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          controller: widget.controllerPassword,
                          validator: (value) =>
                          value != null && value.length < 6
                              ? 'Минимум 6 символов'
                              : null,
                          obscureText: !_passwordVisible,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                color: Colors.grey.shade300,
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme
                                      .of(context)
                                      .primaryColorDark,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),
                              hintText: 'Введите пароль',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.green.shade300
                                  )
                              ),
                              labelText: 'Пароль',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: _isFilled ? Colors.white : Colors.green
                                        .shade300
                                ),
                              )
                          ),
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          controller: widget.controllerConfirm,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.green.shade300
                                  )
                              ),
                              labelText: 'Подтвердите пароль',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: _isFilled ? Colors.white : Colors.green
                                        .shade300
                                ),
                              )
                          ),
                        ),
                        SizedBox(height: 51,),
                        _submitButton(),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Уже есть аккаунт?'),
                            TextButton(onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                            }, child: Text('Войти'))
                          ],
                        ),
                        _errorMessage()
                      ],
                    )

                  ],
                ),
              ),
            )
        ),
      );
    }
}