import 'package:camels_go/core/constants/app_constants.dart';
import 'package:camels_go/core/themes/app_colors.dart';
import 'package:camels_go/view/shared/widgets/title_backword_widget.dart';
import 'package:camels_go/view/store/model/product_model.dart';
import 'package:camels_go/view/store/product_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel product;
  ProductDetailsScreen({required this.product});
  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool isImageError = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Makes the status bar transparent
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    widget.product.imageUrl,
                  ),
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) {
                    setState(() {
                      isImageError = true;
                    });
                    print(exception);
                    print(isImageError);
                  },
                ),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16))),
            height: 469,
            width: double.infinity,
            child: isImageError
                ? Center(
                    child: Icon(
                      Icons.hide_image_sharp,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  )
                : null,
          ),
          SizedBox(height: 16),
          TitleBackwordWidget(
              title: ' AppLocalizations.of(context)!.brandDetails'),
          _buildDetailRow(
              AppConstants.isArabic()
                  ? widget.product.productNameAr
                  : widget.product.productNameEn,
              isTitle: true),

          // _buildDetailRow('نوع التخزين', value: 'غير مبرد'),
          _buildDetailRow(AppLocalizations.of(context)!.remaining_quantity,
              value: widget.product.quantity.toString()),
          // _buildDetailRow('تاريخ تخزين كمية المنتج', value: '2024 / 5 / 14'),
          // _buildDetailRow('تاريخ انتهاء صلاحية المنتج', value: 'غير محدد'),
          SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductHistoryScreen(
                          productId: widget.product.productId,
                        )),
              );
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              height: 34,
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                textDirection: AppConstants.isArabic()
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                children: [
                  SvgPicture.asset(
                    'assets/svg images/history.svg',
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).scaffoldBackgroundColor,
                        BlendMode.srcIn),
                  ),
                  SizedBox(width: 8),
                  Text(AppLocalizations.of(context)!.product_sales_record,
                      style: TextStyle(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          fontSize: 14)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, {String? value, bool isTitle = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Text(
            isTitle ? label : '$label :',
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontSize: isTitle ? 24 : 16,
              fontWeight: isTitle ? FontWeight.bold : FontWeight.normal,
              color: isTitle
                  ? AppColors.mainColor
                  : (Theme.of(context).iconTheme.color),
            ),
          ),
          if (value != null)
            Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
        ],
      ),
    );
  }
}
