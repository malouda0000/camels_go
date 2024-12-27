// part of 'personal_profile_bloc.dart';

// sealed class PersonalProfileEvent extends Equatable {
//   const PersonalProfileEvent();

//   @override
//   List<Object> get props => [];
// }

// class GetPersonalProfileEvent extends PersonalProfileEvent{

// }


part of 'personal_profile_bloc.dart';

// Base Event
sealed class PersonalProfileEvent extends Equatable {
  const PersonalProfileEvent();

  @override
  List<Object?> get props => [];
}

// Event to fetch personal profile data
final class GetPersonalProfileEvent extends PersonalProfileEvent {}


// Event to fetch personal profile data
final class PersonalProfileEditingEvent extends PersonalProfileEvent {}
