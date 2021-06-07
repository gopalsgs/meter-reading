import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meter_reading/core/widgets/meter_list_item.dart';
import 'package:meter_reading/features/add_meter_page/add_meter_page.dart';

import 'cubit/meter_cubit.dart';

class MetersPage extends StatelessWidget {
  MetersPage({Key key}) : super(key: key);

  final MeterCubit meterCubit = MeterCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meters'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Row(
          children: [Icon(Icons.add), Text('New Meter')],
        ),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddNewMeterPage(),
            ),
          );
          meterCubit.getAllMeters();
        },
      ),
      body: BlocProvider(
        create: (context) => meterCubit..getAllMeters(),
        child: BlocBuilder<MeterCubit, MeterState>(
          builder: (context, state) {
            if ((state is MeterLoading) || (state is MeterInitial)) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is MeterLoaded) {
              return ListView.separated(
                itemCount: state.meters.length,
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemBuilder: (context, index) {
                  return MeterListItem(
                    meter: state.meters[index],
                  );
                },
              );
            }

            if (state is MeterLoadingError) {
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
