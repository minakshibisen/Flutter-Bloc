part of 'switch_bloc.dart';

abstract class SwitchEvent extends Equatable {
  const SwitchEvent();
  @override
  List<Object?> get props =>[];
}

class EnableDisableNotification extends SwitchEvent{}
class SliderEvent extends SwitchEvent{
  double slider;
  SliderEvent({required this.slider});

  @override
  List<Object?> get props =>[slider];
}
