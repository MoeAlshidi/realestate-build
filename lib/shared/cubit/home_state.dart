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

//create Post
class PostFeedLoading extends HomeState {}

class PostFeedSuccess extends HomeState {}

class PostFeedError extends HomeState {
  final String error;
  PostFeedError(this.error);
}
