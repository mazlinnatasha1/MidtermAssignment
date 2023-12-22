import 'package:bookbytes/views/screens/loginpage.dart';
import 'package:bookbytes/views/screens/registrationpage.dart';
import 'package:flutter/material.dart';
import 'package:bookbytes/views/screens/mydrawer.dart';
import 'package:bookbytes/models/user.dart';

class ProfilePage extends StatefulWidget {
  final User userdata;
  const ProfilePage({super.key, required this.userdata});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late double screenWidth, screenHeight;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "My Account",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 40,
            ),
          ],
        ),           
        backgroundColor: Colors.deepOrange,
        elevation: 0.0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey,
            height: 1.0,
          ),
        )),            
      drawer: MyDrawer(
        page: 'account',
        userdata: widget.userdata,
      ),
      body: Center(
        child: Column(children: [
            Container(
              height: screenHeight * 0.25,
              padding: const EdgeInsets.all(4),
              child: Card(
                  child: Row(children: [
                Container(
                  // ignore: prefer_const_constructors
                  padding: EdgeInsets.all(8),
                  width: screenWidth * 0.4,
                  height: screenHeight * 0.4,
                  child: Image.asset(
                    'assets/profile.png',
                    fit: BoxFit.contain,
                  ),
                ),
                Expanded(
                    flex: 7,
                    child: Column(
                      children: [
                        Text(
                          widget.userdata.username.toString(),
                          style: const TextStyle(fontSize: 24),
                        ),
                        const Divider(
                          color: Colors.deepOrange,
                        )
                      ],
                    ))
              ])),
            ),
            Expanded(
                child: ListView(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    shrinkWrap: true,
                    children: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (content) => const RegistrationPage()));
                    },
                    child: const Text("NEW REGISTRATION"),
                  ),
                  const Divider(
                    height: 2,
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (content) => const LoginPage()));
                    },
                    child: const Text("LOGIN"),
                  ),
                  const Divider(
                    height: 2,
                  ),
                  MaterialButton(
                    onPressed: () {
                      {}
                    },
                    child: const Text("LOGOUT"),
                  ),
                ])),
          ]),
        ));
  }
}