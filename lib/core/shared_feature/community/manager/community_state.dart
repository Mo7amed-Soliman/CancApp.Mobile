import 'package:canc_app/core/shared_feature/community/data/models/post_model.dart';
import 'package:equatable/equatable.dart';

abstract class CommunityState extends Equatable {
  const CommunityState();

  @override
  List<Object?> get props => [];
}

class CommunityInitial extends CommunityState {}

class CommunityLoading extends CommunityState {}

class CommunityLoaded extends CommunityState {
  final List<PostModel> posts;
  final bool hasMorePosts;

  const CommunityLoaded({
    required this.posts,
    required this.hasMorePosts,
  });

  @override
  List<Object?> get props => [posts, hasMorePosts];
}

class CommunityError extends CommunityState {
  final String message;

  const CommunityError(this.message);

  @override
  List<Object?> get props => [message];
}
