import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meter_reading/core/widgets/image_picker/cubit/image_picker_cubit.dart';

class ImagePickerWidget extends StatelessWidget {
  final Function onImageCaptured;
  const ImagePickerWidget({Key key, @required this.onImageCaptured}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImagePickerCubit(),
      child: BlocConsumer<ImagePickerCubit, ImagePickerState>(
        listener: (context, state) {
          if (state is ImageDisplayState) {
            onImageCaptured(state.image);
          }
        },
        builder: (context, state) {
          if (state is ImageDisplayState) {
            return Container(
              height: 150,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.file(state.image),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<ImagePickerCubit>(context).getImage();
                    },
                    child: Text('Capture Again'),
                  )
                ],
              ),
            );
          }

          return Center(
            child: ElevatedButton(
              onPressed: () {
                BlocProvider.of<ImagePickerCubit>(context).getImage();
              },
              child: Text('Take Photo'),
            ),
          );
        },
      ),
    );
  }
}
