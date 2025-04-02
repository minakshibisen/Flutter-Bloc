import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'list_event.dart';

part 'list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  final List<String> list =[];
  ListBloc() : super(const ListState()) {
    on<AddListEvent>(addListEvent) ;
  
  }

  void addListEvent(AddListEvent event,Emitter<ListState>emit){
    list.add(event.task);
    emit(state.copyWith(list: List.from(list)));
  }
  
}
