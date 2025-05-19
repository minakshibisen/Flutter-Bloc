part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PostFetched extends PostEvent {}

class SearchItem extends PostEvent {
  final String stSearch;
  SearchItem(this.stSearch);

  List<Object> get props => [stSearch];
}
