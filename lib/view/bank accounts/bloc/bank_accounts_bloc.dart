// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:special_line_vendors/view/bank%20accounts/bloc/bank_accounts_event.dart';
// import 'package:special_line_vendors/view/bank%20accounts/bloc/bank_accounts_state.dart';

// class UserAccountsBloc extends Bloc<UserAccountsEvent, UserAccountsState> {
//   UserAccountsBloc() : super(UserAccountsInitial()) {
//     on<GetUserAccountsEvent>(_onGetUserAccountsEvent);
//     on<AddUserAccountEvent>(_onAddUserAccountEvent);
//     on<DeleteUserAccountEvent>(_onDeleteUserAccountEvent);
//   }

//   // Simulate an API call to fetch user accounts
//   Future<void> _onGetUserAccountsEvent(
//       GetUserAccountsEvent event, Emitter<UserAccountsState> emit) async {
//     emit(UserAccountsLoading());
//     try {
//       // Simulate API response
//       await Future.delayed(Duration(seconds: 2));
//       final accounts = [
//         UserBankAccount(id: 1, name: "Bank Account 1"),
//         UserBankAccount(id: 2, name: "Bank Account 2"),
//         UserBankAccount(id: 3, name: "Bank Account 3"),
//       ];
//       emit(UserAccountsSuccess(accounts, accounts.first.id));
//     } catch (e) {
//       emit(UserAccountsError("Failed to load accounts."));
//     }
//   }

//   Future<void> _onAddUserAccountEvent(
//       AddUserAccountEvent event, Emitter<UserAccountsState> emit) async {
//     if (state is UserAccountsSuccess) {
//       final currentState = state as UserAccountsSuccess;
//       final updatedAccounts = List<UserBankAccount>.from(currentState.accounts)
//         ..add(event.newAccount);
//       emit(UserAccountsSuccess(updatedAccounts, currentState.selectedAccountId));
//     }
//   }

//   Future<void> _onDeleteUserAccountEvent(
//       DeleteUserAccountEvent event, Emitter<UserAccountsState> emit) async {
//     if (state is UserAccountsSuccess) {
//       final currentState = state as UserAccountsSuccess;
//       final updatedAccounts = currentState.accounts
//           .where((account) => account.id != event.accountId)
//           .toList();
//       emit(UserAccountsSuccess(updatedAccounts, currentState.selectedAccountId));
//     }
//   }
// }

// // A simple model for the bank account
// class UserBankAccount {
//   final int id;
//   final String name;

//   UserBankAccount({required this.id, required this.name});
// }
