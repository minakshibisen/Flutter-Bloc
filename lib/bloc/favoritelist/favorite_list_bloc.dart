import 'package:bloc/bloc.dart';
import 'package:bloc_flutter/repository/favorite_repo.dart';
import 'package:equatable/equatable.dart';
import '../../model/favorite_model_list.dart';

part 'favorite_list_event.dart';
part 'favorite_list_state.dart';

class FavoriteListBloc extends Bloc<FavoriteListEvent, FavoriteListState> {
  List<FavoriteModelList> favoriteList = [];
  FavoriteRepository favoriteRepository;

  FavoriteListBloc(this.favoriteRepository) : super(FavoriteListState()) {
    on<FetchFavoriteList>(fetchList);
  }

  void fetchList(FetchFavoriteList event, Emitter<FavoriteListState> emit) async {
    favoriteList = await favoriteRepository.fetchItem();
    emit(state.copyWith(
      favoriteItemList: List.from(favoriteList),
      listStatus: ListStatus.success,
    ));
  }
}
