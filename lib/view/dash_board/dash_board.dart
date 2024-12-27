import 'package:camels_go/core/constants/app_constants.dart';
import 'package:camels_go/core/themes/app_colors.dart';
import 'package:camels_go/core/themes/bloc/theme_bloc.dart';
import 'package:camels_go/view/dash_board/bloc/dashboard_bloc.dart';
import 'package:camels_go/view/dash_board/model/emirate_model.dart';
import 'package:camels_go/view/dash_board/model/shipment_model.dart';
import 'package:camels_go/view/dash_board/model/status_list_model.dart';
import 'package:camels_go/view/dash_board/order_details_screen.dart';
import 'package:camels_go/view/shared/widgets/title_backword_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart' as intl;

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentPage = 1;
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    context.read<DashboardBloc>().add(FetchShipmentSummaryEvent(
        companyId: 867,
        date: intl.DateFormat('yyyy-MM-dd', 'en').format(DateTime.now())));
    // context.read<ShipmentBloc>().add(FetchShipmentsEvent(
    //     companyId: 867,
    //     page: currentPage,
    //     date: DateFormat('yyyy-MM-dd', 'en').format(DateTime.now())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: DashboardBody()),
    );
  }
}

class DashboardBody extends StatefulWidget {
  @override
  State<DashboardBody> createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody> {
  // List<bool> selectedEmirates = List.generate(9, (index) => false);
  List<int> selectedEmirates = [];

  DateTime? fromDate;
  DateTime? toDate;

  int currentPage = 1;
  bool isLoadingMore = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.mainColor,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state is DashboardLoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is DashboardLoadedState) {
          print('here status id: ${state.statusList.first.id}');
          context.read<ShipmentBloc>().add(FetchShipmentsEvent(
                companyId: 867,
                statusId: state.statusList.first.id,
                page: currentPage,
                // fromDate: fromDate != null
                //     ? DateFormat('yyyy-MM-dd', 'en').format(fromDate!)
                //     : null,
                // toDate: toDate != null
                //     ? DateFormat('yyyy-MM-dd', 'en').format(toDate!)
                //     : null
              ));
          // print(context.read<ThemeBloc>().state.themeMode);
          return Column(
            children: [
              _buildHeader(),
              SizedBox(height: 10),
              TitleBackwordWidget(
                  title: AppLocalizations.of(context)!.all_orders),
              _buildOrderButtons(state.statusList),
              _buildSearchBar(context, state.emirateList),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildOrderItem(
                  shipmentId: 0,
                  padding: 5,
                  radius: 6,
                  referenceNumber:
                      AppLocalizations.of(context)!.reference_number,
                  permitNumber: AppLocalizations.of(context)!.customer_number,
                  emirate: AppLocalizations.of(context)!.emirate,
                  amount: AppLocalizations.of(context)!.amount,
                  status: AppLocalizations.of(context)!.shipment_status,
                  color: context.read<ThemeBloc>().state.themeMode ==
                          ThemeMode.light
                      ? AppColors.mainColor
                      : Colors.white,
                  textColor: context.read<ThemeBloc>().state.themeMode ==
                          ThemeMode.light
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              Expanded(
                child: BlocBuilder<ShipmentBloc, DashboardState>(
                  builder: (context, shipmentState) {
                    if (shipmentState is ShipmentLoadingState &&
                        currentPage == 1) {
                      return Center(child: CircularProgressIndicator());
                    } else if (shipmentState is ShipmentLoadedState) {
                      return NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          if (!isLoadingMore &&
                              scrollInfo.metrics.pixels ==
                                  scrollInfo.metrics.maxScrollExtent) {
                            _loadMore();
                            return true;
                          }
                          return false;
                        },
                        child: _buildOrderList(shipmentState.shipments),
                      );
                    }
                    return Text(AppLocalizations.of(context)!.noDataLikeThis);
                  },
                ),
              ),
            ],
          );
        } else {
          return Center(child: Text('Error loading dashboard'));
        }
      },
    );
  }

  void _loadMore() {
    final shipmentBloc = context.read<ShipmentBloc>();

    print(
        'here from load more shipments pages: ${shipmentBloc.totalPages} $currentPage');

    if (currentPage < shipmentBloc.totalPages) {
      setState(() {
        isLoadingMore = true;
        currentPage++;
      });
      shipmentBloc.add(FetchShipmentsEvent(
          companyId: 867,
          page: currentPage,
          fromDate: fromDate != null
              ? intl.DateFormat('yyyy-MM-dd', 'en').format(fromDate!)
              : null,
          toDate: toDate != null
              ? intl.DateFormat('yyyy-MM-dd', 'en').format(toDate!)
              : null));
      setState(() {
        isLoadingMore = false;
      });
    }
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      ),
      child: Column(
        children: [
          BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
              if (state is DashboardLoadedState) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildProgressIndicator(state.deliveredPercentage,
                        Colors.red, state.deliveredPercentage.toString()),
                    _buildProgressIndicator(state.canceledPercentage,
                        Colors.blue, state.canceledPercentage.toString()),
                    _buildProgressIndicator(state.delayedPercentage,
                        Colors.purple, state.delayedPercentage.toString()),
                  ],
                );
              }
              return Container();
            },
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, color: AppColors.mainColor),
                    ),
                    SizedBox(width: 10),
                    Text('rex.perfuma@gmail.com',
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.black, fontSize: 12)),
                  ],
                ),
              ),
              Expanded(
                child: Text(
                    '${AppLocalizations.of(context)!.the_day} : ${intl.DateFormat.EEEE(AppConstants.isArabic() ? 'ar' : 'en').format(DateTime.now())}\n ${intl.DateFormat('yyyy/MM/dd', 'en').format(DateTime.now())}',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 12)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(double percentage, Color color, String value) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
                width: 75,
                height: 75,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color, color.withOpacity(0.5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Text('$percentage%',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold))),
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                value: percentage / 100,
                color: Colors.white,
                backgroundColor: color,
                strokeWidth: 3,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            CircleAvatar(
              backgroundColor: color,
              radius: 3,
            ),
            SizedBox(width: 8),
            Text(value,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  Widget _buildOrderButtons(List<StatusListModel> statusList) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: statusList.map((status) => _buildButton(status)).toList(),
      ),
    );
  }

  Widget _buildButton(StatusListModel status) {
    final shipmentBloc = context.read<ShipmentBloc>();
    print('here status id: ${shipmentBloc.selectedStatus}');

    return GestureDetector(
      onTap: () {
        context.read<ShipmentBloc>().add(ChangeStatusEvent(
            statusId: status.id,
            companyId: 867,
            date: intl.DateFormat('yyyy-MM-dd', 'en').format(DateTime.now())));

        // currentPage = 1;

        // context.read<ShipmentBloc>().add(FetchShipmentsEvent(
        //     statusId: status.id,
        //     companyId: 867,
        //     page: currentPage,
        //     date: DateFormat('yyyy-MM-dd', 'en').format(DateTime.now())));
      },
      child: BlocBuilder<ShipmentBloc, DashboardState>(
        builder: (context, state) {
          // print("theme mode ${AppConstants.isDark(context)}");
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            margin: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: shipmentBloc.selectedStatus == status.id
                  ? AppColors.mainColor
                  : Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: shipmentBloc.selectedStatus == status.id
                      ? AppColors.mainColor
                      : Theme.of(context).iconTheme.color!),
            ),
            child: Text(AppConstants.isArabic() ? status.nameAr : status.nameEn,
                style: TextStyle(
                    color: shipmentBloc.selectedStatus == status.id
                        ? Colors.white
                        : Theme.of(context).iconTheme.color!)),
          );
        },
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, List<EmirateModel> emirateList) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        textDirection:
            AppConstants.isArabic() ? TextDirection.rtl : TextDirection.ltr,
        children: [
          Expanded(
            child: TextField(
              // readOnly: true,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.search_shipments,
                hintStyle: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium!.color),
                prefixIcon: SizedBox(
                  width: 40,
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      'assets/svg images/search_cardbox.svg',
                      width: 24.0,
                      height: 24.0,
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).iconTheme.color!, BlendMode.srcIn),
                    ),
                  ),
                ),
                filled: true,
                fillColor: Theme.of(context).scaffoldBackgroundColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: AppColors.mainColor),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 10),
              ),
              onSubmitted: (value) {
                currentPage = 1;

                context.read<ShipmentBloc>().add(SearchShipmentsEvent(
                    companyId: 867, search: value, page: currentPage));
              },
            ),
          ),
          SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              _showFilterBottomSheet(context, emirateList);
            },
            child: SvgPicture.asset(
              'assets/svg images/search_list.svg',
              colorFilter: ColorFilter.mode(
                  Theme.of(context).iconTheme.color!, BlendMode.srcIn),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet(
      BuildContext context, List<EmirateModel> emirateList) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context)!.filter_shipments,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              _buildDateFilter(context),
              SizedBox(height: 16),
              _buildEmirateFilter(context, emirateList),
              SizedBox(
                height: 20,
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      fromDate = null;
                      toDate = null;
                      selectedEmirates = [];
                      // selectedEmirates = List.generate(9, (index) => false);
                      context.read<ShipmentBloc>().add(FetchShipmentsEvent(
                            companyId: 867,
                            page: currentPage,
                            statusId:
                                context.read<ShipmentBloc>().selectedStatus,
                          ));
                      Navigator.pop(context);
                    },
                    child: Text(AppLocalizations.of(context)!.cancel),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ShipmentBloc>().add(FetchShipmentsEvent(
                            companyId: 867,
                            page: currentPage,
                            fromDate: fromDate != null
                                ? intl.DateFormat('yyyy-MM-dd', 'en')
                                    .format(fromDate!)
                                : null,
                            toDate: toDate != null
                                ? intl.DateFormat('yyyy-MM-dd', 'en')
                                    .format(toDate!)
                                : null,
                            statusId:
                                context.read<ShipmentBloc>().selectedStatus,
                            emirateId:
                                selectedEmirates, // TODO: check if this is correct put the correct emirate id and should be list
                          ));
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      // primary: AppColors.mainColor,
                      backgroundColor: AppColors.mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(AppLocalizations.of(context)!.save,
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDateFilter(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context)!.by_date,
            style: TextStyle(fontSize: 16)),
        SizedBox(height: 8),
        Row(
          children: [
            _buildDateField(
                context, AppLocalizations.of(context)!.from, fromDate, (date) {
              fromDate = date;
            }),
            SizedBox(width: 10),
            _buildDateField(context, AppLocalizations.of(context)!.to, toDate,
                (date) {
              toDate = date;
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildDateField(BuildContext context, String label, DateTime? date,
      Function(DateTime) onDateSelected) {
    return Expanded(
      child: GestureDetector(
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          );
          if (pickedDate != null) {
            onDateSelected(pickedDate);
            (context as Element).markNeedsBuild();
          }
        },
        child: Container(
          height: 38,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.mainColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 38,
                width: 40,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: !AppConstants.isArabic()
                      ? BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20))
                      : BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                ),
                child: Text(
                  label,
                  style: TextStyle(color: Theme.of(context).iconTheme.color!),
                ),
              ),
              Text(
                date != null
                    ? intl.DateFormat('dd / MM / yyyy').format(date)
                    : '__ / __ / ____',
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium!.color),
              ),
              SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmirateFilter(
      BuildContext context, List<EmirateModel> emirateList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context)!.by_emirate,
            style: TextStyle(fontSize: 16)),
        SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: emirateList.map((emirate) {
            // int index = emirateList.indexOf(emirate);
            return _buildEmirateButton(
                AppConstants.isArabic() ? emirate.nameAr : emirate.nameEn,
                emirate.id,
                context); //index
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildEmirateButton(String text, int id, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (selectedEmirates.contains(id)) {
          selectedEmirates.remove(id);
        } else {
          selectedEmirates.add(id);
        }
        // selectedEmirates[index] = !selectedEmirates[index];
        (context as Element).markNeedsBuild();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selectedEmirates.contains(id)
              ? AppColors.mainColor
              : Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: selectedEmirates.contains(id)
                  ? AppColors.mainColor
                  : Theme.of(context).iconTheme.color!),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selectedEmirates.contains(id)
                ? (context.read<ThemeBloc>().state.themeMode == ThemeMode.light
                    ? Colors.white
                    : Colors.black)
                : Theme.of(context).textTheme.bodyMedium!.color,
          ),
        ),
      ),
    );
  }

  Widget _buildOrderList(List<ShipmentModel> shipments) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            shrinkWrap: true,
            itemCount: shipments.length,
            itemBuilder: (context, index) {
              final shipment = shipments[index];
              return _buildOrderItem(
                shipmentId: shipment.id,
                referenceNumber: shipment.shipmentReference,
                permitNumber: shipment.customerPhone,
                emirate: AppConstants.isArabic()
                    ? shipment.emirateAr
                    : shipment
                        .emirateEn, // Replace with actual emirate if available
                // .emirateAr, // Replace with actual emirate if available
                amount: shipment.amount.toString(),
                status: AppConstants.isArabic()
                    ? shipment.statusNameAr
                    : shipment.statusNameEn,
                color: index % 2 == 0 ? Colors.white : Color(0xffF9F9F9),
                textColor: Colors.black,
              );
            },
          ),
          if (isLoadingMore) Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  Widget _buildOrderItem({
    required int shipmentId,
    required String referenceNumber,
    required String permitNumber,
    required String emirate,
    required String amount,
    required String status,
    required Color color,
    required Color textColor,
    double? radius,
    double? padding,
  }) {
    return GestureDetector(
      onTap: () {
        if (shipmentId == 0) {
          return;
        }
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrderDetailsScreen(
                      shipmentId: shipmentId,
                    )));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: padding ?? 0),
        height: 38,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius ?? 0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
                child: Text(referenceNumber,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: textColor))),
            Expanded(
                child: Text(permitNumber,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: textColor))),
            Expanded(
                child: Text(emirate,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: textColor))),
            Expanded(
                child: Text(amount,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: textColor))),
            Expanded(
                child: Text(status,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: textColor))),
          ],
        ),
      ),
    );
  }
}
