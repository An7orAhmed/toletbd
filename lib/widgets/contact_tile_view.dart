import 'package:flutter/material.dart';
import 'package:toletbd/model/contact.dart';
import 'package:toletbd/screen/owner/renter_info.dart';

Widget contactTileView(Contact contact) {
  return Card(
    child: ListTile(
      title: Text(contact.ownerEmail),
      subtitle: Text(contact.date),
      leading: Text("${contact.expecttedFee}\nTAKA", textAlign: TextAlign.center),
      trailing: Text(contact.status),
    ),
  );
}

Widget contactTileViewAdmin(context, Contact contact) {
  return Card(
    child: InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => RenterInfo(contact))),
      child: ListTile(
        title: Text(contact.appUser.name),
        subtitle: Text(contact.appUser.phone),
        leading: Text("${contact.expecttedFee}\nTAKA", textAlign: TextAlign.center),
      ),
    ),
  );
}
