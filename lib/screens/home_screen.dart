import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learning_thrive/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learning_thrive/screens/Assesments/view_assessment.dart';
import 'package:learning_thrive/screens/LocateTutor.dart';
import 'package:learning_thrive/screens/ScheduleMeeting/calendar.dart';
import 'package:learning_thrive/screens/ScheduleMeeting/studentSchedule.dart';
import 'package:learning_thrive/screens/feedback/feedbackAndRating.dart';
import 'package:learning_thrive/screens/welcome_screen/components/rounded_button.dart';
import 'package:learning_thrive/screens/welcome_screen/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:learning_thrive/screens/GoogleAPI/Locationn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import '../messaging/pages/home_page.dart';
import 'Assesments/upload_assesments.dart';
import 'Lecture_material/upload_files.dart';
import 'Lecture_material/view_lecture.dart';
import 'Lecture_material/view_lecture_material.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
//for stay login
  /* late SharedPreferences logindata;
  late var username; */
  //

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //initial();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
   /*  if(loggedInUser.firstName!.isEmpty){
      Fluttertoast.showToast(msg: "Please Login with Tutor");
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
    }
    else{
      Fluttertoast.showToast(msg: "Login Successful");
      
    } */
  }

//for stay login
  /* void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username');
    });
  } */

//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Home"),
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
              trailing: Icon(Icons.contact_support),
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
                            text: "Wednesday",
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
                            border: Border.all(width: 1, color: Colors.blue),
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
                        height: 50,
                      ),
                      RoundedButton(
                        text: "Locate Tutor",
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
                      const SizedBox(
                        height: 30,
                      ),
                      RoundedButton(
                        text: "Lecture Materials",
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ViewPage();
                              },
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      RoundedButton(
                        text: "Assesments",
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Viewassment();
                              },
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      RoundedButton(
                        text: "Schedule",
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
    //for stay login
    //logindata.setBool('login', true);
    //
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => WelcomeScreen()));
  }
}
