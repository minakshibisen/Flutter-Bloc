import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'image_picker_event.dart';
import 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  final ImagePicker _picker;

  ImagePickerBloc(this._picker) : super(const ImagePickerState()) {
    on<PickImageEvent>(_onPickImage);
  }

  Future<void> _onPickImage(PickImageEvent event, Emitter<ImagePickerState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: event.fromCamera ? ImageSource.camera : ImageSource.gallery,
      );

      if (pickedFile != null) {
        emit(state.copyWith(imagePath: pickedFile.path, isLoading: false));
      } else {
        emit(state.copyWith(isLoading: false));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: "Error picking image"));
    }
  }
}
