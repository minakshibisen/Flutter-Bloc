import 'package:bloc_flutter/bloc/post/post_bloc.dart';
import 'package:bloc_flutter/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/enums.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  void initState(){
    super.initState();
    context.read<PostBloc>().add(PostFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('posts APIs'),
      ),
      body: BlocBuilder<PostBloc,PostState>(builder: (context,state){
        switch(state.postStatus){
          case PostStatus.loading:
            return CircularProgressIndicator();
          case PostStatus.failure:
            return Center(child: Text(state.message.toString(),));
          case PostStatus.success:
            return ListView.builder(
                itemCount: state.postList.length,
                itemBuilder: (context,index){
                  final item = state.postList[index];
              return ListTile(
                title: Text(item.email.toString(),),
                subtitle: Text(item.body.toString()),
              );
            });
        }

      }),
    );
  }
}
