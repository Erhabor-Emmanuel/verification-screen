import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../models/verification_model.dart';
import 'package:verification/repository/remote_data/api_constants.dart';
import 'dart:async';
import 'dart:io';

class VerificationRepo extends ChangeNotifier{
  final int _timeout = 60;
  //Setters
  bool _isLoading = false;
  String _resMessage = '';
  int _resStatusCode = 0;

  //Getters
  int get resStatusCode => _resStatusCode;
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  Future<VerifyModel> verifyUsers ({
    required String name,
    required String email,
    required String phone,
    required String landlord_email,
    required String landlord_phone,
    required String apartment_type,
    required String rent_value,
    required String owed_previous,
    required String tenant_address,
    required String business_name,
    required String approve_amount,
    required String client_address,
    required String device_status,
    required String ownership_status,
    required String client_afford
  })async{
    _isLoading = true;
    notifyListeners();
    Uri url = Uri.parse('https://ccendpoints.herokuapp.com/api/v2/create-user-info');
    var body = {
      'avs_id': "3342",
      'name': name,
      'email': email,
      'phone': phone,
      'landlord_email': landlord_email,
      'landlord_phone': landlord_phone,
      'apartment_type': apartment_type,
      'rent_value': rent_value,
      'owed_previous': owed_previous,
      'tenant_address': tenant_address,
      'business_name': business_name,
      'approve_amount': approve_amount,
      'client_address': client_address,
      'device_status': device_status,
      'ownership_status': ownership_status,
      'client_afford': client_afford,
    };

    var jsonBody = json.encode(body);
    http.Response? response;

    try{
      response = await http
          .post(url, body: jsonBody, headers: await Headers.fullHeader)
          .timeout(Duration(seconds: _timeout));
    } catch(e){
      _resMessage = 'Please try again';
      _isLoading = false;
      notifyListeners();
      debugPrint('e================> ${e.toString()}');
      debugPrint('e================> ${e.toString()}');
      throw Exception('Exception =========> ${e.toString()}');
    }

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      debugPrint("responseData=========>  $responseData");
      String Smessage = responseData['message'];
      debugPrint('message ============> $Smessage');
      debugPrint('statusCode ============> ${response.statusCode}');

      _isLoading = false;
      _resMessage = responseData['message'];
      _resStatusCode = response.statusCode;
      notifyListeners();

    }else{
      debugPrint('errorstatusCode ============> ${response.statusCode}');
      debugPrint('One fo the fields are missing');
      _isLoading = false;
      _resStatusCode = response.statusCode;
      _resMessage = "Some fields are missing";
      notifyListeners();
    }
    VerifyModel verifying = VerifyModel();
    return verifying;
  }


}