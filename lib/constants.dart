import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:toletbd/model/contact.dart';
import 'package:toletbd/model/rent.dart';
import 'package:toletbd/model/user.dart';

var auth = FirebaseAuth.instance;
var db = FirebaseFirestore.instance;
var storage = FirebaseStorage.instance.ref();

String appName = "Tolet BD";

bool isLoggedIn = false;
bool isAdmin = false;

var scafKey = GlobalKey<ScaffoldMessengerState>();

late AppUser currentUser;
late ContactList contactList;
late RentList rentList;
List<String> imgPath = [];
