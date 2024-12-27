part of 'onbording_bloc.dart';

sealed class OnbordingState extends Equatable {
  const OnbordingState();
  
  @override
  List<Object> get props => [];
}

final class OnbordingInitial extends OnbordingState {}
