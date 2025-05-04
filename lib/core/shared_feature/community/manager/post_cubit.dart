import 'package:canc_app/core/error/failure.dart';
import 'package:canc_app/core/shared_feature/community/data/models/post_model.dart';
import 'package:canc_app/core/shared_feature/community/data/repositories/community_repository.dart';
import 'package:canc_app/core/shared_feature/community/manager/post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostCubit extends Cubit<PostState> {
  final CommunityRepository repository;

  PostCubit({required this.repository}) : super(PostInitial());

  Future<void> createPost(String content, String userId,
      {String? image}) async {
    emit(PostLoading());
    final result = await repository.createPost(content, userId, image: image);
    result.fold(
      (failure) => emit(PostError(failure.toString())),
      (post) => emit(PostCreated(post)),
    );
  }

  Future<void> updatePost(String id, String content, String userId,
      {String? image}) async {
    emit(PostLoading());
    final result =
        await repository.updatePost(id, content, userId, image: image);
    result.fold(
      (failure) => emit(PostError(failure.toString())),
      (post) => emit(PostUpdated(post)),
    );
  }

  Future<void> deletePost(String postId) async {
    emit(PostLoading());
    final result = await repository.deletePost(postId);
    result.fold(
      (failure) => emit(PostError(failure.toString())),
      (_) => emit(PostDeleted(postId)),
    );
  }
}
