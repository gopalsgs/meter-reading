import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Meter {
  int id;
  String name;
  String serialNumber;
  DateTime installationDate;
  DateTime outOfServiceDate;
  Meter({
    this.id,
    @required this.name,
    @required this.serialNumber,
    @required this.installationDate,
    @required this.outOfServiceDate,
  });

  

  Meter copyWith({
    int id,
    String name,
    String serialNumber,
    DateTime installationDate,
    DateTime outOfServiceDate,
  }) {
    return Meter(
      id: id ?? this.id,
      name: name ?? this.name,
      serialNumber: serialNumber ?? this.serialNumber,
      installationDate: installationDate ?? this.installationDate,
      outOfServiceDate: outOfServiceDate ?? this.outOfServiceDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'serialNumber': serialNumber,
      'installationDate': installationDate.millisecondsSinceEpoch/1000,
      'outOfServiceDate': outOfServiceDate.millisecondsSinceEpoch/1000,
    };
  }

  factory Meter.fromMap(Map<String, dynamic> map) {
    return Meter(
      id: map['id'],
      name: map['name'],
      serialNumber: map['serialNumber'],
      installationDate: DateTime.fromMillisecondsSinceEpoch(map['installationDate'] * 1000),
      outOfServiceDate: DateTime.fromMillisecondsSinceEpoch(map['outOfServiceDate'] * 1000),
    );
  }

  String toJson() => json.encode(toMap());

  factory Meter.fromJson(String source) => Meter.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Meter(id: $id, name: $name, serialNumber: $serialNumber, installationDate: $installationDate, outOfServiceDate: $outOfServiceDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Meter &&
      other.id == id &&
      other.name == name &&
      other.serialNumber == serialNumber &&
      other.installationDate == installationDate &&
      other.outOfServiceDate == outOfServiceDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      serialNumber.hashCode ^
      installationDate.hashCode ^
      outOfServiceDate.hashCode;
  }
}
