import 'package:bloc_flutter/bloc/favoritelist/favorite_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FavoriteListBloc, FavoriteListState>(
        builder: (context, state) {
          return Column(
            children: [
              Center(
                child: Text('text1'),
              )
            ],
          );
        },
      ),
    );
  }
}
