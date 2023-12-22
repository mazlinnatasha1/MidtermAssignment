import 'dart:async';
import 'dart:convert';
import 'package:bookbytes/views/screens/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:bookbytes/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bookbytes/views/screens/myconfig.dart';


class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});
  

  @override
  State <SplashScreen>createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>{
  @override
  void initState(){
    super.initState();
    checkandlogin();
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/splashscreen.png'),
              fit: BoxFit.cover
              )
          ),
        ),
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 100, 0, 20),
         child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "BookBytes",
              style: TextStyle(
                fontSize:40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            CircularProgressIndicator(),
            Text(
              "Version 0.1",
              style: TextStyle(
                fontSize: 15,
                color: Colors.white
              ),
            ),
          ],
         ),
         )
      ],
    ),
  );
 }
checkandlogin() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String email = (prefs.getString('email')) ?? '';
  String password = (prefs.getString('pass')) ?? '';
  bool rem = (prefs.getBool('rem')) ?? false;  

    if (rem) {
      http
          .post(
            Uri.parse("${MyServerConfig.server}/bookbytes_v1/php/login_user.php"),
            body: {"email": email, "password": password},
          )
          .then((response) {
        if (response.statusCode == 200) {
          Map<String, dynamic> data = json.decode(response.body);
          User user = User.fromJson(data['data']);
          Timer(
            const Duration(seconds: 3),
            () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (content) => MainPage(
                  userdata: user,
                ),
              ),
            ),
          );     
  } else {
          User user = User(
            userid: "0",
            useremail: "unregistered@email.com",
            username: "Unregistered",
            userdatereg: "",
            userpassword: "",
          );
          Timer(
            const Duration(seconds: 3),
            () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (content) => MainPage(
                  userdata: user,
                ),
              ),
            ),
          );
        }
      });         
  } else {
    User user = User(
        userid: "0",
        useremail: "unregistered@email.com",
        username: "Unregistered",
        userdatereg: "",
        userpassword: "");
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (content) => MainPage(
                      userdata: user,
                    ))));
    }    
  }
 }