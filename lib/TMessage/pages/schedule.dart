import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:learning_thrive/TMessage/providers/schedule_provider.dart';
import 'package:learning_thrive/screens/ScheduleMeeting/event.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../messaging/constants/firestore_constants.dart';
import '../widgets/widgets.dart';
import 'pages.dart';

class schedule_meet extends StatefulWidget {
  const schedule_meet({Key? key, required this.arguments}) : super(key: key);
  final schedule_meetArguments arguments;

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<schedule_meet> {
  late Map<DateTime, List<Event>> selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  String groupChatId = "";
  var currentUser;
  late String peerId;
  List<QueryDocumentSnapshot> listMessage = [];
  //late FirebaseFirestore firebase;

  TextEditingController _eventController = TextEditingController();

  late ScheduleProvider scheduleProvider;
  @override
  void initState() {
    selectedEvents = {};
    super.initState();
    scheduleProvider = context.read<ScheduleProvider>();
    readLocal();
    /* List<String> productName= [];
    Stream<QuerySnapshot> productRef = firebase
    .collection(FirestoreConstants.pathMessageCollection)
        .doc(groupChatId)
        .collection(groupChatId)
        .orderBy(FirestoreConstants.timestamp, descending: true)
        .limit(5)
        .snapshots();
     productRef.forEach((field) {
     field.docs.asMap().forEach((value, data) {
    productName.add(field.docs[value]["name"]);
    selectev[selectedDay]!.add(field.docs[value]["content"]);
  });
}); */
  }

  Future<void> readLocal() async {
    currentUser = FirebaseAuth.instance.currentUser;
    peerId = widget.arguments.peerId;
    if ((currentUser!.uid).compareTo(peerId) > 0) {
      groupChatId = '${currentUser.uid}-$peerId';
    } else {
      groupChatId = '$peerId-${currentUser.uid}';
    }
    selectedDay = DateTime(2022,04,26);
    selectedEvents[selectedDay] = [Event(title: "koi bhi"),Event(title: "koi bhi ni")];
    selectedEvents[selectedDay]!.add(
                        Event(title: "koi bhi"),
                      );
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
          //buildListMessage(),
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
              subtitle: TextButton(
                child: Text('Start Meeting'),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  onSurface: Colors.white,
                  backgroundColor: Colors.lightBlue,
                  shadowColor: Colors.red,
                  elevation: 5,
                  padding: EdgeInsets.all(5.0),
                ),
                onPressed: () {
                  print('Pressed');
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Add Meeting"),
            content: TextFormField(
              controller: _eventController,
            ),
            actions: [
              TextButton(
                child: Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  if (_eventController.text.isEmpty) {
                  } else {
                    if (selectedEvents[selectedDay] != null) {
                      selectedEvents[selectedDay]!.add(
                        Event(title: _eventController.text),
                      );
                    } else {
                      selectedEvents[selectedDay] = [
                        Event(title: _eventController.text)
                      ];
                    }
                  }

                  scheduleProvider.sendSchedule(_eventController.text, 0,
                      groupChatId, currentUser.uid, peerId, selectedDay);

                  Navigator.pop(context);
                  _eventController.clear();
                  setState(() {});
                  return;
                },
              ),
            ],
          ),
        ),
        label: Text("Add Meeting"),
        icon: Icon(Icons.add),
      ),
    );
  }

  /* Widget buildListMessage() {
    return Flexible(
      child: groupChatId.isNotEmpty
          ? StreamBuilder<QuerySnapshot>(
              stream: scheduleProvider.getScheduleStream(groupChatId, 5),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  listMessage = snapshot.data!.docs;
                  if (listMessage.length > 0) {
                    return ListView.builder(
                      padding: EdgeInsets.all(10),
                      itemBuilder: (context, index) =>
                          buildItem(index, snapshot.data?.docs[index]),
                      itemCount: snapshot.data?.docs.length,
                      reverse: true,
                      controller: listScrollController,
                    );
                  } else {
                    return Center(child: Text("No message here yet..."));
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: ColorConstants.themeColor,
                    ),
                  );
                }
              },
            )
          : Center(
              child: CircularProgressIndicator(
                color: ColorConstants.themeColor,
              ),
            ),
    );
  } */
}

class schedule_meetArguments {
  final String peerId;
  final String peerAvatar;
  final String peerNickname;

  schedule_meetArguments(
      {required this.peerId,
      required this.peerAvatar,
      required this.peerNickname,
      String? current,
      String? currentid});
}
