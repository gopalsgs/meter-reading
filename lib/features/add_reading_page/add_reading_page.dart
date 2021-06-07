import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meter_reading/core/models/meter_model.dart';
import 'package:meter_reading/core/widgets/image_picker/image_picker_widget.dart';
import 'package:meter_reading/core/widgets/snack_bar.dart';

import 'cubit/add_reading_cubit.dart';

class AddReadingPage extends StatefulWidget {
  final Meter meter;
  const AddReadingPage({Key key, this.meter}) : super(key: key);

  @override
  _AddReadingPageState createState() => _AddReadingPageState();
}

class _AddReadingPageState extends State<AddReadingPage> {
  final TextEditingController readingController = TextEditingController();

  DateTime readingDate = DateTime.now();

  File imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Reading'),
      ),
      body: BlocProvider(
        create: (context) =>
            AddReadingCubit()..loadLastReading(widget.meter.id),
        child: BlocConsumer<AddReadingCubit, AddReadingState>(
          listener: (context, state) {
            if (state is AddReadingSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                getSnackBar('Reading Added Successfully'),
              );
              Navigator.pop(context);
            }

            if (state is AddReadingError) {
              ScaffoldMessenger.of(context).showSnackBar(
                getSnackBar('${state.failure.message}'),
              );
            }
          },
          builder: (context, state) {
            final cubit = BlocProvider.of<AddReadingCubit>(context);
            final lastReading = cubit.lastReading;

            if (state is LoadingLastReading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is LastReadingLoadError) {
              return Center(
                child: Text(state.failure.message),
              );
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  _buildReadingField(),
                  _buildDate(readingDate, 'Date'),
                  _buildRow(lastReading?.reading, 'Last Reading'),
                  _buildRow(widget.meter.id, 'Meter Id'),
                  _buildDate(lastReading?.date, 'Last Reading Date'),
                  ImagePickerWidget(
                    onImageCaptured: (file) {
                      imageFile = file;
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<AddReadingCubit>(context).addNewReading(
                        date: readingDate,
                        meterId: widget.meter.id,
                        reading: readingController.text,
                        imageFile: imageFile
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

  Widget _buildDate(DateTime date, String title) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(title),
            Spacer(),
            Text(
              '${date ?? 'Nil'}',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(int reading, String title) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(title),
            Spacer(),
            Text(
              '${reading ?? 0}',
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildReadingField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: readingController,
        inputFormatters: [LengthLimitingTextInputFormatter(50)],
        keyboardType: TextInputType.number,
        decoration: InputDecoration(hintText: 'Reading'),
      ),
    );
  }
}
