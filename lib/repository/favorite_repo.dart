import 'package:bloc_flutter/model/favorite_model_list.dart';

class FavoriteRepository{
Future<List<FavoriteModelList>> fetchItem()async{
  await Future.delayed(const Duration(seconds: 2));
  return List.of(_generateList(10));
}
List<FavoriteModelList> _generateList(int length){
return List.generate(length, (index) => FavoriteModelList(id: index.toString(), value: 'item'));
}
}