import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learning_thrive/assessment/pages/pages.dart';
import 'package:learning_thrive/lecture_Material/pages/pages.dart';

import 'package:learning_thrive/model/tutor_model.dart';
import 'package:learning_thrive/screens/Lecture_material/upload_files.dart';
import 'package:learning_thrive/screens/LocateTutor.dart';
import 'package:learning_thrive/screens/ScheduleMeeting/calendar.dart';
import 'package:learning_thrive/screens/ScheduleMeeting/studentSchedule.dart';
import 'package:learning_thrive/screens/feedback/feedbackAndRating.dart';
import 'package:learning_thrive/screens/tutor_login/messaging/tutorMessage.dart';
import 'package:learning_thrive/screens/welcome_screen/components/rounded_button.dart';

import 'package:learning_thrive/screens/Assesments/upload_assesments.dart';
import 'package:learning_thrive/screens/welcome_screen/welcome_screen.dart';
import '../../TMessage/pages/home_page.dart';
import 'tutor_login_screen.dart';

class THomeScreen extends StatefulWidget {
  const THomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<THomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  TutorModel loggedInUser = TutorModel();
  String check = "";

  @override
  initState() {
    super.initState();
    getvalue();
    /* if (loggedInUser.flag == "tutor") {
      Fluttertoast.showToast(msg: "Login Successful");
    } else {
      
      Fluttertoast.showToast(msg: "Please Login with Student");
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => TLoginScreen()));
    }
 */
    
  }

  Future<void> getvalue() async {
    await FirebaseFirestore.instance
        .collection("Tutors")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = TutorModel.fromMap(value.data());
      setState(() {});
    });
    check = loggedInUser.flag;
    /* print("${loggedInUser.firstName}");
    print("//////////////////////"); */
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tutor Home"),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text('Learning Thrive',
                  style: TextStyle(color: Colors.indigo, fontSize: 37.0)),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  Color(0xFFF0F0F0),
                  Color(0xFFD4E7FE),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
            ),
            ListTile(
              title: Text("Profile"),
              trailing: Icon(Icons.person),
            ),
            ListTile(
              title: Text("Help"),
              hoverColor: Colors.white,
              trailing: Icon(Icons.help),

              //textColor: Colors.indigo,
              tileColor: Colors.black12,
            ),
            ListTile(
              title: Text("Contact us"),
              trailing: Icon(Icons.contact_support),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return contactus();
                    },
                  ),
                );
              },
              //textColor: Colors.indigo,
            ),
            ListTile(
              title: Text("Feedback"),
              trailing: Icon(Icons.feedback),
              //textColor: Colors.indigo,
              tileColor: Colors.black12,
            ),
            ListTile(
              title: Text("Logout"),
              trailing: Icon(Icons.logout),
              //textColor: Colors.indigo,
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text('Are you sure you want to logout?'),
                        actions: [
                          TextButton(
                            child: Text('Yes'),
                            onPressed: () async {
                              logout(context);
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('No'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Color(0xFFF0F0F0),
                    Color(0xFFD4E7FE),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      child: RichText(
                        text: TextSpan(
                            text: "Thursday",
                            style: TextStyle(
                                color: Color(0XFF263064),
                                fontSize: 12,
                                fontWeight: FontWeight.w800),
                            children: [
                              TextSpan(
                                text: " 21 Apr",
                                style: TextStyle(
                                    color: Color(0XFF263064),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              )
                            ]),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(width: 1, color: Colors.white),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blueGrey.withOpacity(0.2),
                                spreadRadius: 10,
                              )
                            ],
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(""),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Hi ${loggedInUser.firstName} ${loggedInUser.secondName}",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                                color: Color(0XFF343E87),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                top: 185,
                child: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: MediaQuery.of(context).size.height - 250,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      RoundedButton(
                        text: "Message",
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return HomePage();
                              },
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      RoundedButton(
                        text: "Lecture Materials",
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return showStudentforLecture();
                              },
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      RoundedButton(
                        text: "Assesment",
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return showStudentforassessment();
                              },
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      RoundedButton(
                        text: "Meetings",
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return schedule_meeting();
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => WelcomeScreen()));
  }
}
