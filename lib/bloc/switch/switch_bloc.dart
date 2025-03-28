import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'switch_event.dart';
part 'switch_state.dart';

class SwitchBloc extends Bloc<SwitchEvent, SwitchState> {
  SwitchBloc() : super(SwitchState()) {
    on<EnableDisableNotification>(enableDisableNotification);
    on<SliderEvent>(sliderProcess);
    }
    void enableDisableNotification(EnableDisableNotification events,Emitter<SwitchState>emit){
    emit(state.copyWith(isSwitch: !state.isSwitch));
  }
  void sliderProcess(SliderEvent events,Emitter<SwitchState>emit){
    emit(state.copyWith(isSlider: events.slider));
  }
}
