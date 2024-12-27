import 'package:camels_go/core/constants/app_constants.dart';
import 'package:camels_go/core/themes/app_colors.dart';
import 'package:camels_go/view/purchase_services/bloc/purchase_services_bloc.dart';
import 'package:camels_go/view/purchase_services/model/request_model.dart';
import 'package:camels_go/view/shared/widgets/title_backword_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryRequestScreen extends StatefulWidget {
  @override
  _HistoryRequestScreenState createState() => _HistoryRequestScreenState();
}

class _HistoryRequestScreenState extends State<HistoryRequestScreen> {
  int currentPage = 1;
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    context
        .read<PurchaseServicesBloc>()
        .add(FetchRequestsEvent(companyId: 867));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TitleBackwordWidget(
                  title: AppLocalizations.of(context)!.order_record),
              Expanded(
                child: BlocBuilder<PurchaseServicesBloc, PurchaseServicesState>(
                  builder: (context, state) {
                    if (state is PurchaseServicesLoadingState &&
                        currentPage == 1) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is RequestsLoadedState) {
                      return NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          if (!isLoadingMore &&
                              scrollInfo.metrics.pixels ==
                                  scrollInfo.metrics.maxScrollExtent) {
                            _loadMoreRequests();
                            return true;
                          }
                          return false;
                        },
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(16),
                          itemCount: state.requests.length,
                          itemBuilder: (context, index) {
                            final request = state.requests[index];
                            return _buildRequestCard(request);
                          },
                        ),
                      );
                    } else if (state is PurchaseServicesErrorState) {
                      return Center(child: Text(state.message));
                    } else {
                      return Center(
                          child: Text(
                              AppLocalizations.of(context)!.noDataLikeThis));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _loadMoreRequests() {
    final purchaseServicesBloc = context.read<PurchaseServicesBloc>();

    if (currentPage < purchaseServicesBloc.totalPages) {
      setState(() {
        isLoadingMore = true;
        currentPage++;
      });
      purchaseServicesBloc.add(FetchRequestsEvent(
        companyId: 867,
        page: currentPage,
      ));
      setState(() {
        isLoadingMore = false;
      });
    }
  }

  Widget _buildRequestCard(RequestModel request) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: AppColors.mainColor),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color
            spreadRadius: 2, // Spread radius
            blurRadius: 5, // Blur radius
            offset: Offset(2, 3), // Changes position of shadow (x, y)
          ),
        ],
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 30,
              width: 90,
              padding: EdgeInsets.symmetric(horizontal: 6),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5)),
                color: AppColors.mainColor,
              ),
              child: Text(request.requestNumber,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
          ),
          _buildRequestDetails(
            // AppLocalizations.of(context)!.service,
              "service",
              AppConstants.isArabic() ? request.serviceAr : request.serviceEn),
          _buildRequestDetails(
              AppLocalizations.of(context)!.stats, request.status),
          _buildRequestDetails(
              AppLocalizations.of(context)!.note, request.notes ?? '--'),
          Container(
            margin: EdgeInsets.all(5),
            alignment: Alignment.centerLeft,
            child: Text(request.createdAt.substring(0, 10),
                style: TextStyle(fontSize: 12, color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestDetails(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text('$title: ',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.mainColor)),
          Text(value, style: TextStyle(fontSize: 14, color: Colors.black)),
        ],
      ),
    );
  }
}
