import 'package:camels_go/main.dart';
import 'package:dio/dio.dart';
// import 'package:special_line_vendors/main.dart';
import 'package:intl/intl.dart';

class DioHelper {
  static const String baseUrl = "https://erp.specialline.info/v1/api/vendor";

  static const String logInUrl = '/login';
  static const String signUpUrl = '/register';
  static const String forgotPasswordUrl = '/forgot-password';
  static const String verifyOTPUrl = '/verify-otp';
  static const String resetPasswordUrl = '/reset-password';
  static const String getVendorsCompaniesUrl = '/get_vendor_companies';
  static const String getVendorsProfileUrl = '/profile';

// #### Atif code #### //

  static const String getShipmentSummaryUrl =
      "$baseUrl/company/get_shipment_summary/";

  static const String getStatusListUrl = "$baseUrl/company/get_status_list";

  static const String getEmirateListUrl = "$baseUrl/company/get_emirate_list";

  static const String getShipmentsUrl = "$baseUrl/company/get_shipments";

  static const String searchShipmentsUrl = "$baseUrl/company/search_shipments";

  static const String getShipmentDetailsUrl =
      "$baseUrl/company/get_shipment_details/";

  static const String getProductsUrl = "$baseUrl/company/stock/get_products/";

  static const String getProductHistoryUrl =
      "$baseUrl/company/stock/get_product/history/";

  static const String getPaymentsUrl =
      "$baseUrl/company/payments/get_payments/";

  static const String getServicesUrl = "$baseUrl/company/requests/get_services";
  static const String makeRequestUrl = "$baseUrl/company/requests/make_request";

  static const String getRequestsUrl =
      "$baseUrl/company/requests/get_requests/";

  static const String getShipmentTrackingUrl =
      "$baseUrl/company/get_shipment_tracking/";

  static Dio? _dio;

  // #### dio init #### //

  static init() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      validateStatus: (status) => true,
      connectTimeout: const Duration(seconds: 10),
      // headers: {}
      // dio.options.headers['Authorization'] = 'Bearer $userToken';
      // headers:  <String, dynamic> {   "Authorization" :  'Bearer $userToken' }
      // headers: <String, dynamic>{
      // "Authorization": 'Bearer $globalUserToken'

      // },
    ));

    _dio!.options.headers['Authorization'] =
        // 'Bearer 842|kfJ1xYx8xejTn9Oz9YNWRZUsx46l13v09X60PKhk29dc2055';
        'Bearer $globalCachedUserToken';
  }

  // #### login #### //
  static Future<Response> login(
      {required String email, required String password}) async {
    try {
      final response = await _dio!.post(
        logInUrl,
        data: {
          "email": email,
          "password": password,
          // "rememberMe": true
        },
      );

      // print('ressssssssssssssssssssssssssssspons: ${response}');

      // if (response.statusCode == 200) {
      //   // print('ressssssssssssssssssssssssssssspons: ${response}');
      // }
      return response;
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  // #### signUp #### //
  static Future<Response> signUp({
    required String arabicName,
    required String englishName,
    required String mobile,
    required String? email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response =
          // email != null && email != ""?
          await _dio!.post(
        // post with email
        signUpUrl,
        data: {
          "name_ar": arabicName,
          "name_en": englishName,
          "email": email,
          "mobile": mobile,
          "password": password,
          "password_confirmation": passwordConfirmation,
        },
      );
      // : await _dio!.post(
      //     // post without emial
      //     signUpUrl,
      //     data: {
      //       "name": name,
      //       "mobile": mobile,
      //       "password": password,
      //     },
      //   );

      // print('ressssssssssssssssssssssssssssspons: $response');

      if (response.statusCode == 200) {}
      return response;
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  // #### the olddddd get home categories #### //

  // static Future<Response> getCategories() async {
  //   try {
  //     final response = await _dio!.get(
  //       categoriesAllUrl,
  //       // options: Options()
  //     );
  //     return response;
  //   } catch (e) {
  //     throw Exception('Failed to login: $e');
  //   }
  // }

  // #### genral dio getData #### //
  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    // print(url);
    // _dio!.options.headers = {
    //'lang': lang,

    // #### //
    // 'Authorization': 'Bearer $token'

    // #### //

    // ?? CacheHelper.getData(key: "token"),
    //'Content-Type': 'application/json',
    // };
    _dio!.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    print(_dio!.options.headers);
    return await _dio!.get(
      url,
      queryParameters: query,
    );
  }

  // #### genral dio posData #### //
  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? queryParameters,
    required dynamic data,

    // String lang = "en",
    //String? token,
  }) async {
    _dio!.options.headers = {
      // #### //

      // 'Authorization': 'Bearer $token',
      // #### //

      //'Accept': 'application/json',
    };
    // print('url->$url\n data->$data');
    try {
      return await _dio!.post(
        url,
        queryParameters: queryParameters,
        data: data,
      );
    } catch (e) {
      print('err: $e');
      return Response(requestOptions: RequestOptions());
    }
  }

  //  // #### sendNotifications #### //
  // static Future<Response> sendNotificatoin({
  //   //required String url,
  //   //Map<String, dynamic>? queryParameters,
  //   required Map<String, dynamic> data,
  //   // String lang = "en",
  //   //String? token,
  // }) async {
  //   dio!.options.headers = {
  //     // 'lang': lang,
  //     'Content-Type': 'application/json',
  //     'Authorization':
  //         'key=${firebase key}',
  //   };
  //   print('data => $data');
  //   // print('url->$url\n data->$data');
  //   return await dio!.post(
  //     'https://fcm.googleapis.com/fcm/send',
  //     //queryParameters: queryParameters,
  //     data: data,
  //   );
  // }

  // #### genral dio putData #### //
  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? queryParameters,
    required dynamic data,
    String lang = "en",
    // String? token,
  }) async {
    _dio!.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',

      // #### //

      // 'Authorization': 'Bearer $token'

      // #### //
    };
    print('data $data');

    // #### //

    // print('token ${token}');

    // #### //

    return await _dio!.put(
      url,
      //queryParameters: queryParameters,
      data: data,
    );
  }

  // #### genral dio deleteData #### //
  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    String lang = "en",
    String? token,
  }) async {
    _dio!.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    return await _dio!.delete(
      url,
      //queryParameters: queryParameters,
      data: data,
    );
  }

  static Future<Response> getShipmentSummary(
      {required int companyId, String? date}) async {
    try {
      final response = await _dio!.get(
        '$getShipmentSummaryUrl$companyId',
        queryParameters: {
          if (date != null) 'date': date,
        },
      );
      return response;
    } catch (e) {
      throw Exception('Failed to get shipment summary: $e');
    }
  }

  static Future<Response> getStatusList() async {
    try {
      final response = await _dio!.get(getStatusListUrl);
      return response;
    } catch (e) {
      throw Exception('Failed to get status list: $e');
    }
  }

  static Future<Response> getEmirateList() async {
    try {
      final response = await _dio!.get(getEmirateListUrl);
      return response;
    } catch (e) {
      throw Exception('Failed to get emirate list: $e');
    }
  }

  static Future<Response> getShipments({
    required int companyId,
    int page = 1,
    int pageSize = 5,
    String? fromDate,
    String? toDate,
    int? statusId,
    List<int>? emirateId,
  }) async {
    try {
      final response = await _dio!.post(
        getShipmentsUrl,
        data: {
          "page": page,
          "page_size": pageSize,
          "from_date":
              fromDate ?? DateFormat('yyyy-MM-dd').format(DateTime.now()),
          "to_date": toDate ?? DateFormat('yyyy-MM-dd').format(DateTime.now()),
          "status_id": statusId,
          "emirate_id": emirateId,
          "company_id": companyId,
        },
      );
      return response;
    } catch (e) {
      throw Exception('Failed to get shipments: $e');
    }
  }

  static Future<Response> searchShipments({
    required int companyId,
    required String search,
    int page = 1,
    int pageSize = 5,
  }) async {
    try {
      final response = await _dio!.post(
        searchShipmentsUrl,
        data: {
          "page": page,
          "page_size": pageSize,
          "search": search,
          "company_id": companyId,
        },
      );
      return response;
    } catch (e) {
      throw Exception('Failed to search shipments: $e');
    }
  }

  static Future<Response> getShipmentDetails(int shipmentId) async {
    try {
      final response = await _dio!.get('$getShipmentDetailsUrl$shipmentId');
      return response;
    } catch (e) {
      throw Exception('Failed to get shipment details: $e');
    }
  }

  static Future<Response> getProducts(int companyId) async {
    try {
      final response = await _dio!.get('$getProductsUrl$companyId');
      return response;
    } catch (e) {
      throw Exception('Failed to get products: $e');
    }
  }

  static Future<Response> getProductHistory(int productId) async {
    try {
      final response = await _dio!.get('$getProductHistoryUrl$productId');
      return response;
    } catch (e) {
      throw Exception('Failed to get product history: $e');
    }
  }

  // static Future<Response> getPayments({
  //   required int companyId,
  //   int page = 1,
  //   int pageSize = 10,
  //   String? date,
  // }) async {
  //   try {
  //     final response = await _dio!.get(
  //       '$getPaymentsUrl$companyId',
  //       queryParameters: {
  //         "page": page,
  //         "page_size": pageSize,
  //         "date": date ??
  //             DateFormat('yyyy-MM-dd')
  //                 .format(DateTime.now().subtract(Duration(days: 2))),
  //       },
  //     );
  //       print("resssssssssssssssssssss $response ");

  //     return response;
  //   } catch (e) {
  //     throw Exception('Failed to get payments: $e');
  //   }
  // }

  static Future<Response> getPayments({
    int companyId = 867,
    int page = 1,
    int pageSize = 10,
    String? date,
  }) async {
    try {
      final response = await _dio!.get(
        'https://erp.specialline.info/v1/api/vendor/company/payments/get_payments/867',
        queryParameters: {
          "page": page,
          "page_size": pageSize,
          "date": date ??
              DateFormat('yyyy-MM-dd')
                  .format(DateTime.now().subtract(Duration(days: 2))),
        },
      );

      print("Response Status: ${response.statusCode}");
      print("Response Headers: ${response.headers}");
      print("Response Data: ${response.data}");

      return response;
    } catch (e) {
      throw Exception('Failed to get payments: $e');
    }
  }

  static Future<Response> getServices() async {
    try {
      final response = await _dio!.get(getServicesUrl);
      return response;
    } catch (e) {
      throw Exception('Failed to get services: $e');
    }
  }

  static Future<Response> makeRequest({
    required int companyId,
    required int serviceId,
  }) async {
    try {
      final response = await _dio!.post(
        makeRequestUrl,
        data: {
          "company_id": companyId,
          "service_id": serviceId,
        },
      );
      return response;
    } catch (e) {
      throw Exception('Failed to make request: $e');
    }
  }

  static Future<Response> getRequests({
    required int companyId,
    int page = 1,
    int pageSize = 10,
  }) async {
    try {
      final response = await _dio!.get(
        '$getRequestsUrl$companyId',
        queryParameters: {
          "page": page,
          "page_size": pageSize,
        },
      );
      return response;
    } catch (e) {
      throw Exception('Failed to get requests: $e');
    }
  }

  static Future<Response> getShipmentTracking(
      {int? shipmentId, required int companyId}) async {
    try {
      final response = await _dio!.post(
        getShipmentTrackingUrl,
        data: {
          "id": shipmentId,
          "company_id": companyId,
        },
      );
      return response;
    } catch (e) {
      throw Exception('Failed to get shipment tracking: $e');
    }
  }

  static Future<Response> getVendorsCompanies(
      {required int pageSize, required int page, String? date}) async {
    try {
      final response = await _dio!.get(
        // '$getVendorsCompaniesUrl?page=$pageSize&page_size=$pageSize',
        '$getVendorsCompaniesUrl?page=$page&page_size=$pageSize',
        // queryParameters: {
        //   if (date != null) 'date': date,
        // },
      );
      return response;
    } catch (e) {
      throw Exception('Failed to get shipment summary: $e');
    }
  }




  static Future<Response> getVendorPersonalProfile(
      ) async {
    try {
      final response = await _dio!.get(
        getVendorsProfileUrl,
      );
      return response;
    } catch (e) {
      throw Exception('Failed to get profile $e');
    }
  }
}

