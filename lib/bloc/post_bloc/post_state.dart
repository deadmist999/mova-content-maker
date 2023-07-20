part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostUploadingState extends PostState {}

class PostUploadedState extends PostState {}

class PostErrorState extends PostState {
  final String message;

  const PostErrorState(this.message);
}

class PostMessageEmptyState extends PostState {}

class PostMessageFilledState extends PostState {
  final String message;

  const PostMessageFilledState(this.message);
}