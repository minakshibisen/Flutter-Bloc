part of 'favorite_list_bloc.dart';

enum ListStatus { loading, success, failure }

class FavoriteListState extends Equatable {
  final List<FavoriteModelList> favoriteItemList;
  final List<FavoriteModelList> temporaryFavoriteItemList;
  final ListStatus listStatus;

  const FavoriteListState(
      {this.favoriteItemList = const [], this.temporaryFavoriteItemList = const [],this.listStatus = ListStatus.loading});

  FavoriteListState copyWith({List<FavoriteModelList>? favoriteItemList,List<FavoriteModelList>? temporaryFavoriteItemList,ListStatus? listStatus}){
    return FavoriteListState(
    favoriteItemList: favoriteItemList ?? this.favoriteItemList,
        temporaryFavoriteItemList: temporaryFavoriteItemList ?? this.temporaryFavoriteItemList,
      listStatus: listStatus ?? this.listStatus
    );
}
  @override
  List<Object?> get props => [favoriteItemList,listStatus,temporaryFavoriteItemList];
}
