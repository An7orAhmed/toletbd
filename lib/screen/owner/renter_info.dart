import 'package:flutter/material.dart';
import 'package:toletbd/constants.dart';
import 'package:toletbd/model/contact.dart';

import '../../utilities.dart';

class RenterInfo extends StatefulWidget {
  Contact contact;
  RenterInfo(this.contact, {Key? key}) : super(key: key);

  @override
  State<RenterInfo> createState() => _RenterInfoState();
}

class _RenterInfoState extends State<RenterInfo> {
  _updateStatus(String val) {
    widget.contact.status = val;
    contactList.contacts.removeWhere((element) => element.date == widget.contact.date);
    contactList.contacts.add(widget.contact);
    scafKey.currentState!.showSnackBar(snackBar(Colors.green, Colors.white, Icons.pending, 'Updated Status...'));
    db.collection("Data").doc("Contacts").set(contactList.toMap());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool opt1 = widget.contact.status == "VIEWED" ? true : false;
    bool opt2 = widget.contact.status == "PENDING" ? true : false;
    bool opt3 = widget.contact.status == "ACCEPTED" ? true : false;

    return Scaffold(
      appBar: AppBar(title: const Text("Renter Details")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text("Renter Message:"),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(widget.contact.message),
              ),
              const Divider(),
              ListTile(
                title: const Text("Renter Name"),
                subtitle: Text(widget.contact.appUser.name),
              ),
              ListTile(
                title: const Text("Renter Email"),
                subtitle: Text(widget.contact.appUser.email),
              ),
              ListTile(
                title: const Text("Renter Address"),
                subtitle: Text(widget.contact.appUser.address),
              ),
              ListTile(
                title: const Text("Renter Phone No."),
                subtitle: Text(widget.contact.appUser.phone),
              ),
              ListTile(
                title: const Text("Requested Fee"),
                subtitle: Text("${widget.contact.expecttedFee}TK"),
              ),
              ListTile(
                title: const Text("Message Time"),
                subtitle: Text(widget.contact.date),
              ),
              ListTile(
                title: const Text("Current Status"),
                subtitle: Text(widget.contact.status),
              ),
              const Divider(),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text("Reply to renter:"),
              ),
              const SizedBox(height: 10),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ChoiceChip(
                      label: const Text("VIEWED"),
                      selected: opt1,
                      onSelected: (val) {
                        opt1 = val;
                        _updateStatus("VIEWED");
                      },
                    ),
                    ChoiceChip(
                      label: const Text("PENDING"),
                      selected: opt2,
                      onSelected: (val) {
                        opt2 = val;
                        _updateStatus("PENDING");
                      },
                    ),
                    ChoiceChip(
                      label: const Text("ACCEPTED"),
                      selected: opt3,
                      onSelected: (val) {
                        opt3 = val;
                        _updateStatus("ACCEPTED");
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
