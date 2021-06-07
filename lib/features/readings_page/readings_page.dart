import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meter_reading/core/widgets/meter_reading_list_item.dart';
import 'package:meter_reading/features/readings_page/cubit/meter_reading_cubit.dart';

class ReadingsPage extends StatelessWidget {
  const ReadingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Readings'),
      ),
      body: BlocProvider(
        create: (context) => MeterReadingCubit()..getAllReadings(),
        child: BlocBuilder<MeterReadingCubit, MeterReadingState>(
          builder: (context, state) {
            if ((state is MeterReadingLoading) ||
                (state is MeterReadingInitial)) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is MeterReadingLoaded) {
              return ListView.separated(
                itemCount: state.meterReadings.length,
                itemBuilder: (context, index) {
                  return MeterReadingListItem(
                    meterReading: state.meterReadings[index],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
              );
            }

            if (state is MeterReadingError) {
              return Center(
                child: Text(state.failure.message),
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
