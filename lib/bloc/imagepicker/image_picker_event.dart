import 'package:equatable/equatable.dart';

abstract class ImagePickerEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PickImageEvent extends ImagePickerEvent {
  final bool fromCamera;

  PickImageEvent({required this.fromCamera});

  @override
  List<Object?> get props => [fromCamera];
}