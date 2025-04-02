part of 'list_bloc.dart';

 class ListState extends Equatable{
  final List<String> list;
   const ListState({
    this.list=const[]
});
   ListState copyWith({List<String>?list}){
     return ListState(
       list: list??this.list
     );
}
  @override
  List<Object> get props=>[];
}

