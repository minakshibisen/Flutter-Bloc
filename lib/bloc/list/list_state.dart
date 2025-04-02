part of 'list_bloc.dart';


class ListState extends Equatable {
  final List<String> list;

  const ListState({required this.list});

  ListState copyWith({List<String>? list}) {
    return ListState(
      list: list ?? this.list,
    );
  }

  @override
  List<Object> get props => [list];
}
