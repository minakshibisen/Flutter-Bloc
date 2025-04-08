part of 'favorite_list_bloc.dart';


abstract class FavoriteListEvent extends Equatable{
const FavoriteListEvent();
  @override
  List<Object?> get props => [];
}

class FetchFavoriteList extends FavoriteListEvent{}
class FavoriteItem extends FavoriteListEvent{
  final FavoriteModelList item;
  const FavoriteItem({ required this.item});
}
class CheckBoxItem extends FavoriteListEvent{
  final FavoriteModelList item;
  const CheckBoxItem({ required this.item});
}
class SelectedItem extends FavoriteListEvent{
  final FavoriteModelList item;
  const SelectedItem({ required this.item});
}
class UnSelectedItem extends FavoriteListEvent{
  final FavoriteModelList item;
  const UnSelectedItem({ required this.item});
}
class DeletedItem extends FavoriteListEvent{
}