import 'package:bloc_flutter/bloc/favoritelist/favorite_list_bloc.dart';
import 'package:bloc_flutter/model/favorite_model_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FavoriteListBloc>().add(FetchFavoriteList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocBuilder<FavoriteListBloc, FavoriteListState>(
            builder: (context, state) {
              switch (state.listStatus) {
                case ListStatus.loading:
                  print('loading');
                  return CircularProgressIndicator();
                case ListStatus.failure:
                  print('failure');
                  return Text('Something went wrong');
                case ListStatus.success:
                  return ListView.builder(
                      itemCount: state.favoriteItemList.length,
                      itemBuilder: (context, index) {
                        final item = state.favoriteItemList[index];
                        return Card(
                            child: ListTile(
                          leading: Checkbox(
                              value:
                                  state.temporaryFavoriteItemList.contains(item)
                                      ? true
                                      : false,
                              onChanged: (value) {
                                if (value!) {
                                  context
                                      .read<FavoriteListBloc>()
                                      .add(SelectedItem(item: item));
                                } else {
                                  context
                                      .read<FavoriteListBloc>()
                                      .add(UnSelectedItem(item: item));
                                }
                              }),
                          title: Text(item.value.toString()),
                          trailing: IconButton(
                              onPressed: () {
                                FavoriteModelList favoriteModelList =
                                    FavoriteModelList(
                                        id: item.id,
                                        value: item.value,
                                        isFavorite:
                                            item.isFavorite ? false : true);
                                context
                                    .read<FavoriteListBloc>()
                                    .add(FavoriteItem(item: favoriteModelList));
                              },
                              icon: Icon(item.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border)),
                        ));
                      });
              }
            },
          ),
        ),
      ),
    );
  }
}
