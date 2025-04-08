import 'package:bloc/bloc.dart';
import 'package:bloc_flutter/repository/favorite_repo.dart';
import 'package:equatable/equatable.dart';
import '../../model/favorite_model_list.dart';

part 'favorite_list_event.dart';

part 'favorite_list_state.dart';

class FavoriteListBloc extends Bloc<FavoriteListEvent, FavoriteListState> {
  List<FavoriteModelList> favoriteList = [];
  List<FavoriteModelList> temporaryFavoriteList = [];
  FavoriteRepository favoriteRepository;

  FavoriteListBloc(this.favoriteRepository) : super(FavoriteListState()) {
    on<FetchFavoriteList>(fetchList);
    on<FavoriteItem>(addFavoriteList);
    on<SelectedItem>(_selectedItem);
    on<UnSelectedItem>(_unSelectedItem);
  }

  void fetchList(
      FetchFavoriteList event, Emitter<FavoriteListState> emit) async {
    favoriteList = await favoriteRepository.fetchItem();
    emit(state.copyWith(
      favoriteItemList: List.from(favoriteList),
      listStatus: ListStatus.success,
    ));
  }

  void addFavoriteList(
      FavoriteItem event, Emitter<FavoriteListState> emit) async {
    final index =
        favoriteList.indexWhere((element) => element.id == event.item.id);
    favoriteList[index] = event.item;
    emit(state.copyWith(
      favoriteItemList: List.from(favoriteList),
    ));
  }

  void _selectedItem(
      SelectedItem event, Emitter<FavoriteListState> emit) async {
    temporaryFavoriteList.add(event.item);
    emit(state.copyWith(
      favoriteItemList: List.from(temporaryFavoriteList),

    ));
  }
  void _unSelectedItem(
      UnSelectedItem event, Emitter<FavoriteListState> emit) async {
    temporaryFavoriteList.remove(event.item);
    emit(state.copyWith(
      favoriteItemList: List.from(temporaryFavoriteList),

    ));
  }
}
