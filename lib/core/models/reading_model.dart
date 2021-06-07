import 'dart:convert';
import 'package:image/image.dart' as ImageProcess;

import 'package:flutter/cupertino.dart';

class MeterReading {
  int id;
  int meterId;
  int reading;
  DateTime date;
  double latitude;
  double longitude;
  String image;

  MeterReading({
    this.id,
    @required this.meterId,
    @required this.reading,
    @required this.date,
    @required this.latitude,
    @required this.longitude,
    @required this.image,
  });

  MeterReading copyWith({
    int meterId,
    int id,
    int reading,
    DateTime date,
    double latitude,
    double longitued,
    String image,
  }) {
    return MeterReading(
      id: id ?? this.id,
      meterId: meterId ?? this.meterId,
      reading: reading ?? this.reading,
      date: date ?? this.date,
      image: image ?? this.image,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  static String encodeImage(file) {
    final _imageFile = ImageProcess.decodeImage(
      file.readAsBytesSync(),
    );

    return base64Encode(
      ImageProcess.encodeJpg(_imageFile, quality: 50),
    );
  }

  static Image decodeImage(String base64Image) {
    final _byteImage = Base64Decoder().convert(base64Image);
    return Image.memory(_byteImage);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'meterId': meterId,
      'reading': reading,
      'latitude': latitude,
      'longitude': longitude,
      'image': image,
      'date': date.millisecondsSinceEpoch / 1000,
    };
  }

  factory MeterReading.fromMap(Map<String, dynamic> map) {
    return MeterReading(
      id: map['id'],
      meterId: double.tryParse(map['meterId'])?.toInt() ?? 0,
      reading: map['reading'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      image: map['image'],
      date: DateTime.fromMillisecondsSinceEpoch((map['date'] * 1000).toInt()),
    );
  }
}
