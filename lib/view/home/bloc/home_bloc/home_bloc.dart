import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  int activePage = 1; 
  HomeBloc() : super(HomeInitialState())  {
    on<HomeEvent>((event, emit) async{
      // TODO: implement event handler




  // final VendorService vendorService;


// if(event is FetchVendorCompaniesEvent)
// {

//     // emit(HomeLoadingState());
//     try {
//       final response = await DioHelper.getVendorsCompanies(page: event.page, pageSize: event.pageSize);

//       final List<VendorCompaniesModel> companies = (response['data']['data'] as List)
//           .map((company) => VendorCompaniesModel.fromJson(company))
//           .toList();

//       final MetaDataModel metaData = MetaDataModel.fromJson(response['data']['meta']);

//       emit(VendorCompaniesLoaded(companies: companies, metaData: metaData));
//     } catch (e) {
//       emit(VendorError(e.toString()));
//     }
  

// }


// if (event is FetchVendorCompaniesEvent) {
//   try {
//     // Send the request to the API
//     final response = await DioHelper.getVendorsCompanies(
//       page: event.page,
//       pageSize: event.pageSize,
//     );

//     // Parse the response using the VendorCompaniesModel model
//     final VendorCompaniesModel vendorCompaniesResponse =
//         VendorCompaniesModel.fromJson(response);

//     // Extract companies list and metadata from the parsed response
//     final List<CompanyModel> companies = vendorCompaniesResponse.data.data;
//     final MetaDataModel metaData = vendorCompaniesResponse.data.meta;

//     // Emit the loaded state with the companies and metadata
//     emit(VendorCompaniesLoaded(companies: companies, metaData: metaData));
//   } catch (e) {
//     // Handle any errors and emit an error state
//     // emit(VendorError(e.toString()));
//   }
// }


  // Future<void> _onFetchCurrentCompany(FetchCurrentCompany event, Emitter<VendorState> emit) async {
  //   emit(VendorLoading());
  //   try {
  //     final response = await vendorService.getCurrentCompany(event.companyId);

  //     final VendorCompaniesModel company = VendorCompaniesModel.fromJson(response['data']);

  //     emit(VendorCompanysModelLoaded(company: company));
  //   } catch (e) {
  //     emit(VendorError(e.toString()));
  //   }
  // }







    });
  }
}
