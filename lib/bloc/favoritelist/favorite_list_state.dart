part of 'favorite_list_bloc.dart';

enum ListStatus { loading, success, failure }

class FavoriteListState extends Equatable {
  final List<FavoriteModelList> favoriteItemList;
  final ListStatus listStatus;

  const FavoriteListState(
      {this.favoriteItemList = const [], this.listStatus = ListStatus.loading});

  FavoriteListState copyWith({List<FavoriteModelList>? favoriteItemList,ListStatus? listStatus}){
    return FavoriteListState(
    favoriteItemList: favoriteItemList ?? this.favoriteItemList,
      listStatus: listStatus ?? this.listStatus
    );
}
  @override
  List<Object?> get props => [favoriteItemList,listStatus];
}
