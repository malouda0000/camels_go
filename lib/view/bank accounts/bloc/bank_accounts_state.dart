// import 'package:equatable/equatable.dart';

// // Define the possible states for the UserAccountsBloc
// abstract class UserAccountsState extends Equatable {
//   const UserAccountsState();

//   @override
//   List<Object?> get props => [];
// }

// class UserAccountsInitial extends UserAccountsState {}

// class UserAccountsLoading extends UserAccountsState {}

// class UserAccountsSuccess extends UserAccountsState {
//   final List<UserBankAccount> accounts;
//   final int selectedAccountId;

//   const UserAccountsSuccess(this.accounts, this.selectedAccountId);

//   @override
//   List<Object?> get props => [accounts, selectedAccountId];
// }

// class UserAccountsError extends UserAccountsState {
//   final String error;

//   const UserAccountsError(this.error);

//   @override
//   List<Object?> get props => [error];
// }
