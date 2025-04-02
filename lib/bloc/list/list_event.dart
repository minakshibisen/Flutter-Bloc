
import 'package:equatable/equatable.dart';

abstract class ListEvent extends Equatable {
  const ListEvent();

  @override
  List<Object> get props => [];
}

class AddListEvent extends ListEvent {
  final String task;
  const AddListEvent({required this.task});

  @override
  List<Object> get props => [task];
}

class RemoveListEvent extends ListEvent {
  final String task;

  const RemoveListEvent({required this.task});

  @override
  List<Object> get props => [task];
}
