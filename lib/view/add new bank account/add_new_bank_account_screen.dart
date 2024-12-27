import 'package:flutter/material.dart';
import 'package:camels_go/core/constants/app_constants.dart';
import 'package:camels_go/core/themes/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

TextEditingController accountNumberTextController = TextEditingController();
TextEditingController ibanNumberTextController = TextEditingController();

class AddNewBankAccountScreen extends StatelessWidget {
  const AddNewBankAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? selectedBank;

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
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
          AppLocalizations.of(context)!.add_new_product,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppConstants.emptySpaceTenPixl,
                AppConstants.emptySpaceTenPixl,

                // Title: Bank Accounts
                Text(
                  AppLocalizations.of(context)!.bank_accounts,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                AppConstants.emptySpaceTenPixl,

                // Dropdown: The Bank
                Text(
                  "The Bank",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                AppConstants.emptySpaceTenPixl,
                Container(
                  height: 40,
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: AppColors.mainColor),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                      value: selectedBank,
                      isExpanded: true,
                      hint: Text(
                        "Select a bank",
                      ),
                      items: [
                        "adb",
                        "dubai bank",
                        "abo dahbi bank",
                        "khartoum bank",
                      ].map((bank) {
                        return DropdownMenuItem<String>(
                          value: bank,
                          child: Text(
                            bank,
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        selectedBank = value;
                      },
                    ),
                  ),
                ),
                AppConstants.emptySpaceTenPixl,

                // First TextFormField: Account Number
                Text(
                  AppLocalizations.of(context)!.about_us,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                AppConstants.emptySpaceTenPixl,
                Container(
                  height: 40,
                  width: double.infinity,
                  alignment: Alignment
                      .centerLeft, // Vertical alignment is already correct
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: AppColors.mainColor),
                  ),
                  child: TextFormField(
                    controller: accountNumberTextController,
                    cursorColor: AppColors.mainColor,
                    keyboardType: TextInputType.number,
                    maxLines: 1,
                    textAlign: TextAlign.left, // Keeps text aligned to the left
                    style: const TextStyle(),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15, // Adds padding from the left
                      ),
                      isDense:
                          true, // Reduces the overall size of the input field
                      hintText: "1459....",
                      hintStyle: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),

                AppConstants.emptySpaceTenPixl,

                // Second TextFormField: Another Field
                Text(
                  "Another Field", // Change the title as needed
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                AppConstants.emptySpaceTenPixl,
                Container(
                  height: 40,
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: AppColors.mainColor),
                  ),
                  child: TextFormField(
                    cursorColor: AppColors.mainColor,
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    style: const TextStyle(),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      isDense: true,
                      hintText: "Enter text",
                      hintStyle: TextStyle(
                        color: AppColors.greyColor,
                      ),
                    ),
                  ),
                ),

                AppConstants.emptySpaceTenPixl,
                AppConstants.emptySpaceTenPixl,

                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(
                          3,
                        )),
                    child: Text(
                      AppLocalizations.of(context)!.add_new_product,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
