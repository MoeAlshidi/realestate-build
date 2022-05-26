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
