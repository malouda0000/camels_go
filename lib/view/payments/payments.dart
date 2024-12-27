import 'package:camels_go/core/constants/app_constants.dart';
import 'package:camels_go/core/themes/app_colors.dart';
import 'package:camels_go/view/payments/bloc/payments_bloc.dart';
import 'package:camels_go/view/payments/model/payment_model.dart';
import 'package:camels_go/view/payments/payment_details_screen.dart';
import 'package:camels_go/view/shared/widgets/arrow_button.dart';
import 'package:camels_go/view/shared/widgets/title_backword_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';\
import 'package:url_launcher/url_launcher.dart';

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  DateTime selectedDate = DateTime.now().subtract(Duration(days: 2));
  int currentPage = 1;
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    context.read<PaymentsBloc>().add(FetchPaymentsEvent(
          companyId: 867,
          date: DateFormat('yyyy-MM-dd', 'en').format(selectedDate),
        ));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.mainColor,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: 10),
            TitleBackwordWidget(
                title: AppLocalizations.of(context)!.total_amount),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.centerRight,
              child: Text(
                AppLocalizations.of(context)!.payment_record,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            _buildDateSelector(),
            Expanded(child: _buildPaymentList()),
            _buildCallButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.only(top: 20),
      height: 180,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
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
                            child:
                                Icon(Icons.person, color: AppColors.mainColor),
                          ),
                          SizedBox(width: 10),
                          Text('ركس للعطور  \nrex.perfuma@gmail.com',
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12)),
                        ],
                      ),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(AppLocalizations.of(context)!.total_amount,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: BlocBuilder<PaymentsBloc, PaymentsState>(
                    builder: (context, state) {
                      if (state is PaymentsLoadedState) {
                        return Text('${state.totalDueAmount} AED',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold));
                      }
                      return Text('.... AED',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold));
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: Container()),
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xffDAB500),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
            child: Text(
              AppLocalizations.of(context)!.amounts_delivered_within_72_hours,
              style: TextStyle(color: Colors.white, fontSize: 11),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    return BlocBuilder<PaymentsBloc, PaymentsState>(
      builder: (context, state) {
        if (state is PaymentsDayChangedState) {
          selectedDate = state.selectedDate;
        }

        List<DateTime> weekDays = List.generate(7, (index) {
          return selectedDate
              .subtract(Duration(days: selectedDate.weekday - 1 - index));
        });

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              SizedBox(height: 10),
              GestureDetector(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now().subtract(Duration(days: 2)),
                  );
                  if (pickedDate != null) {
                    currentPage = 1;
                    context
                        .read<PaymentsBloc>()
                        .add(PaymentsDayChangedEvent(selectedDate: pickedDate));
                    context.read<PaymentsBloc>().add(FetchPaymentsEvent(
                          companyId: 867,
                          date:
                              DateFormat('yyyy-MM-dd', 'ar').format(pickedDate),
                        ));
                  }
                },
                child: Row(
                  children: [
                    SvgPicture.asset('assets/svg images/calender.svg',
                        colorFilter: ColorFilter.mode(
                            AppColors.mainColor, BlendMode.srcIn)),
                    SizedBox(width: 10),
                    Text(
                      DateFormat('dd MMMM yyyy', 'en').format(selectedDate),
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium!.color,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  ArrowButton(
                    onPressed: () {
                      setState(() {
                        selectedDate = selectedDate.subtract(Duration(days: 1));
                      });
                      currentPage = 1;
                      context.read<PaymentsBloc>().add(
                          PaymentsDayChangedEvent(selectedDate: selectedDate));
                      context.read<PaymentsBloc>().add(FetchPaymentsEvent(
                            companyId: 867,
                            date: DateFormat('yyyy-MM-dd', 'en')
                                .format(selectedDate),
                          ));
                    },
                    color: AppColors.mainColor,
                    iconColor: Theme.of(context).scaffoldBackgroundColor,
                    icon: Icons.arrow_back_ios_new,
                    size: 15,
                  ),
                  // SizedBox(width: 10),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: weekDays.map((date) {
                        bool isSelected = date.day == selectedDate.day;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedDate = date;
                            });
                            currentPage = 1;

                            context.read<PaymentsBloc>().add(
                                PaymentsDayChangedEvent(
                                    selectedDate: selectedDate));
                            context.read<PaymentsBloc>().add(FetchPaymentsEvent(
                                  companyId: 867,
                                  date: DateFormat('yyyy-MM-dd', 'en')
                                      .format(selectedDate),
                                ));
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 4),
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.mainColor
                                  : Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                          color: Colors.black26, blurRadius: 4)
                                    ]
                                  : [],
                            ),
                            child: Column(
                              children: [
                                Text(
                                  DateFormat.E(
                                          AppConstants.isArabic() ? 'ar' : 'en')
                                      .format(date),
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .color,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  date.day.toString(),
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .color,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  // SizedBox(width: 10),
                  ArrowButton(
                    onPressed: () {
                      // if (selectedDate.add(Duration(days: 1)).isAfter(
                      //     DateTime.now().subtract(Duration(days: 2)))) {
                      //   print('after two days before now ');
                      //   return;
                      // }
                      setState(() {
                        selectedDate = selectedDate.add(Duration(days: 1));
                      });
                      currentPage = 1;

                      context.read<PaymentsBloc>().add(
                          PaymentsDayChangedEvent(selectedDate: selectedDate));
                      context.read<PaymentsBloc>().add(FetchPaymentsEvent(
                            companyId: 867,
                            date: DateFormat('yyyy-MM-dd', 'en')
                                .format(selectedDate),
                          ));
                    },
                    color: AppColors.mainColor,
                    iconColor: Theme.of(context).scaffoldBackgroundColor,
                    size: 15,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPaymentList() {
    return BlocBuilder<PaymentsBloc, PaymentsState>(
      builder: (context, state) {
        if (state is PaymentsLoadingState) {
          //&& currentPage == 1
          return Center(child: CircularProgressIndicator());
        } else if (state is PaymentsLoadedState) {
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
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: state.payments.length,
              itemBuilder: (context, index) {
                final payment = state.payments[index];
                return _buildPaymentCard(payment);
              },
            ),
          );
        } else if (state is PaymentsErrorState) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text('No payments found'));
        }
      },
    );
  }

  void _loadMore() {
    final paymentsBloc = context.read<PaymentsBloc>();

    if (currentPage < paymentsBloc.totalPages) {
      setState(() {
        isLoadingMore = true;
        currentPage++;
      });
      paymentsBloc.add(FetchPaymentsEvent(
        companyId: 867,
        page: currentPage,
        date: DateFormat('yyyy-MM-dd', 'en').format(selectedDate),
      ));
      setState(() {
        isLoadingMore = false;
      });
    }
  }

  Widget _buildPaymentCard(PaymentModel payment) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PaymentDetailsScreen(
                      payment: payment,
                    )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Column(
                children: [
                  _buildDetail(
                    AppLocalizations.of(context)!.customer_details,
                  ),
                  _buildDetail(payment.clientName, notBold: true),
                  _buildDetail(payment.mobile, notBold: true),
                  _buildDetail(
                      AppConstants.isArabic()
                          ? payment.addressAr
                          : payment.addressEn,
                      maxLine: 2,
                      notBold: true),
                ],
              )),
              Expanded(
                  child: Column(
                children: [
                  _buildDetail(AppLocalizations.of(context)!.reference_number,
                      value: payment.shipmentReferenceCode),
                  _buildDetail(AppLocalizations.of(context)!.date,
                      value: payment.date),
                  _buildDetail(AppLocalizations.of(context)!.delivery_fees,
                      value: payment.deliveryFees.toString()),
                  _buildDetail(AppLocalizations.of(context)!.shipment_amount,
                      value: payment.shipmentAmount.toString()),
                ],
              )),
              SizedBox(
                width: 10,
              ),
              ArrowButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentDetailsScreen(
                                  payment: payment,
                                )));
                  },
                  color: AppColors.mainColor,
                  iconColor: Colors.white,
                  icon: Icons.arrow_back_ios_new,
                  size: 15)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetail(String label,
      {String? value, int? maxLine, bool notBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text("$label ${value != null ? ':' : ''}",
              maxLines: maxLine ?? 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: notBold ? null : FontWeight.bold)),
        ),
        Text(value ?? '',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 14, color: Colors.black)),
      ],
    );
  }

  Widget _buildCallButton() {
    return GestureDetector(
      onTap: () async {
        const phoneNumber = 'tel:066353753';
        if (await canLaunch(phoneNumber)) {
          await launch(phoneNumber);
        } else {
          throw 'Could not launch $phoneNumber';
        }
      },
      child: Container(
        margin: EdgeInsets.only(right: 16, left: 16, top: 5, bottom: 20),
        height: 78,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppColors.mainColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                  AppLocalizations.of(context)!.contact_accounting_department,
                  style: TextStyle(color: Colors.black, fontSize: 16)),
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                shape: BoxShape.circle,
              ),
              width: 50,
              height: 50,
              padding: EdgeInsets.all(12.5),
              child: SvgPicture.asset('assets/svg images/phone.svg',
                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn)),
            ),
          ],
        ),
      ),
    );
  }
}
