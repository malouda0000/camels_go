import 'package:camels_go/core/constants/app_constants.dart';
import 'package:camels_go/core/themes/app_colors.dart';
import 'package:camels_go/view/shared/widgets/title_backword_widget.dart';
import 'package:camels_go/view/store/bloc/store_bloc.dart';
import 'package:camels_go/view/store/model/product_model.dart';
import 'package:camels_go/view/store/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StoreScreen extends StatefulWidget {
  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    context.read<StoreBloc>().add(FetchProductsEvent(companyId: 867));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.mainColor, // Change to your desired color
        statusBarIconBrightness:
            Brightness.dark, // Use Brightness.dark for dark icons
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: 10),
            TitleBackwordWidget(
              title: AppLocalizations.of(context)!.total_stock,
            ),
            Expanded(
              child: BlocBuilder<StoreBloc, StoreState>(
                builder: (context, state) {
                  if (state is StoreLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is StoreLoadedState) {
                    return _buildProductGrid(state.products);
                  } else if (state is StoreErrorState) {
                    return Center(child: Text(state.message));
                  } else {
                    return Center(child: Text('Error loading products'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
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
                    Text('ركس للعطور  \nrex.perfuma@gmail.com',
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.black, fontSize: 12)),
                  ],
                ),
              ),
              Expanded(child: Container()),
            ],
          ),
          _buildDateSelector(),
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    return BlocBuilder<StoreBloc, StoreState>(
      builder: (context, state) {
        if (state is StoreDayChangedState) {
          selectedDate = state.selectedDate;
        }

        List<DateTime> weekDays = List.generate(7, (index) {
          return selectedDate
              .subtract(Duration(days: selectedDate.weekday - 1 - index));
        });

        return Container(
          color: AppColors.mainColor,
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              SizedBox(height: 10),
              GestureDetector(
                onTap: () async {
                  // DateTime? pickedDate = await showDatePicker(
                  //   context: context,
                  //   initialDate: selectedDate,
                  //   firstDate: DateTime(2000),
                  //   lastDate: DateTime(2101),
                  // );
                  // if (pickedDate != null) {
                  //   context.read<StoreBloc>().add(ChangeDayEvent(pickedDate));
                  // }
                },
                child: Row(
                  children: [
                    SvgPicture.asset('assets/svg images/calender.svg'),
                    SizedBox(width: 10),
                    Text(
                      DateFormat('dd MMMM yyyy').format(selectedDate),
                      // DateFormat('dd MMMM yyyy', 'ar').format(selectedDate),
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              )
              /*   Row(
                children: [
                  ArrowButton(
                    onPressed: () {
                      setState(() {
                        selectedDate = selectedDate.subtract(Duration(days: 1));
                      });
                      context
                          .read<StoreBloc>()
                          .add(ChangeDayEvent(selectedDate));
                    },
                    color: Colors.white,
                    iconColor: AppColors.mainColor,
                    icon: Icons.arrow_back_ios_new,
                    size: 15,
                  ),
                  SizedBox(width: 10),
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
                            context
                                .read<StoreBloc>()
                                .add(ChangeDayEvent(selectedDate));
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 4),
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.mainColor,
                              // shape: BoxShape.circle,
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
                                  DateFormat.E('ar').format(date),
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.black
                                        : Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  date.day.toString(),
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.black
                                        : Colors.white,
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
                  SizedBox(width: 10),
                  ArrowButton(
                    onPressed: () {
                      setState(() {
                        selectedDate = selectedDate.add(Duration(days: 1));
                      });
                      context
                          .read<StoreBloc>()
                          .add(ChangeDayEvent(selectedDate));
                    },
                    color: Colors.white,
                    iconColor: AppColors.mainColor,
                    size: 15,
                  ),
                ],
              ),
           */
            ],
          ),
        );
      },
    );
  }

  Widget _buildProductGrid(List<ProductModel> products) {
    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetailsScreen(
                            product: product,
                          )));
            },
            child: _buildProductItem(product));
      },
    );
  }

  Widget _buildProductItem(ProductModel product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                child: Image.network(
                  product.imageUrl, // Replace with your image asset
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Center(
                      child: Icon(
                    Icons.hide_image_sharp,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  )),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context)!.product_name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors
                              .mainColor, // Replace with AppColors.mainColor
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        AppConstants.isArabic()
                            ? product.productNameAr
                            : product.productNameEn,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8), // Add spacing between rows
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context)!.remaining_quantity,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors
                              .mainColor, // Replace with AppColors.mainColor
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        product.quantity.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
