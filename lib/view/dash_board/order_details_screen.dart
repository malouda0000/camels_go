import 'package:camels_go/core/themes/app_colors.dart';
import 'package:camels_go/view/dash_board/bloc/shipment_details_bloc.dart';
import 'package:camels_go/view/dash_board/model/shipment_details_model.dart';
import 'package:camels_go/view/order_follow/order_follow.dart';
import 'package:camels_go/view/shared/widgets/title_backword_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetailsScreen extends StatefulWidget {
  final int shipmentId;

  OrderDetailsScreen({required this.shipmentId});

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  bool isShipmentDetailsExpanded = false;
  bool isClientDetailsExpanded = false;
  bool showTable = true;

  @override
  void initState() {
    print("here shipment details init state ${widget.shipmentId}");

    super.initState();
    context
        .read<ShipmentDetailsBloc>()
        .add(FetchShipmentDetailsEvent(shipmentId: widget.shipmentId));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white, // Change to your desired color
        statusBarIconBrightness:
            Brightness.dark, // Use Brightness.dark for dark icons
      ),
    );

    return Scaffold(
      body: BlocBuilder<ShipmentDetailsBloc, ShipmentDetailsState>(
        builder: (context, state) {
          print("here shipment details state ${state}");
          if (state is ShipmentDetailsLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ShipmentDetailsLoadedState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleBackwordWidget(title: 'تفاصيل الشحنة'),
                      SizedBox(height: 16),
                      _buildDetailBox(shipmentDetails: state.shipmentDetails),
                      SizedBox(height: 16),
                      _buildExpandableButton(
                        'تفاصيل الشحنة',
                        isShipmentDetailsExpanded,
                        () {
                          setState(() {
                            isShipmentDetailsExpanded =
                                !isShipmentDetailsExpanded;
                          });
                        },
                        true,
                        shipmentDetails: state.shipmentDetails,
                      ),
                      SizedBox(height: 8),
                      _buildExpandableButton(
                        'تفاصيل العميل',
                        isClientDetailsExpanded,
                        () {
                          setState(() {
                            isClientDetailsExpanded = !isClientDetailsExpanded;
                          });
                        },
                        false,
                        customerDetails: state.customerDetails,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      OrderFollowScreen(shipmentId: widget.shipmentId)));
        },
        child: Icon(Icons.track_changes),
      ),
    );
  }

  Widget _buildDetailBox({required ShipmentDetailsModel shipmentDetails}) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow('الكود المرجعي', shipmentDetails.shipmentReference),
          _buildDetailRow('تاريخ الاضافة', shipmentDetails.addedDate),
          _buildDetailRow('تاريخ التسليم', shipmentDetails.deliveredDate),
        ],
      ),
    );
  }

  Widget _buildExpandableButton(
      String text, bool isExpanded, VoidCallback onTap, bool isShipment,
      {ShipmentDetailsModel? shipmentDetails,
      CustomerDetailsModel? customerDetails}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    color: isExpanded ? AppColors.mainColor : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: isShipment ? 16 : 14,
                  ),
                ),
                Container(
                  width: 23,
                  height: 23,
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                      isExpanded ? Icons.expand_less : Icons.expand_more,
                      color: Colors.white,
                      size: 15),
                ),
              ],
            ),
            if (isShipmentDetailsExpanded && isShipment)
              shipmentDetails!.hasStock == 1
                  ? _buildShipmentTable(shipmentDetails: shipmentDetails)
                  : _buildShipmentDetails(shipmentDetails: shipmentDetails),
            if (isClientDetailsExpanded && !isShipment)
              _buildClientDetails(customerDetails: customerDetails!),
          ],
        ),
      ),
    );
  }

  Widget _buildShipmentDetails(
      {required ShipmentDetailsModel shipmentDetails}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow('الشركة', shipmentDetails.companyNameAr),
        _buildDetailRow('مبلغ الشحنة', '${shipmentDetails.shipmentAmount} د.أ'),
        _buildDetailRow('رسوم التوصيل', '${shipmentDetails.deliveryFees} د.أ'),
        _buildDetailRow(
            'رسوم إضافية', '${shipmentDetails.deliveryExtraFees} د.أ'),
        _buildDetailRow('طريقة الدفع', shipmentDetails.paymentMethod),
        _buildDetailRow('تحمل رسوم التوصيل', shipmentDetails.feesTypeId),
        _buildDetailRow(
            'محتويات الشحنة', shipmentDetails.shipmentContentString ?? '--'),
      ],
    );
  }

  Widget _buildShipmentTable({required ShipmentDetailsModel shipmentDetails}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow('الشركة', shipmentDetails.companyNameAr),
        _buildDetailRow('مبلغ الشحنة', '${shipmentDetails.shipmentAmount} د.أ'),
        _buildDetailRow('رسوم التوصيل', '${shipmentDetails.deliveryFees} د.أ'),
        _buildDetailRow(
            'رسوم إضافية', '${shipmentDetails.deliveryExtraFees} د.أ'),
        _buildDetailRow('طريقة الدفع', shipmentDetails.paymentMethod),
        _buildDetailRow('تحمل رسوم التوصيل', shipmentDetails.feesTypeId),
        Text('محتويات الشحنة:', style: TextStyle(fontSize: 16)),
        SizedBox(height: 8),
        Table(
          border: TableBorder.all(color: AppColors.mainColor),
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.grey[800]),
              children: [
                _buildTableCell('#', isHeader: true),
                _buildTableCell('اسم المنتج', isHeader: true),
                _buildTableCell('العدد', isHeader: true),
              ],
            ),
            for (int i = 0; i < shipmentDetails.shipmentContent!.length; i++)
              _buildTableRow(
                '${i + 1}',
                shipmentDetails.shipmentContent![i].product.nameAR,
                '${shipmentDetails.shipmentContent![i].quantity}',
              ),
          ],
        ),
      ],
    );
  }

  TableRow _buildTableRow(String number, String productName, String quantity) {
    return TableRow(
      children: [
        _buildTableCell(number),
        _buildTableCell(productName),
        _buildTableCell(quantity),
      ],
    );
  }

  Widget _buildTableCell(String text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
          color: isHeader ? Colors.white : Colors.black,
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildClientDetails({required CustomerDetailsModel customerDetails}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow('اسم العميل', customerDetails.customerName),
        _buildDetailRow('رقم العميل', customerDetails.customerPhone),
        _buildDetailRow('عنوان العميل', customerDetails.customerAddress),
        _buildDetailRow('الامارة', customerDetails.customerEmirate),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$label :', style: TextStyle(fontSize: 16)),
          Text(value, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
