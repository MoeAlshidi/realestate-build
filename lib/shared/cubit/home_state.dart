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

//update user data
class UpdateDataLoading extends HomeState {}

class UpdateDataSuccess extends HomeState {}

class UpdateDataError extends HomeState {
  final String error;
  UpdateDataError(this.error);
}

//Upload Profile
class UploadProfileSuccess extends HomeState {}

class UploadProfileError extends HomeState {
  final String error;
  UploadProfileError(this.error);
}

//create Post
class PostFeedLoading extends HomeState {}

class PostFeedSuccess extends HomeState {}

class PostFeedError extends HomeState {
  final String error;
  PostFeedError(this.error);
}

class GetImageSuccess extends HomeState {}

class GetImageError extends HomeState {
  final String error;
  GetImageError(this.error);
}
