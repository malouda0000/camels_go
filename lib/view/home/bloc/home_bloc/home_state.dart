part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();
  
  @override
  List<Object> get props => [];
}

final class HomeInitialState extends HomeState {}
final class HomeLoadingState extends HomeState {}
final class HomeSucssesState extends HomeState {}
final class HomeErrorState extends HomeState {}
