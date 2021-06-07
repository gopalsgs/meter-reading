import 'package:flutter/material.dart';
import 'package:meter_reading/core/models/reading_model.dart';

class MeterReadingListItem extends StatelessWidget {
  final MeterReading meterReading;
  final Function onTap;
  const MeterReadingListItem({Key key, @required this.meterReading, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text('${meterReading.id}'),
      title: Text('${meterReading.reading}'),
      subtitle: Text('${meterReading.date}'),
      onTap: onTap,
    );
  }
}
