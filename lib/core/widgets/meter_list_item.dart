import 'package:flutter/material.dart';
import 'package:meter_reading/core/models/meter_model.dart';
import 'package:meter_reading/features/add_reading_page/add_reading_page.dart';

class MeterListItem extends StatelessWidget {
  final Meter meter;
  final Function onTap;
  const MeterListItem({Key key, @required this.meter, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text('${meter.id}'),
      title: Text('${meter.name}'),
      subtitle: Text('${meter.serialNumber}'),
      onTap: onTap,
      trailing: ElevatedButton(
        onPressed: (DateTime.now().isAfter(meter.installationDate) &&
                DateTime.now().isBefore(meter.outOfServiceDate))
            ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddReadingPage(meter: meter),
                  ),
                );
              }
            : null,
        child: Text(
          DateTime.now().isBefore(meter.installationDate)
              ? 'Not Started'
              : DateTime.now().isAfter(meter.outOfServiceDate)
                  ? 'Ended'
                  : 'Add Reading',
        ),
      ),
    );
  }
}
