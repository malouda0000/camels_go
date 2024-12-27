import 'package:camels_go/core/constants/app_constants.dart';
import 'package:camels_go/view/payments/model/payment_model.dart';
import 'package:camels_go/view/shared/widgets/title_backword_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaymentDetailsScreen extends StatelessWidget {
  final PaymentModel payment;

  PaymentDetailsScreen({required this.payment});

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleBackwordWidget(
                  title: AppLocalizations.of(context)!.payment_details),
              SizedBox(
                height: 20,
              ),
              Text(
                AppLocalizations.of(context)!.customer_details,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              _buildDetailRow(AppLocalizations.of(context)!.customer_name,
                  payment.clientName),
              _buildDetailRow(
                  AppLocalizations.of(context)!.phone_number, payment.mobile),
              _buildDetailRow(
                  AppLocalizations.of(context)!.emirate,
                  AppConstants.isArabic()
                      ? payment.addressAr
                      : payment.addressEn),
              _buildDetailRow(
                  AppLocalizations.of(context)!.customer_address,
                  AppConstants.isArabic()
                      ? payment.addressAr
                      : payment.addressEn),
              SizedBox(height: 18),
              Text(
                AppLocalizations.of(context)!.payment_details,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              _buildDetailRow(AppLocalizations.of(context)!.reference_number,
                  payment.shipmentReferenceCode),
              _buildDetailRow(
                  AppLocalizations.of(context)!.date, payment.date),
              _buildDetailRow(AppLocalizations.of(context)!.delivery_fees,
                  payment.deliveryFees.toString()),
              _buildDetailRow(AppLocalizations.of(context)!.shipment_amount,
                  payment.shipmentAmount.toString()),
              _buildDetailRow(
                  AppLocalizations.of(context)!.payment_method,
                  AppConstants.isArabic()
                      ? payment.paymentTypeAr
                      : payment.paymentTypeEn),
              _buildDetailRow(
                  AppLocalizations.of(context)!.amount_due_to_merchant,
                  payment.dueAmount.toString()),
              _buildDetailRow(
                  AppLocalizations.of(context)!.paid,
                  AppConstants.isArabic()
                      ? payment.paidOrNotPaidAr
                      : payment.paidOrNotPaidEn),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text('$label :',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(value, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
