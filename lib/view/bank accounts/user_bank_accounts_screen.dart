import 'package:camels_go/view/add%20new%20bank%20account/add_new_bank_account_screen.dart';
import 'package:camels_go/view/shared/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:camels_go/core/constants/app_constants.dart';
import 'package:camels_go/core/func/nav_func.dart';
import 'package:camels_go/core/themes/app_colors.dart';

class UserBankAccountsScreen extends StatefulWidget {
  const UserBankAccountsScreen({super.key});

  @override
  State<UserBankAccountsScreen> createState() => _UserBankAccountsState();
}

class _UserBankAccountsState extends State<UserBankAccountsScreen> {
  // Variable to track the selected bank account
  int _selectedBankAccount = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).canPop() ? Navigator.of(context).pop() : null;
          },
          icon: Container(
            height: 24,
            width: 24,
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.circular(5),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.arrow_back_ios,
              size: 16,
              color: Colors.white,
            ),
          ),
        ),
        title: Text(
          AppLocalizations.of(context)!.bank_accounts,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Column(
            children: [
              AppConstants.emptySpaceTenPixl,
              AppConstants.emptySpaceTenPixl,
              AppConstants.emptySpaceTenPixl,

              // First Bank Account Container
              InkWell(
                onTap: () {
                  setState(() {
                    _selectedBankAccount = 1;
                  });
                },
                child: Container(
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(
                      color: AppColors.mainColor,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${AppLocalizations.of(context)!.the_bank}: First ADB Bank",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "${AppLocalizations.of(context)!.bank_accounts}: First ADB Bank",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Radio<int>(
                          value: 1,
                          groupValue: _selectedBankAccount,
                          onChanged: (value) {
                            setState(() {
                              _selectedBankAccount = value!;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),

              // // Second Bank Account Container
              InkWell(
                onTap: () {
                  setState(() {
                    _selectedBankAccount = 2;
                  });
                },
                child: Container(
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(
                      color: AppColors.mainColor,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${AppLocalizations.of(context)!.the_bank}: First ADB Bank",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "${AppLocalizations.of(context)!.bank_accounts}: First ADB Bank",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Radio<int>(
                          value: 2,
                          groupValue: _selectedBankAccount,
                          onChanged: (value) {
                            setState(() {
                              _selectedBankAccount = value!;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Third Bank Account Container
              InkWell(
                onTap: () {
                  setState(() {
                    _selectedBankAccount = 3;
                  });
                },
                child: Container(
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(
                      color: AppColors.mainColor,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${AppLocalizations.of(context)!.the_bank}: First ADB Bank",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "${AppLocalizations.of(context)!.bank_accounts}: First ADB Bank",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Radio<int>(
                          value: 3,
                          groupValue: _selectedBankAccount,
                          onChanged: (value) {
                            setState(() {
                              _selectedBankAccount = value!;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              AppConstants.emptySpaceTenPixl,
              AppConstants.emptySpaceTenPixl,
              AppConstants.emptySpaceTenPixl,
              AppButton(
                title: AppLocalizations.of(context)!.add_new_product,
                height: 40,
                width: double.infinity,
                borderRadius: 3,
                backgroundColor: AppColors.mainColor,
                onTap: () {
                  //
                  navigateTo(context, AddNewBankAccountScreen());

                  // showModalBottomSheet(
                  //   context: context,
                  //   builder: (context) {
                  //     // State variable for the dropdown menu
                  //     String? selectedBank;

                  //     return Container(
                  //       width: double.infinity,
                  //       padding: EdgeInsets.all(15),
                  //       // child: ,
                  //     );
                  //   },
                  //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  // );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:special_line_vendors/view/bank%20accounts/bloc/bank_accounts_bloc.dart';
// import 'package:special_line_vendors/view/bank%20accounts/bloc/bank_accounts_event.dart';
// import 'package:special_line_vendors/view/bank%20accounts/bloc/bank_accounts_state.dart';

// class UserBankAccountsScreen extends StatelessWidget {
//   const UserBankAccountsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => UserAccountsBloc()..add(GetUserAccountsEvent()),
//       child: Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           leading: IconButton(
//             onPressed: () {
//               Navigator.of(context).canPop()
//                   ? Navigator.of(context).pop()
//                   : null;
//             },
//             icon: Container(
//               height: 24,
//               width: 24,
//               padding: EdgeInsets.all(1),
//               decoration: BoxDecoration(
//                 color: Theme.of(context).primaryColor,
//                 borderRadius: BorderRadius.circular(5),
//               ),
//               alignment: Alignment.center,
//               child: Icon(
//                 Icons.arrow_back_ios,
//                 size: 16,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//           title: Text(
//             "Bank Accounts",
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
//           ),
//         ),
//         body: BlocBuilder<UserAccountsBloc, UserAccountsState>(
//           builder: (context, state) {
//             if (state is UserAccountsLoading) {
//               return Center(child: CircularProgressIndicator());
//             } else if (state is UserAccountsError) {
//               return Center(child: Text(state.error));
//             } else if (state is UserAccountsSuccess) {
//               final accounts = state.accounts;
//               final selectedAccountId = state.selectedAccountId;

//               return ListView.builder(
//                 padding: const EdgeInsets.all(15),
//                 itemCount: accounts.length,
//                 itemBuilder: (context, index) {
//                   final account = accounts[index];
//                   return Container(
//                     height: 80,
//                     margin: EdgeInsets.only(bottom: 10),
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).scaffoldBackgroundColor,
//                       borderRadius: BorderRadius.circular(3),
//                       border: Border.all(color: Theme.of(context).primaryColor),
//                     ),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.all(15),
//                             child: Text(
//                               account.name,
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.all(15),
//                           child: Radio<int>(
//                             value: account.id,
//                             groupValue: selectedAccountId,
//                             onChanged: (value) {
//                               final bloc = context.read<UserAccountsBloc>();
//                               bloc.add(GetUserAccountsEvent()); // Update logic as necessary
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               );
//             }

//             return SizedBox.shrink();
//           },
//         ),
//       ),
//     );
//   }
// }
