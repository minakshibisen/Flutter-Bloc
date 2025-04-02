import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'list_event.dart';

part 'list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  final List<String> list =[];
  ListBloc() : super(const ListState(list: [])) {
    on<AddListEvent>(addListEvent) ;
    on<RemoveListEvent>(removeListEvent) ;
    on<UpdateListEvent>(updateListEvent) ;

  }
  void addListEvent(AddListEvent event, Emitter<ListState> emit) {
    List<String> updatedList = List.from(state.list);
    updatedList.add(event.task);
    emit(state.copyWith(list: updatedList));
  }

  void removeListEvent(RemoveListEvent event, Emitter<ListState> emit) {
    List<String> updatedList = List.from(state.list);
    updatedList.remove(event.task);
    emit(state.copyWith(list: updatedList));
  }

  void updateListEvent(UpdateListEvent event, Emitter<ListState> emit) {
    int index = list.indexOf(event.oldTask);
    if (index != -1) {
      list[index] = event.newTask;
      emit(state.copyWith(list: List.from(list)));
    }
  }
  }
