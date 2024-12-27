// part of 'personal_profile_bloc.dart';

// sealed class PersonalProfileState extends Equatable {
//   const PersonalProfileState();
  
//   @override
//   List<Object> get props => [];
// }

// final class PersonalProfileInitialState extends PersonalProfileState {}
// final class PersonalProfileLoadingState extends PersonalProfileState {}
// final class PersonalProfileSucssesState extends PersonalProfileState {}
// final class PersonalProfileErrorState extends PersonalProfileState {}


part of 'personal_profile_bloc.dart';

sealed class PersonalProfileState extends Equatable {
  const PersonalProfileState();

  @override
  List<Object?> get props => [];
}

// Initial State
final class PersonalProfileInitialState extends PersonalProfileState {}

// Loading State
final class PersonalProfileLoadingState extends PersonalProfileState {}

// editing State
final class PersonalProfileEditingState extends PersonalProfileState {}

// Success State
final class PersonalProfileSuccessState extends PersonalProfileState {
  final PersonalProfileModel personalProfileModel;

  const PersonalProfileSuccessState({required this.personalProfileModel});

  @override
  List<Object?> get props => [personalProfileModel];
}

// Error State
final class PersonalProfileErrorState extends PersonalProfileState {
  final String errorMessage;

  const PersonalProfileErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}









