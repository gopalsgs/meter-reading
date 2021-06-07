part of 'image_picker_cubit.dart';

@immutable
abstract class ImagePickerState {}

class NoImageState extends ImagePickerState {}

class ImageDisplayState extends ImagePickerState {
  final File image;
  ImageDisplayState(this.image);
}
