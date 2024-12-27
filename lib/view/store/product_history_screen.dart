import 'package:camels_go/core/constants/app_constants.dart';
import 'package:camels_go/core/themes/app_colors.dart';
import 'package:camels_go/view/shared/widgets/horizontal_scroll_widget.dart';
import 'package:camels_go/view/shared/widgets/title_backword_widget.dart';
import 'package:camels_go/view/store/bloc/store_bloc.dart';
import 'package:camels_go/view/store/model/product_history_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductHistoryScreen extends StatefulWidget {
  final int productId;

  ProductHistoryScreen({required this.productId});

  @override
  State<ProductHistoryScreen> createState() => _ProductHistoryScreenState();
}

class _ProductHistoryScreenState extends State<ProductHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => StoreBloc()
            ..add(FetchProductHistoryEvent(productId: widget.productId)),
          child: BlocBuilder<StoreBloc, StoreState>(
            builder: (context, state) {
              if (state is StoreLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is ProductHistoryLoadedState) {
                return _buildHistoryContent(state.history);
              } else if (state is StoreErrorState) {
                return Center(child: Text(state.message));
              } else {
                return Center(child: Text('Error loading product history'));
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryContent(List<ProductHistoryModel> history) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        TitleBackwordWidget(
            title: AppLocalizations.of(context)!.product_sales_record),
        SizedBox(height: 16),
        // _buildSearchBar(),
        SizedBox(height: 16),
        _buildHistoryTable(history),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: () {},
        child: Row(
          children: [
            Expanded(
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'ابحث عن شحنتك...',
                  prefixIcon: SizedBox(
                    width: 40,
                    height: 40,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        'assets/svg images/search_cardbox.svg',
                        width: 24.0,
                        height: 24.0,
                      ),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: AppColors.mainColor),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
            SizedBox(width: 10),
            SvgPicture.asset(
              'assets/svg images/search_list.svg',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryTable(List<ProductHistoryModel> history) {
    return HorizontalScrollWidget(
      widthSize: 2,
      padding: const EdgeInsets.all(8.0),
      content: Column(
        children: [
          _buildHistoryItem(
            padding: 5,
            radius: 6,
            referenceNumber: AppLocalizations.of(context)!.reference_number,
            customerNumber: AppLocalizations.of(context)!.customer_number,
            emirate: AppLocalizations.of(context)!.emirate,
            qty: AppLocalizations.of(context)!.quantity,
            date: AppLocalizations.of(context)!.date,
            notes: AppLocalizations.of(context)!.note,
            color: AppColors.mainColor,
            textColor: Colors.white,
            height: 38,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: history.length,
            itemBuilder: (context, index) {
              final item = history[index];
              return _buildHistoryItem(
                padding: 5,
                referenceNumber: item.referenceCode ?? '--',
                customerNumber: item.customerNumber ?? '--',
                emirate: (AppConstants.isArabic()
                        ? item.emirateAr
                        : item.emirateEn) ??
                    '--',
                qty: item.quantity.toString(),
                date: item.date,
                notes: item.notes,
                color: index % 2 == 0 ? Colors.white : Color(0xffF9F9F9),
                textColor: Colors.black,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem({
    required String referenceNumber,
    required String customerNumber,
    required String emirate,
    required String qty,
    required String date,
    required String notes,
    required Color color,
    required Color textColor,
    double? radius,
    double? padding,
    double? height,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding ?? 0, vertical: 8),
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius ?? 0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
              flex: 2,
              child: Text(referenceNumber, style: TextStyle(color: textColor))),
          Expanded(
              flex: 2,
              child: Text(customerNumber, style: TextStyle(color: textColor))),
          Expanded(child: Text(emirate, style: TextStyle(color: textColor))),
          Expanded(
            child: Text(
              qty,
              style: TextStyle(color: textColor),
            ),
          ),
          Expanded(child: Text(date, style: TextStyle(color: textColor))),
          Expanded(
              flex: 2,
              child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  child: Text(notes,
                      style: TextStyle(color: textColor),
                      textAlign: TextAlign.center))),
        ],
      ),
    );
  }
}
