/* import 'package:learning_thrive/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:learning_thrive/screens/GoogleAPI/Locationn.dart';
import 'package:learning_thrive/screens/tutor_login/messaging/message_screen.dart';
import 'feedback/feedbackAndRating.dart';
import 'package:rating_dialog/rating_dialog.dart';

class LocateTutor extends StatefulWidget {
  const LocateTutor({Key? key}) : super(key: key);

  @override
  _LocateTutorState createState() => _LocateTutorState();
}

class _LocateTutorState extends State<LocateTutor> {
  List<User> _users = [
    User(
        'Muhammad Moaz',
        'Database expert',
        'https://images.unsplash.com/photo-1544348817-5f2cf14b88c8?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTYyNjQ2NTExMg&ixlib=rb-1.2.1&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=1080',
        false),
    User(
        'Usama Waris',
        'Data Analyst',
        'https://images.unsplash.com/photo-1541710430735-5fca14c95b00?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ',
        false),
    User(
        'Ali Arsam',
        'Marketing expert',
        'https://images.unsplash.com/photo-1507081323647-4d250478b919?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&s=b717a6d0469694bbe6400e6bfe45a1da',
        false),
    User(
        'Fazal Abbase',
        'Logo Designer',
        'https://images.unsplash.com/photo-1502980426475-b83966705988?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&s=ddcb7ec744fc63472f2d9e19362aa387',
        false),
    User(
        'Zeshan abbase',
        'Web Developer',
        'https://images.unsplash.com/photo-1541710430735-5fca14c95b00?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ',
        false),
    User(
        'Ali Hassan',
        'Graphic Designer',
        'https://images.unsplash.com/photo-1541647376583-8934aaf3448a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MXwxfDB8MXxhbGx8fHx8fHx8fA&ixlib=rb-1.2.1&q=80&w=1080&utm_source=unsplash_source&utm_medium=referral&utm_campaign=api-credit',
        false),
    User(
        'Mobeen Rauf',
        'Influencer',
        'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MXwxfDB8MXxhbGx8fHx8fHx8fA&ixlib=rb-1.2.1&q=80&w=1080&utm_source=unsplash_source&utm_medium=referral&utm_campaign=api-credit',
        false),
    User(
        'Ismail Khan',
        'marketing expert',
        'https://images.unsplash.com/photo-1542973748-658653fb3d12?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ',
        false),
    User(
        'Talha anjum',
        'Flutter developer',
        'https://images.unsplash.com/photo-1569443693539-175ea9f007e8?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ',
        false),
    User(
        'Mughees azhar',
        'Video animator',
        'https://images.unsplash.com/photo-1541710430735-5fca14c95b00?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ',
        false)
  ];

  List<User> _foundedUsers = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      _foundedUsers = _users;
    });
  }

  onSearch(String search) {
    setState(() {
      _foundedUsers = _users
          .where((user) => user.username.toLowerCase().contains(search))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.lightBlue,
        title: Container(
          height: 38,
          child: TextField(
            onChanged: (value) => onSearch(value),
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.all(0),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none),
                hintStyle: TextStyle(fontSize: 14, color: Colors.black),
                hintText: "Search Tutors"),
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: _foundedUsers.length > 0
            ? ListView.builder(
                itemCount: _foundedUsers.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    child: userComponent(user: _foundedUsers[index]),
                    
                  );
                })
            : Center(
                child: Text(
                "No users found",
                style: TextStyle(color: Colors.black),
              )),
      ),
    );
  }

  userComponent({required User user}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            Container(
                width: 60,
                height: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(user.image),
                )),
            const SizedBox(width: 10,),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              /* Text(user.name,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500)), */
              const SizedBox(
                height: 5,
              ),
              TextButton(
                  child: Text(user.name,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500)),
                  onPressed: () {
                    //show(user.name);
                    Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => MapScreen()));
                  }),
              SizedBox(
                height: 4,
              ),
              Text(user.username, style: TextStyle(color: Colors.grey[500])),
            ])
          ]),
          GestureDetector(
            onTap: () {
              setState(() {
                
              });
            },
            child: AnimatedContainer(
                height: 35,
                width: 110,
                duration: Duration(milliseconds: 3),
                decoration: BoxDecoration(
                    color: Colors.transparent,
                        
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color:Colors.black
                          
                    )),
                child: Center(
                    child: TextButton(
                  child: Text('Contact',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500)),
                  onPressed: () {
                    Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => MessagesScreen()));
                  }),)),
          )
        ],
      ),
    );
  }

  /* void show(String name) {
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
            title:"Rate "+ name,
            description: "Tap a star to give your rating.",
            submitButton: "SUBMIT",
            alternativeButton: "Contact us instead?", // optional
            positiveComment: "We are so happy to hear 😍", // optional
            negativeComment: "We're sad to hear 😭", // optional
            accentColor: Colors.blue, // optional
            onSubmitPressed: (int rating) {
              print("onSubmitPressed: rating = $rating");
              // TODO: open the app's page on Google Play / Apple App Store
            },
            onAlternativePressed: () {
              print("onAlternativePressed: do something");
              // TODO: maybe you want the user to contact you instead of rating a bad review
              
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => contactus()));
    
            },
          );
        });
  } */
}
 */