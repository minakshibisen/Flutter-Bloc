import 'package:equatable/equatable.dart';

class ImagePickerState extends Equatable {
  final String? imagePath;
  final bool isLoading;
  final String? error;

  const ImagePickerState({this.imagePath, this.isLoading = false, this.error});

  @override
  List<Object?> get props => [imagePath, isLoading, error];

  ImagePickerState copyWith({String? imagePath, bool? isLoading, String? error}) {
    return ImagePickerState(
      imagePath: imagePath ?? this.imagePath,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
