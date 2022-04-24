import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:learning_thrive/model/tutor_model.dart';
import 'package:learning_thrive/model/user_model.dart';
import 'package:learning_thrive/screens/ScheduleMeeting/event.dart';
import 'package:flutter/material.dart';
import 'package:learning_thrive/screens/feedback/feedbackAndRating.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:table_calendar/table_calendar.dart';

class studentSchedule extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<studentSchedule> {
  late Map<DateTime, List<Event>> selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  TextEditingController _eventController = TextEditingController();

  var petCollection;
  /* CollectionReference<Map<String, dynamic>> user =
  FirebaseFirestore.instance.collection("Tutors");
  TutorModel loggedInUser = TutorModel(); */
  @override
  void initState() {
    selectedEvents = {};
    super.initState();
    /* FirebaseFirestore.instance
        .collection("Tutors")
        .doc("8wkYZxYrnNTm39A6GfAWcegMzgH2")
        .get()
        .then((value) {
      this.loggedInUser = TutorModel.fromMap(value.data());
      setState(() {});
    }); */
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Schedule Meeting"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: selectedDay,
            firstDay: DateTime(1990),
            lastDay: DateTime(2050),
            calendarFormat: format,
            onFormatChanged: (CalendarFormat _format) {
              setState(() {
                format = _format;
              });
            },
            startingDayOfWeek: StartingDayOfWeek.sunday,
            daysOfWeekVisible: true,

            //Day Changed
            onDaySelected: (DateTime selectDay, DateTime focusDay) {
              setState(() {
                selectedDay = selectDay;
                focusedDay = focusDay;
              });
              print(focusedDay);
            },
            selectedDayPredicate: (DateTime date) {
              return isSameDay(selectedDay, date);
            },

            eventLoader: _getEventsfromDay,

            //To style the Calendar
            calendarStyle: CalendarStyle(
              isTodayHighlighted: true,
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              selectedTextStyle: TextStyle(color: Colors.white),
              todayDecoration: BoxDecoration(
                color: Colors.purpleAccent,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              defaultDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              weekendDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: true,
              titleCentered: true,
              formatButtonShowsNext: false,
              formatButtonDecoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5.0),
              ),
              formatButtonTextStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          ..._getEventsfromDay(selectedDay).map(
            (Event event) => ListTile(
              title: Text(
                event.title,
              ),
            ),
          ),
          TextButton(
            child: Text('Join Meeting'),
            style: TextButton.styleFrom(
              primary: Colors.white,
              onSurface: Colors.white,
              backgroundColor: Colors.lightBlue,
              shadowColor: Colors.red,
              elevation: 5,
              padding: EdgeInsets.all(5.0),
            ),
            onPressed: () {
              show();
            },
          ),
        ],
      ),
    );
  }

  void show() {
    showDialog(
        context: context,
        barrierDismissible: true, // set to false if you want to force a rating
        builder: (context) {
          return RatingDialog(
            icon: const Icon(
              Icons.star,
              size: 100,
              color: Colors.blue,
            ), // set your own image/icon widget
            title: "Rate " + "",
            description: "Tap a star to give your rating.",
            submitButton: "SUBMIT",
            alternativeButton: "Contact us instead?", // optional
            positiveComment: "Satisfied 😍", // optional
            negativeComment: "Unsatisfied 😭", // optional
            accentColor: Colors.blue, // optional
            onSubmitPressed: (int rating) async {
              print("onSubmitPressed: rating = $rating");
               /* DocumentSnapshot variable = await FirebaseFirestore.instance
                  .collection("Tutors")
                  .doc('6d3rbxXTdmWBxRTc7O47GFgyHYd2')
                  .get();

              print(variable['rating']);
              int rat = variable['rating'] as int;
              print("////////////// rat $rat"); */


              print("/////////////////////////"); 
              var collection = FirebaseFirestore.instance.collection('Tutors');
              collection
                  .doc("6d3rbxXTdmWBxRTc7O47GFgyHYd2")
                  .update({"rating": "$rating"}).then((result) {
                print("new USer true");
              }).catchError((onError) {
                print("onError");
              });

              // TODO: open the app's page on Google Play / Apple App Store
            },
            onAlternativePressed: () {
              print("onAlternativePressed: do something");
              // TODO: maybe you want the user to contact you instead of rating a bad review

              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => contactus()));
            },
          );
        });
  }
}
