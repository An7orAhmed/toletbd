import 'package:flutter/material.dart';
import 'package:toletbd/constants.dart';
import 'package:toletbd/model/contact.dart';
import 'package:toletbd/widgets/contact_tile_view.dart';
import 'package:toletbd/widgets/rent_card_view.dart';
import '../../model/rent.dart';
import '../../utilities.dart';

class RenterHome extends StatefulWidget {
  const RenterHome({Key? key}) : super(key: key);

  @override
  State<RenterHome> createState() => _RenterHomeState();
}

class _RenterHomeState extends State<RenterHome> {
  int page = 0;

  @override
  void initState() {
    super.initState();
    loadAllImages();
    getRentList();
    getContactList();
  }

  _logout(context) {
    scafKey.currentState!.showSnackBar(
        snackBar(Colors.black, Colors.white, Icons.pending, 'Signing out...'));
    auth.signOut();
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
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

  Widget _renterHomeBody(context) {
    if (page == 0) {
      return FutureBuilder(
          future: getRentList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (rentList.rents.isEmpty) {
                return const Center(
                  child: Text("Sorry! No rental available.\nCome back later.",
                      textAlign: TextAlign.center),
                );
              }
              return GridView.count(
                crossAxisCount: isDesktop(context) ? 4 : 1,
                children: List.generate(rentList.rents.length,
                    (index) => rentCardView(context, rentList.rents[index])),
              );
            }
          });
    } else {
      getContactList();
      var userContact = contactList.contacts
          .where((element) => element.appUser.email == currentUser.email);
      if (userContact.isEmpty) {
        return const Center(child: Text("You didn't have any contact."));
      }
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              for (var contact in userContact) contactTileView(contact)
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(appName),
        actions: [
          Center(child: Text("Hi, ${currentUser.name}")),
          IconButton(
              onPressed: () {
                showAboutDialog(
                    context: context,
                    applicationName: appName,
                    applicationVersion: "1.0.0",
                    applicationLegalese: "Developed by Soma & Shorna",
                    applicationIcon: Image.asset("assets/icon.png",
                        width: 100, height: 100));
              },
              icon: const Icon(Icons.info)),
          IconButton(
              onPressed: () => _logout(context), icon: const Icon(Icons.logout))
        ],
      ),
      body: _renterHomeBody(context),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: page,
        onTap: (value) => setState(() => page = value),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.contacts), label: "Contacts"),
        ],
      ),
    );
  }
}
