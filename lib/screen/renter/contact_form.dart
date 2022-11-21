import 'package:flutter/material.dart';
import 'package:toletbd/constants.dart';
import 'package:toletbd/model/contact.dart';
import '../../utilities.dart';

class ContactForm extends StatefulWidget {
  String owner;
  ContactForm(this.owner, {Key? key}) : super(key: key);

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final message = TextEditingController();
  final requestFee = TextEditingController();

  _sendContactForm(context) {
    if (message.text.isEmpty || requestFee.text.isEmpty) {
      scafKey.currentState!.showSnackBar(snackBar(Colors.red, Colors.white, Icons.error, 'Please enter data!'));
      return;
    }
    var contact = Contact(
      appUser: currentUser,
      ownerEmail: widget.owner,
      message: message.text,
      date: DateTime.now().toString().split('.')[0],
      status: "SENT",
      expecttedFee: int.parse(requestFee.text),
    );
    contactList.contacts.add(contact);
    scafKey.currentState!.showSnackBar(snackBar(Colors.green, Colors.white, Icons.send, 'Sending request to owner...'));
    db.collection("Data").doc("Contacts").set(contactList.toMap());
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contact Form")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              ListTile(
                title: const Text("Contact with"),
                subtitle: Text(widget.owner),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: message,
                decoration: const InputDecoration(
                  hintText: "Enter your message here",
                  labelText: "Message",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: requestFee,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Enter your request fee",
                  labelText: "Requested fee",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              Center(
                child: OutlinedButton(
                  onPressed: () => _sendContactForm(context),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    child: Text("Submit"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
