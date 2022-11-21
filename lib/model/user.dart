import 'dart:convert';

class AppUser {
  String name;
  String email;
  String address;
  String phone;
  String nid;
  String type;
  AppUser({
    required this.name,
    required this.email,
    required this.address,
    required this.phone,
    required this.nid,
    required this.type,
  });

  AppUser copyWith({
    String? name,
    String? email,
    String? address,
    String? phone,
    String? nid,
    String? type,
  }) {
    return AppUser(
      name: name ?? this.name,
      email: email ?? this.email,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      nid: nid ?? this.nid,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'address': address,
      'phone': phone,
      'nid': nid,
      'type': type,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      name: map['name'] as String,
      email: map['email'] as String,
      address: map['address'] as String,
      phone: map['phone'] as String,
      nid: map['nid'] as String,
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) => AppUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AppUser(name: $name, email: $email, address: $address, phone: $phone, nid: $nid, type: $type)';
  }

  @override
  bool operator ==(covariant AppUser other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.address == address &&
        other.phone == phone &&
        other.nid == nid &&
        other.type == type;
  }

  @override
  int get hashCode {
    return name.hashCode ^ email.hashCode ^ address.hashCode ^ phone.hashCode ^ nid.hashCode ^ type.hashCode;
  }
}
