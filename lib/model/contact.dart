import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:toletbd/model/user.dart';

class Contact {
  AppUser appUser;
  String ownerEmail;
  String message;
  String date;
  String status;
  int expecttedFee;
  Contact({
    required this.appUser,
    required this.ownerEmail,
    required this.message,
    required this.date,
    required this.status,
    required this.expecttedFee,
  });

  Contact copyWith({
    AppUser? appUser,
    String? ownerEmail,
    String? message,
    String? date,
    String? status,
    int? expecttedFee,
  }) {
    return Contact(
      appUser: appUser ?? this.appUser,
      ownerEmail: ownerEmail ?? this.ownerEmail,
      message: message ?? this.message,
      date: date ?? this.date,
      status: status ?? this.status,
      expecttedFee: expecttedFee ?? this.expecttedFee,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'appUser': appUser.toMap(),
      'ownerEmail': ownerEmail,
      'message': message,
      'date': date,
      'status': status,
      'expecttedFee': expecttedFee,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      appUser: AppUser.fromMap(map['appUser'] as Map<String, dynamic>),
      ownerEmail: map['ownerEmail'] as String,
      message: map['message'] as String,
      date: map['date'] as String,
      status: map['status'] as String,
      expecttedFee: map['expecttedFee'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Contact.fromJson(String source) => Contact.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Contact(appUser: $appUser, ownerEmail: $ownerEmail, message: $message, date: $date, status: $status, expecttedFee: $expecttedFee)';
  }

  @override
  bool operator ==(covariant Contact other) {
    if (identical(this, other)) return true;

    return other.appUser == appUser &&
        other.ownerEmail == ownerEmail &&
        other.message == message &&
        other.date == date &&
        other.status == status &&
        other.expecttedFee == expecttedFee;
  }

  @override
  int get hashCode {
    return appUser.hashCode ^
        ownerEmail.hashCode ^
        message.hashCode ^
        date.hashCode ^
        status.hashCode ^
        expecttedFee.hashCode;
  }
}

class ContactList {
  List<Contact> contacts;
  ContactList({
    required this.contacts,
  });

  ContactList copyWith({
    List<Contact>? contacts,
  }) {
    return ContactList(
      contacts: contacts ?? this.contacts,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'contacts': contacts.map((x) => x.toMap()).toList(),
    };
  }

  factory ContactList.fromMap(Map<String, dynamic> map) {
    return ContactList(
      contacts: List<Contact>.from(
        (map['contacts'] as List<dynamic>).map<Contact>(
          (x) => Contact.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactList.fromJson(String source) => ContactList.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ContactList(contacts: $contacts)';

  @override
  bool operator ==(covariant ContactList other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return listEquals(other.contacts, contacts);
  }

  @override
  int get hashCode => contacts.hashCode;
}
