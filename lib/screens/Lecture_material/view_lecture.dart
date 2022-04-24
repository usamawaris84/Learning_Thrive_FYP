import 'package:flutter/material.dart';


class ViewLecture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Lecture Materials'),
        ),
        body: Center(
          child: ListViewHome(),
        ),
      ),
    );
  }
}

class ListViewHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        Card(
            child: ListTile(
          title: Text("Pointers"),
          subtitle: Text("Computer Science."),
          leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/docx.jpg')),
        )),
        Card(
            child: ListTile(
          title: Text("Arrays"),
          subtitle: Text("Computer Science."),
          leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/docx.jpg')),
        )),
        Card(
            child: ListTile(
          title: Text("Linklist"),
          subtitle: Text("Computer Science."),
          leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/docx.jpg')),
        )),
        Card(
            child: ListTile(
          title: Text("Filehandling"),
          subtitle: Text("Computer Science."),
          leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/docx.jpg')),
        ))
      ],
    );
  }
}
