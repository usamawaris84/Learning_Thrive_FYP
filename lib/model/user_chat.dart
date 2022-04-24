import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learning_thrive/messaging/constants/constants.dart';

class UserChat {
  String uid;
  String photoUrl;
  String firstName;
  String lastName;
  String disc;
  double rating;
  double longitude;
  double latitude;

  UserChat(
      {required this.uid,
      required this.photoUrl,
      required this.firstName,
      required this.lastName,
      required this.disc,
      required this.rating,
      required this.latitude,
      required this.longitude});

  Map<String, dynamic> toJson() {
    return {
      FirestoreConstants.firstName: firstName,
      FirestoreConstants.lastName: lastName,
      FirestoreConstants.aboutMe: disc,
      FirestoreConstants.photoUrl: photoUrl,
      FirestoreConstants.rating: rating,
      FirestoreConstants.longitutde: longitude,
      FirestoreConstants.latitude: latitude,
    };
  }

  factory UserChat.fromDocument(DocumentSnapshot doc) {
    String disc = "";
    String photoUrl = "";
    String firstName = "";
    String lastName = "";
    double rating = 0.0;
    double longitude = 0.0;
    double latitude = 0.0;
    try {
      disc = doc.get(FirestoreConstants.disc);
    } catch (e) {}
    try {
      photoUrl = doc.get(FirestoreConstants.photoUrl);
    } catch (e) {}
    try {
      firstName = doc.get(FirestoreConstants.firstName);
    } catch (e) {}
    try {
      rating = doc.get(FirestoreConstants.rating);
    } catch (e) {}
    try {
      longitude = doc.get(FirestoreConstants.longitutde);
    } catch (e) {}
    try {
      latitude = doc.get(FirestoreConstants.latitude);
    } catch (e) {}
    try {
      lastName = doc.get(FirestoreConstants.lastName);
    } catch (e) {}
    return UserChat(
      uid: doc.id,
      photoUrl: photoUrl,
      firstName: firstName,
      lastName: lastName,
      disc: disc,
      rating: rating,
      longitude: longitude,
      latitude: latitude,
    );
  }
}
