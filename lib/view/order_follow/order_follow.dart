import 'package:camels_go/core/constants/app_constants.dart';
import 'package:camels_go/core/themes/app_colors.dart';
import 'package:camels_go/core/themes/bloc/theme_bloc.dart';
import 'package:camels_go/view/order_follow/bloc/order_follow_bloc.dart';
import 'package:camels_go/view/order_follow/model/shipment_tracking_model.dart';
import 'package:camels_go/view/order_follow/widget/dotted_line.dart';
import 'package:camels_go/view/shared/widgets/title_backword_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderFollowScreen extends StatefulWidget {
  final int? shipmentId;

  OrderFollowScreen({
    this.shipmentId,
  });

  @override
  State<OrderFollowScreen> createState() => _OrderFollowScreenState();
}

class _OrderFollowScreenState extends State<OrderFollowScreen> {
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TitleBackwordWidget(
                  title: AppLocalizations.of(context)!.trackOrder),
              SizedBox(height: 16),
              Expanded(
                  child: SingleChildScrollView(
                child: BlocProvider(
                  create: (context) => OrderFollowBloc()
                    ..add(FetchOrderFollowEvent(
                        shipmentId: widget.shipmentId, companyId: 867)),
                  child: BlocBuilder<OrderFollowBloc, OrderFollowState>(
                    builder: (context, state) {
                      if (state is OrderFollowLoadingState) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is OrderFollowLoadedState) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildCustomerDetailsCard(
                              customerDetails: state.shipmentTrackingResponse
                                  .shipment.customerDetails,
                              deliveryDate: state.shipmentTrackingResponse
                                  .shipment.shipmentDetails.deliveredDate,
                              orderDate: state.shipmentTrackingResponse.shipment
                                  .shipmentDetails.addedDate,
                              referenceCode: state.shipmentTrackingResponse
                                  .shipment.shipmentDetails.shipmentRefrence,
                            ),
                            SizedBox(height: 16),
                            _buildPaymentDetailsCard(
                              state.shipmentTrackingResponse.shipment
                                  .shipmentDetails,
                            ),
                            SizedBox(height: 16),
                            _buildOrderJourney(
                              tracking:
                                  state.shipmentTrackingResponse.trackings,
                              from: state.shipmentTrackingResponse.from,
                              to: state.shipmentTrackingResponse.to,
                            ),
                          ],
                        );
                      } else if (state is OrderFollowErrorState) {
                        return Center(child: Text(state.message));
                      } else {
                        return Center(
                            child: Text('Error loading shipment tracking'));
                      }
                    },
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomerDetailsCard({
    required CustomerDetails customerDetails,
    required String deliveryDate,
    required String orderDate,
    required String referenceCode,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black.withOpacity(0.2)),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.customer_details,
              style: TextStyle(
                color: AppColors.mainColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildDetailRow(customerDetails.customerName),
                      _buildDetailRow(customerDetails.customerPhone),
                      _buildDetailRow(customerDetails.customerEmirate),
                      _buildDetailRow(customerDetails.customerAddress)
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildDetailRow(
                          AppLocalizations.of(context)!.reference_number,
                          value: referenceCode),
                      _buildDetailRow(AppLocalizations.of(context)!.date_added,
                          value: orderDate),
                      _buildDetailRow(
                          AppLocalizations.of(context)!.delivery_date,
                          value: deliveryDate),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentDetailsCard(ShipmentDetails shipmentDetails) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.black.withOpacity(0.2)),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.payment_details,
              style: TextStyle(
                color: AppColors.mainColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      _buildDetailRow(
                          AppLocalizations.of(context)!.delivery_fees,
                          value:
                              shipmentDetails.deliveryFees.toStringAsFixed(2)),
                      _buildDetailRow(
                          AppLocalizations.of(context)!.shipment_amount,
                          value: shipmentDetails.shipmentAmount
                              .toStringAsFixed(2)),
                    ],
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Column(
                    children: [
                      _buildDetailRow(
                          AppLocalizations.of(context)!.additional_fees,
                          value: shipmentDetails.deliveryExtraFees
                              .toStringAsFixed(2)),
                      // _buildDetailRow('مدفوعة / غير مدفوعة', value: 'لا'),
                      _buildDetailRow(
                          AppLocalizations.of(context)!.bearing_delivery_fees,
                          value: shipmentDetails.feesTypeId),
                    ],
                  ),
                ),
              ],
            ),
            _buildDetailRow(AppLocalizations.of(context)!.payment_method,
                value: shipmentDetails.paymentMethod),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, {String? value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          value == null
              ? Expanded(
                  child: Text('$label ',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                )
              : Text('$label :',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: Colors.black)),
          if (value != null)
            Expanded(
              child: Text(value,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: Colors.black)),
            ),
        ],
      ),
    );
  }

  Widget _buildOrderJourney({
    required List<Tracking> tracking,
    required Address from,
    required Address to,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context)!.orderStage,
            style: TextStyle(
                color: AppColors.mainColor,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        SizedBox(height: 16),
        _buildJourneyStep(
            AppLocalizations.of(context)!.from,
            AppConstants.isArabic() ? from.ar.address : from.en.address,
            AppConstants.isArabic() ? from.ar.name : from.en.name,
            true),
        _buildJourneyStep(
            AppLocalizations.of(context)!.to,
            AppConstants.isArabic() ? to.ar.address : to.en.address,
            AppConstants.isArabic() ? to.ar.name : to.en.name,
            false),
        SizedBox(height: 16),
        // _buildStepper(),
        _buildTimeline(tracking: tracking),
      ],
    );
  }

  Widget _buildJourneyStep(
      String label, String address, String companyName, bool isStart) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(Icons.radio_button_checked, // : Icons.radio_button_unchecked,
                color: isStart
                    ? AppColors.mainColor
                    : (context.read<ThemeBloc>().state.themeMode ==
                            ThemeMode.light
                        ? Color(0xff414141)
                        : Colors.white)),
            if (isStart)
              VerticalDottedLine(height: 40, color: AppColors.mainColor),
            // Container(height: 40, width: 2, color: AppColors.mainColor),
          ],
        ),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$label\n$address', style: TextStyle(fontSize: 12)),
              Text(companyName,
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }

/*
  Widget _buildStepper() {
    return Stepper(
      physics: NeverScrollableScrollPhysics(),
      steps: [
        _buildStep('11.8.2024', '08:44', 'قيد الموافقة',
            'تم انشاء الشحنة من قبل التاجر ولم يتم الموافقة عليها بعد.'),
        _buildStep('11.8.2024', '08:44', 'جديد',
            'الشحنة موجودة في مستودعات سبيشل لاين.'),
        _buildStep('11.8.2024', '08:44', 'قيد التسليم',
            'الشحنة موجودة مع مناديب سبيشل لاين.'),
        _buildStep('11.8.2024', '08:44', 'تم التسليم',
            'تم تسليم الشحنة للعميل النهائي.'),
      ],
      currentStep: 2,
      controlsBuilder: (BuildContext context, ControlsDetails details) {
        return Container();
      },
    );
  }

  Step _buildStep(String date, String time, String title, String subtitle) {
    return Step(
      title: Text('$date\n$time',
          style: TextStyle(fontSize: 12, color: Colors.grey)),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.mainColor)),
          Text(subtitle, style: TextStyle(fontSize: 12)),
        ],
      ),
      isActive: true,
    );
  }
*/
  List<String> status = ['قيد الموافقة', 'جديد', 'قيد التسليم', 'تم التسليم'];

  Widget _buildTimeline({
    required List<Tracking> tracking,
  }) {
    return Column(
      children: [
        for (var i = 0; i < tracking.length; i++)
          _buildTimelineStep(
              formatDateTime(tracking[i].time).substring(0, 10),
              formatDateTime(tracking[i].time).substring(11, 18),
              // status[i],
              AppConstants.isArabic() ? tracking[i].nameAr : tracking[i].nameEn,
              true,
              isLast: i == tracking.length - 1),

        // _buildTimelineStep('11.8.2024', '08:44', 'قيد الموافقة',
        //     'تم انشاء الشحنة من قبل التاجر ولم يتم الموافقة عليها بعد.', true),
        // _buildTimelineStep('11.8.2024', '08:44', 'جديد',
        //     'الشحنة موجودة في مستودعات سبيشل لاين.', true),
        // _buildTimelineStep('11.8.2024', '08:44', 'قيد التسليم',
        //     'الشحنة موجودة مع مناديب سبيشل لاين.', true),
        // _buildTimelineStep('11.8.2024', '08:44', 'تم التسليم',
        //     'تم تسليم الشحنة للعميل النهائي.', false,
        //     isLast: true),
      ],
    );
  }

  Widget _buildTimelineStep(
      String date,
      String time, //String status,
      String description,
      bool isActive,
      {bool isLast = false}) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(description,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isActive
                            ? AppColors.mainColor
                            : Theme.of(context).textTheme.bodyMedium!.color)),
                // Text(description, style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              children: [
                Icon(Icons.circle,
                    color: isActive ? AppColors.mainColor : Colors.grey),
                if (!isLast)
                  Expanded(
                    child: Container(
                        constraints: BoxConstraints(
                          minHeight: 40, // Minimum height
                          maxHeight: double.infinity, // Allow it to stretch
                        ),
                        // height: 40,
                        width: 2,
                        color: isActive ? AppColors.mainColor : Colors.grey),
                  ),
              ],
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(date, style: TextStyle(fontSize: 12, color: Colors.grey)),
                Text(time,
                    style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).textTheme.bodyMedium!.color)),

                // SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String formatDateTime(String dateTimeString,
      {String dateFormat = 'yyyy-MM-dd', String timeFormat = 'HH:mm:ss'}) {
    try {
      // Parse the string to a DateTime object
      DateTime dateTime = DateTime.parse(dateTimeString);

      // Format the date and time separately
      String formattedDate = DateFormat(dateFormat).format(dateTime);
      String formattedTime = DateFormat(timeFormat).format(dateTime);

      return '$formattedDate $formattedTime'; // Combine date and time as needed
    } catch (e) {
      return 'Invalid date-time string';
    }
  }
}
