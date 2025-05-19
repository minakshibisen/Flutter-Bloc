// import 'package:bloc/bloc.dart';
// import 'package:bloc_flutter/model/post_model_list.dart';
// import 'package:bloc_flutter/repository/post_repo.dart';
// import 'package:bloc_flutter/utils/enums.dart';
// import 'package:equatable/equatable.dart';
// import 'package:meta/meta.dart';
//
// part 'post_event.dart';
// part 'post_state.dart';
//
// class PostBloc extends Bloc<PostEvent, PostState> {
//
//   PostRepository postRepository = PostRepository();
//
//   PostBloc() : super(PostState()) {
//     on<PostFetched>(fetchPostApi) ;
//   }
//
//   void fetchPostApi(PostFetched event, Emitter<PostState>emit){
//     postRepository.fetchPost().then(value){
//       emit(state.copyWith(
//         postStatus:PostStatus.success,
//         message:'success',
//         postList:value
//       ))
//     }).onError(error,stachTrace){
//   emit (state.copyWith(postStatus:PostStatus.failure,message:error.toString()));
//     });
//   }
// }
import 'package:bloc/bloc.dart';
import 'package:bloc_flutter/model/post_model_list.dart';
import 'package:bloc_flutter/repository/post_repo.dart';
import 'package:bloc_flutter/utils/enums.dart';
import 'package:equatable/equatable.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository= PostRepository();

  PostBloc() : super(const PostState()) {
    on<PostFetched>(_fetchPostApi);
  }

  Future<void> _fetchPostApi(PostFetched event, Emitter<PostState> emit) async {
    emit(state.copyWith(postStatus: PostStatus.loading));
    try {
      final posts = await postRepository.fetchPost();
      emit(state.copyWith(
        postStatus: PostStatus.success,
        postList: posts,
        message: 'Success',
      ));
    } catch (error) {
      print(error);

      emit(state.copyWith(
        postStatus: PostStatus.failure,
        message: error.toString(),
      ));
    }
  }
}
