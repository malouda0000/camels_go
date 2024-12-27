part of 'localization_bloc.dart';

sealed class LocalizationEvent extends Equatable {
  const LocalizationEvent();

  @override
  List<Object> get props => [];
}

class LoadLocalizationEvent extends LocalizationEvent {
  final Locale locale;
  const LoadLocalizationEvent(this.locale);

  @override
  List<Object> get props => [locale];
}

class LoadSavedLocalizationEvent extends LocalizationEvent {}



// part of 'localization_bloc.dart';

// abstract class LocalizationEvent extends Equatable {
//   const LocalizationEvent();

//   @override
//   List<Object?> get props => [];
// }

// class LoadLocalizationEvent extends LocalizationEvent {
//   final Locale locale;

//   const LoadLocalizationEvent(this.locale);

//   @override
//   List<Object?> get props => [locale];
// }

// class LoadSavedLocalizationEvent extends LocalizationEvent {}
