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
import 'package:flutter/foundation.dart';

part 'post_event.dart';

part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  List<PostModel> tempPostList = [];

  PostRepository postRepository = PostRepository();

  PostBloc() : super(const PostState()) {
    on<PostFetched>(_fetchPostApi);
    on<SearchItem>(_filterList);
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
      if (kDebugMode) {
        print(error);
      }

      emit(state.copyWith(
        postStatus: PostStatus.failure,
        message: error.toString(),
      ));
    }
  }

  Future<void> _filterList(SearchItem event, Emitter<PostState> emit) async {
    final stSearch = event.stSearch.toLowerCase();
    if (event.stSearch.isEmpty) {
      emit(state.copyWith(tempPostList: [],searchMessage: ''));
    } else {
      tempPostList = state.postList
          .where(
              (element) => element.id.toString() == event.stSearch.toString())
          .toList();
      if (tempPostList.isEmpty) {
        emit(state.copyWith(tempPostList: tempPostList,searchMessage:'No Data Found'));

      }else{
        emit(state.copyWith(tempPostList:tempPostList,searchMessage: ''));

      }
    }
    //
    // final filtered = tempPostList.where((post) {
    //   return post.name.toLowerCase().contains(stSearch) ||
    //       post.email.toLowerCase().contains(stSearch) ||
    //       post.body.toLowerCase().contains(stSearch);
    // }).toList();
    // emit(
    //     state.copyWith(tempPostList: tempPostList, message: 'Filtered search'));
  }
}
