import 'dart:convert';
import 'package:collection/collection.dart';

class Rent {
  String addedBy;
  String title;
  String imgList;
  String rentType;
  String description;
  String location;
  String addedTime;
  int rentFeeStart;
  int rentFeeEnd;
  int roomCount;
  int bathroowCount;
  int floorNo;
  int size;
  bool isLiftAvailable;
  bool isParkingAvailable;
  bool isRented;

  Rent({
    required this.addedBy,
    required this.title,
    required this.imgList,
    required this.rentType,
    required this.description,
    required this.location,
    required this.addedTime,
    required this.rentFeeStart,
    required this.rentFeeEnd,
    required this.roomCount,
    required this.bathroowCount,
    required this.floorNo,
    required this.size,
    required this.isLiftAvailable,
    required this.isParkingAvailable,
    required this.isRented,
  });

  Rent copyWith({
    String? addedBy,
    String? title,
    String? imgList,
    String? rentType,
    String? description,
    String? location,
    String? addedTime,
    int? rentFeeStart,
    int? rentFeeEnd,
    int? roomCount,
    int? bathroowCount,
    int? floorNo,
    int? size,
    bool? isLiftAvailable,
    bool? isParkingAvailable,
    bool? isRented,
  }) {
    return Rent(
      addedBy: addedBy ?? this.addedBy,
      title: title ?? this.title,
      imgList: imgList ?? this.imgList,
      rentType: rentType ?? this.rentType,
      description: description ?? this.description,
      location: location ?? this.location,
      addedTime: addedTime ?? this.addedTime,
      rentFeeStart: rentFeeStart ?? this.rentFeeStart,
      rentFeeEnd: rentFeeEnd ?? this.rentFeeEnd,
      roomCount: roomCount ?? this.roomCount,
      bathroowCount: bathroowCount ?? this.bathroowCount,
      floorNo: floorNo ?? this.floorNo,
      size: size ?? this.size,
      isLiftAvailable: isLiftAvailable ?? this.isLiftAvailable,
      isParkingAvailable: isParkingAvailable ?? this.isParkingAvailable,
      isRented: isRented ?? this.isRented,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'addedBy': addedBy,
      'title': title,
      'imgList': imgList,
      'rentType': rentType,
      'description': description,
      'location': location,
      'addedTime': addedTime,
      'rentFeeStart': rentFeeStart,
      'rentFeeEnd': rentFeeEnd,
      'roomCount': roomCount,
      'bathroowCount': bathroowCount,
      'floorNo': floorNo,
      'size': size,
      'isLiftAvailable': isLiftAvailable,
      'isParkingAvailable': isParkingAvailable,
      'isRented': isRented,
    };
  }

  factory Rent.fromMap(Map<String, dynamic> map) {
    return Rent(
      addedBy: map['addedBy'] as String,
      title: map['title'] as String,
      imgList: map['imgList'] as String,
      rentType: map['rentType'] as String,
      description: map['description'] as String,
      location: map['location'] as String,
      addedTime: map['addedTime'] as String,
      rentFeeStart: map['rentFeeStart'] as int,
      rentFeeEnd: map['rentFeeEnd'] as int,
      roomCount: map['roomCount'] as int,
      bathroowCount: map['bathroowCount'] as int,
      floorNo: map['floorNo'] as int,
      size: map['size'] as int,
      isLiftAvailable: map['isLiftAvailable'] as bool,
      isParkingAvailable: map['isParkingAvailable'] as bool,
      isRented: map['isRented'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Rent.fromJson(String source) =>
      Rent.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Rent(addedBy: $addedBy, title: $title, imgList: $imgList, rentType: $rentType, description: $description, location: $location, addedTime: $addedTime, rentFeeStart: $rentFeeStart, rentFeeEnd: $rentFeeEnd, roomCount: $roomCount, bathroowCount: $bathroowCount, floorNo: $floorNo, size: $size, isLiftAvailable: $isLiftAvailable, isParkingAvailable: $isParkingAvailable, isRented: $isRented)';
  }

  @override
  bool operator ==(covariant Rent other) {
    if (identical(this, other)) return true;

    return other.addedBy == addedBy &&
        other.title == title &&
        other.imgList == imgList &&
        other.rentType == rentType &&
        other.description == description &&
        other.location == location &&
        other.addedTime == addedTime &&
        other.rentFeeStart == rentFeeStart &&
        other.rentFeeEnd == rentFeeEnd &&
        other.roomCount == roomCount &&
        other.bathroowCount == bathroowCount &&
        other.floorNo == floorNo &&
        other.size == size &&
        other.isLiftAvailable == isLiftAvailable &&
        other.isParkingAvailable == isParkingAvailable &&
        other.isRented == isRented;
  }

  @override
  int get hashCode {
    return addedBy.hashCode ^
        title.hashCode ^
        imgList.hashCode ^
        rentType.hashCode ^
        description.hashCode ^
        location.hashCode ^
        addedTime.hashCode ^
        rentFeeStart.hashCode ^
        rentFeeEnd.hashCode ^
        roomCount.hashCode ^
        bathroowCount.hashCode ^
        floorNo.hashCode ^
        size.hashCode ^
        isLiftAvailable.hashCode ^
        isParkingAvailable.hashCode ^
        isRented.hashCode;
  }
}

class RentList {
  List<Rent> rents;
  RentList({
    required this.rents,
  });

  RentList copyWith({
    List<Rent>? rents,
  }) {
    return RentList(
      rents: rents ?? this.rents,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rents': rents.map((x) => x.toMap()).toList(),
    };
  }

  factory RentList.fromMap(Map<String, dynamic> map) {
    return RentList(
      rents: List<Rent>.from(
        (map['rents'] as List<dynamic>).map<Rent>(
          (x) => Rent.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory RentList.fromJson(String source) =>
      RentList.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'RentList(rents: $rents)';

  @override
  bool operator ==(covariant RentList other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return listEquals(other.rents, rents);
  }

  @override
  int get hashCode => rents.hashCode;
}
