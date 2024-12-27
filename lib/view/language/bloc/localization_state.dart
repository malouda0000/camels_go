part of 'localization_bloc.dart';

class LocalizationState extends Equatable {
  final Locale locale;
  const LocalizationState(this.locale);

//Default state
  factory LocalizationState.initial() {
    return const LocalizationState(Locale('ar'));
  }

  LocalizationState copyWith(Locale locale) {
    return LocalizationState(locale ?? this.locale);
  }

  @override
  List<Object> get props => [locale];
}



// part of 'localization_bloc.dart';

// class LocalizationState extends Equatable {
//   final Locale locale;

//   const LocalizationState(this.locale);

//   factory LocalizationState.initial() => const LocalizationState(Locale('en'));

//   @override
//   List<Object?> get props => [locale];
// }
