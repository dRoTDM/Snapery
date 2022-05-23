import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

abstract class HomePageState extends Equatable {}

class ImageRecognitionInitialState extends HomePageState {
  @override
  List<Object> get props => [];
}

class ImageRecognitionLoading extends HomePageState {
  @override
  List<Object> get props => [];
}

class ImageRecognitionImageIdentified extends HomePageState {
  final PickedFile image;
  final List<String> outputs;

  ImageRecognitionImageIdentified(
      {@required this.image, @required this.outputs});

  @override
  List<Object> get props => [image, outputs];
}

class ImageRecognitionImageNotIdentified extends HomePageState {
  final PickedFile image;
  final String errorMsg;

  ImageRecognitionImageNotIdentified({
    @required this.image,
    @required this.errorMsg,
  });

  @override
  List<Object> get props => [image, errorMsg];
}

class LogOutInitial extends HomePageState {
  @override
  List<Object> get props => [];
}

class LogOutSuccess extends HomePageState {
  @override
  List<Object> get props => [];
}
