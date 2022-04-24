import 'package:cloud_firestore/cloud_firestore.dart';

class TutorModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  String? disc;
  double? rating;
  String flag;
  //double? longitude;
  //double? latitude;

  TutorModel({
    this.uid,
    this.email,
    this.firstName,
    this.secondName,
    this.disc,
    this.rating = 0.0,
    this.flag = "tutor",
    /* this.longitude,this.latitude */
  });

  // receiving data from server
  factory TutorModel.fromMap(map) {
    return TutorModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
      disc: map['disc'],
      rating: map['rating'],
      flag: map['flag'],
      /* longitude: map['longitude'],
        latitude: map['latitude'] */
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      'disc': disc,
      'rating': rating,
      'flag':flag,
      /* 'longitude': longitude,
      'latitude':latitude, */
    };
  }
}
