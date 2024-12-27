import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:camels_go/core/constants/app_constants.dart';
import 'package:camels_go/core/themes/app_colors.dart';
import 'package:camels_go/view/purchase_services/bloc/purchase_services_bloc.dart';
import 'package:camels_go/view/purchase_services/history_request_screen.dart';
import 'package:camels_go/view/purchase_services/model/service_model.dart';
import 'package:camels_go/view/shared/widgets/arrow_button.dart';
import 'package:camels_go/view/shared/widgets/title_backword_widget.dart';

class PurchaseServicesScreen extends StatefulWidget {
  @override
  State<PurchaseServicesScreen> createState() => _PurchaseServicesScreenState();
}

class _PurchaseServicesScreenState extends State<PurchaseServicesScreen> {
  ServiceModel? selectedService;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            children: [
              TitleBackwordWidget(
                title: AppLocalizations.of(context)!.purchase_services,
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: BlocProvider(
                  create: (context) =>
                      PurchaseServicesBloc()..add(FetchServicesEvent()),
                  child:
                      BlocBuilder<PurchaseServicesBloc, PurchaseServicesState>(
                    builder: (context, state) {
                      if (state is PurchaseServicesLoadingState) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is PurchaseServicesLoadedState) {
                        return _buildServiceList(context, state.services);
                      } else if (state is PurchaseServicesErrorState) {
                        return Center(child: Text(state.message));
                      } else {
                        return Center(child: Text('No services found'));
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HistoryRequestScreen()),
          );
        },
        backgroundColor: AppColors.mainColor,
        child: Icon(Icons.history),
      ),
    );
  }

  Widget _buildServiceList(BuildContext context, List<ServiceModel> services) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(16),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return _buildServiceCard(context, service);
      },
    );
  }

  Widget _buildServiceCard(BuildContext context, ServiceModel service) {
    return Container(
      height: 45,
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        boxShadow: selectedService == service
            ? [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // Shadow color
                  spreadRadius: 2, // Spread radius
                  blurRadius: 5, // Blur radius
                  offset: Offset(2, 3), // Changes position of shadow (x, y)
                ),
              ]
            : null,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(
            color: selectedService == service
                ? AppColors.mainColor
                : Colors.black),
        color: selectedService == service ? AppColors.mainColor : Colors.white,
      ),
      child: ListTile(
        title: Text(AppConstants.isArabic() ? service.nameAr : service.nameEn,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: selectedService == service
                    ? Colors.white
                    : Color(0xff414141))),
        trailing: ArrowButton(
            onPressed: () {},
            size: 15,
            iconColor: selectedService == service ? AppColors.mainColor : null,
            color:
                selectedService == service ? Colors.white : Color(0xff414141)),
        onTap: () {
          selectedService = service;
          setState(() {});
          _showRequestDialog(context, service);
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
        dense: true,
      ),
    );
  }

  void _showRequestDialog(BuildContext context, ServiceModel service) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(AppLocalizations.of(context)!.confirm_request),
          content: Text(
              '${AppLocalizations.of(context)!.doYouWantToMakeRequest} ${AppConstants.isArabic() ? service.nameAr : service.nameEn} ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                selectedService = null;
                setState(() {});
              },
              child: Text(AppLocalizations.of(context)!.cancel,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            GestureDetector(
              onTap: () {
                context.read<PurchaseServicesBloc>().add(MakeRequestEvent(
                      companyId: 867,
                      serviceId: service.id,
                    ));
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(AppLocalizations.of(context)!.confirm,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white)),
              ),
            ),
          ],
        );
      },
    );
  }
}
