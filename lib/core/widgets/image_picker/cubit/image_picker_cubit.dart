import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:image/image.dart' as ImageProcess;

part 'image_picker_state.dart';

class ImagePickerCubit extends Cubit<ImagePickerState> {
  ImagePickerCubit() : super(NoImageState());

  void getImage() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxHeight: 150,
      maxWidth: 150,
      imageQuality: 30,
    );
    if (pickedFile != null) {
      emit(ImageDisplayState(File(pickedFile.path)));
    } else {
      print('No image selected.');
      emit(NoImageState());
    }
  }

  
}
