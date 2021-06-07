import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meter_reading/core/widgets/snack_bar.dart';
import 'package:meter_reading/features/add_meter_page/cubit/add_meter_cubit.dart';

class AddNewMeterPage extends StatefulWidget {
  AddNewMeterPage({Key key}) : super(key: key);

  @override
  _AddNewMeterPageState createState() => _AddNewMeterPageState();
}

class _AddNewMeterPageState extends State<AddNewMeterPage> {
  final TextEditingController meterNameController = TextEditingController();
  final TextEditingController serialNumberController = TextEditingController();

  DateTime installationDate;
  DateTime outOfServiceDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Meter'),
      ),
      body: BlocProvider(
        create: (context) => AddMeterCubit(),
        child: BlocConsumer<AddMeterCubit, AddMeterState>(
          listener: (context, state) {
            if (state is AddMeterSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                getSnackBar('Meter Added Successfully'),
              );
              Navigator.pop(context);
            }

            if (state is AddMeterError) {
              ScaffoldMessenger.of(context).showSnackBar(
                getSnackBar('Meter Added Successfully'),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  _buildMeterField(),
                  _buildSerialNumberField(),
                  _buildInstalltionDate(context),
                  _builOutOfServiceDate(context),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<AddMeterCubit>(context).addMeter(
                        name: meterNameController.text,
                        serialNumber: serialNumberController.text,
                        installationDate: installationDate,
                        outOfServiceDate: outOfServiceDate,
                      );
                    },
                    child: Text('Add'),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  _builOutOfServiceDate(BuildContext context) {
    return InkWell(
      onTap: () async {
        outOfServiceDate = await _getDate(context);
        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text('OutOfService Date'),
            Spacer(),
            Text(
              '${outOfServiceDate ?? 'DD/MM/YYYY'}',
            ),
          ],
        ),
      ),
    );
  }

  _buildInstalltionDate(BuildContext context) {
    return InkWell(
      onTap: () async {
        installationDate = await _getDate(context);
        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text('Installation Date'),
            Spacer(),
            Text(
              '${installationDate ?? 'DD/MM/YYYY'}',
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildSerialNumberField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: serialNumberController,
        decoration: InputDecoration(hintText: 'Serial Number'),
        inputFormatters: [LengthLimitingTextInputFormatter(50)],
      ),
    );
  }

  Padding _buildMeterField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: meterNameController,
        inputFormatters: [LengthLimitingTextInputFormatter(50)],
        decoration: InputDecoration(hintText: 'Meter Name'),
      ),
    );
  }

  Future<DateTime> _getDate(BuildContext context) {
    return showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(Duration(days: 1000)),
      initialDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 1000)),
    );
  }
}
