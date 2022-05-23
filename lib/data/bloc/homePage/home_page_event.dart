import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

abstract class HomePageEvent extends Equatable {}

class ImageSelectionButtonSelected extends HomePageEvent {
  final PickedFile image;

  ImageSelectionButtonSelected({@required this.image});
  @override
  List<Object> get props => [image];
}

class LogoutButtonPressed extends HomePageEvent {
  @override
  List<Object> get props => [];
}
