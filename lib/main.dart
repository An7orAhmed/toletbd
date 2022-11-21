import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:toletbd/screen/login.dart';
import 'package:toletbd/screen/signup.dart';
import 'constants.dart';
import 'firebase_options.dart';
import 'model/contact.dart';
import 'model/rent.dart';
import 'model/user.dart';
import 'screen/owner/add_new.dart';
import 'screen/owner/admin_home.dart';
import 'screen/renter/renter_home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    if (auth.currentUser != null) isLoggedIn = true;
  }

  Future<void> getRentList() async {
    var docs = await db.collection("Data").doc("Rents").get();
    if (docs.data() != null) {
      rentList = RentList.fromMap(docs.data()!);
    } else {
      rentList = RentList(rents: []);
    }
  }

  Future<void> getContactList() async {
    var docs = await db.collection("Data").doc("Contacts").get();
    if (docs.data() != null) {
      contactList = ContactList.fromMap(docs.data()!);
    } else {
      contactList = ContactList(contacts: []);
    }
  }

  loadAllImages() {
    imgPath.clear();
    storage.listAll().then((value) {
      var items = value.items;
      for (var item in items) {
        item.getDownloadURL().then((value) => imgPath.add(value));
      }
    });
  }

  Future<void> checkAdmin() async {
    if (auth.currentUser != null) {
      var doc = await db.collection("User").doc(auth.currentUser?.email).get();
      currentUser = AppUser.fromMap(doc.data()!);
      if (currentUser.type == "ADMIN") {
        isAdmin = true;
      }
    }
    loadAllImages();
    getRentList();
    getContactList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: checkAdmin(),
        builder: (context, data) {
          if (data.connectionState == ConnectionState.done) {
            return MaterialApp(
              title: appName,
              scaffoldMessengerKey: scafKey,
              debugShowCheckedModeBanner: false,
              themeMode: ThemeMode.system,
              theme: ThemeData.light(),
              darkTheme: ThemeData.light(),
              initialRoute: isLoggedIn ? '/' : '/login',
              routes: {
                '/': (context) =>
                    isAdmin ? const AdminHome() : const RenterHome(),
                '/login': (context) => Login(),
                '/signup': (context) => const Signup(),
                '/renterHome': (context) => const RenterHome(),
                //'/flatDetails': (context) => FlatDetails(),
                //'/contactAdmin': (context) => ContactForm(),
                '/adminHome': (context) => const AdminHome(),
                //'/editFlat': (context) => EditFlat(),
                '/addNew': (context) => const AddNew(),
                //'/renterInfo': (context) => const RenterInfo(),
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
