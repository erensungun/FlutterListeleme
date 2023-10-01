import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'list_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = "";
  String password = "";

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool hidePassword = true;

  Future<bool> login() async {
    var url = Uri.parse("https://dummyjson.com/users");
    var response = await http.get(url);

    var responseJson = jsonDecode(response.body) as Map;

    var users = responseJson["users"] as List;

    var user = users.firstWhere(
          (user) => user["username"] == username && user["password"] == password,
      orElse: () => null, // Kullanıcı bulunamazsa null döndür
    );

    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ListScreen()),
      );
      return true; // Giriş başarılı
    } else {
      return false; // Giriş başarısız
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Stack(children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                    margin: const EdgeInsets.symmetric(vertical: 85, horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context).hintColor.withOpacity(0.2),
                              offset: const Offset(0, 10),
                              blurRadius: 20)
                        ]),
                    child: Form(
                      key: globalFormKey,
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 25,
                          ),
                          const Text("Giriş Yap",
                              style: TextStyle(
                                  color: Color(0xff6750a4),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            onChanged: (value) {
                              username = value;
                            },
                            keyboardType: TextInputType.text,
                            validator: (input) => input!.length < 3
                                ? "Kullanıcı adı 3 harften fazla olmalı"
                                : null,
                            decoration: InputDecoration(
                                hintText: "Kullanıcı Adı",
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: const Color(0xff6750a4).withOpacity(0.2),
                                )),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xff6750a4))),
                                prefixIcon:
                                    const Icon(Icons.account_circle_outlined, color: Color(0xff6750a4))),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            onChanged: (value) {
                              password = value;
                            },
                            keyboardType: TextInputType.text,
                            validator: (input) => input!.length < 3
                                ? "Şifre 3 harften fazla olmalı"
                                : null,
                            obscureText: hidePassword,
                            decoration: InputDecoration(
                                hintText: "Şifre",
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: const Color(0xff6750a4).withOpacity(0.2),
                                )),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xff6750a4))),
                                prefixIcon:
                                    const Icon(Icons.lock_outline, color: Color(0xff6750a4)),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        hidePassword = !hidePassword;
                                      });
                                    },
                                    color: hidePassword
                                        ? Theme.of(context).primaryColor.withOpacity(0.4)
                                        : Theme.of(context).primaryColor,
                                    icon: Icon(hidePassword
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined))),
                          ),
                          const SizedBox(height: 30,),
                          ElevatedButton(
                            onPressed: () async {
                              if (globalFormKey.currentState!.validate()) {
                                bool loginSuccess = await login();
                                if (!loginSuccess) {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) => AlertDialog(
                                      title: const Text('HATA!'),
                                      content: const Text('Giriş bilgileriniz hatalı!'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context, 'OK'),
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor),
                            child: Text("Giriş Yap", style: TextStyle(color: Theme.of(context).colorScheme.background),),

                          )
                        ],
                      ),
                    ),
                  ),
                ])
              ],
            ),
          ),
        ));
  }
}
