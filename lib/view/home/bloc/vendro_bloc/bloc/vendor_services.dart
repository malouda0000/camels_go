// lib/services/vendor_service.dart

import 'dart:convert';
import 'package:camels_go/core/helpers/dio_helper.dart';
import 'package:http/http.dart' as http;

class VendorService {
  final String baseUrl;

  VendorService(this.baseUrl);

  // Fetch vendor companies
  // Future<Map<String, dynamic>> getVendorCompanies(
  //     {int page = 1, int pageSize = 5}) async {
  //   // final response = await http.get(

  //   //   Uri.parse(
  //   //     '$baseUrl/get_vendor_companies?page=$page&page_size=$pageSize'));

  //   final response =
  //       await DioHelper.getVendorsCompanies(pageSize: pageSize, page: page);
  //   print("sssssssssssssssssssssssssssssssss${response.data}");
  //   if (response.statusCode == 200) {
  //     return json.decode(response.body);
  //   } else if (response.statusCode == 404) {
  //     throw Exception('No company found................');
  //   } else {
  //     throw Exception('Failed to fetch vendor companies.');
  //   }
  // }

  Future<Map<String, dynamic>> getVendorCompanies({
    int page = 1,
    int pageSize = 5,
  }) async {
    // Fetch response using DioHelper
    final response = await DioHelper.getVendorsCompanies(
      pageSize: pageSize,
      page: page,
    );

    // Print response to debug
    print('Response Data: ${response.data}');

    // Check status code and return parsed data
    if (response.statusCode == 200) {
      final data =
          response.data as Map<String, dynamic>; // Directly use response.data
      if ((data['data']['data'] as List).isEmpty) {
        throw Exception('No companies available.');
      }
      return data;
    } else if (response.statusCode == 404) {
      throw Exception('No company found.');
    } else {
      throw Exception('Failed to fetch vendor companies.');
    }
  }

  // Fetch specific company by ID
  Future<Map<String, dynamic>> getCurrentCompany(int companyId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/get_current_company/$companyId'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 404) {
      throw Exception('No company found.');
    } else {
      throw Exception('Failed to fetch company details.');
    }
  }
}
