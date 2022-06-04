part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class CurrentScreen extends HomeState {}

class GetDataLoading extends HomeState {}

class GetDataSuccess extends HomeState {}

class GetDataError extends HomeState {
  final String error;
  GetDataError(this.error);
}

//Get Project

class GetProjectLoading extends HomeState {}

class GetProjectSuccess extends HomeState {}

class GetProjectError extends HomeState {
  final String error;
  GetProjectError(this.error);
}

//update user data
class UpdateImageLoading extends HomeState {}

class UpdateImageSuccess extends HomeState {}

class UpdateImageError extends HomeState {
  final String error;
  UpdateImageError(this.error);
}

//Upload Profile
class UploadProfileSuccess extends HomeState {}

class UploadProfileError extends HomeState {
  final String error;
  UploadProfileError(this.error);
}

class UploadPostFeedLoading extends HomeState {}

class UploadPostFeedSuccess extends HomeState {}

class UploadPostFeedError extends HomeState {
  final String error;
  UploadPostFeedError(this.error);
}

//create Post
class PostFeedLoading extends HomeState {}

class PostFeedSuccess extends HomeState {}

class PostFeedError extends HomeState {
  final String error;
  PostFeedError(this.error);
}

//send comments
class SendCommentsLoading extends HomeState {}

class SendCommentsSuccess extends HomeState {}

class SendCommentsError extends HomeState {
  final String error;
  SendCommentsError(this.error);
}

class GetImageSuccess extends HomeState {}

class GetImageError extends HomeState {
  final String error;
  GetImageError(this.error);
}

class GetPostImageSuccess extends HomeState {}

class GetPostImageError extends HomeState {
  final String error;
  GetPostImageError(this.error);
}

//get Posts
class GetPostFeedLoading extends HomeState {}

class GetPostFeedSuccess extends HomeState {}

class GetPostFeedError extends HomeState {
  final String error;
  GetPostFeedError(this.error);
}

//update progress
class UpdateProgressLoading extends HomeState {}

class UpdateProgressSuccess extends HomeState {}

class UpdateProgressError extends HomeState {
  final String error;
  UpdateProgressError(this.error);
}
