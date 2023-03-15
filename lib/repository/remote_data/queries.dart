import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../models/avis_model.dart';
import '../../models/verification_model.dart';
import 'package:verification/repository/remote_data/api_constants.dart';
import 'dart:async';

class VerificationRepo extends ChangeNotifier{
  final int _timeout = 60;
  //Setters
  bool _isLoading = false;
  String _resMessage = '';
  int _resStatusCode = 0;
  String _agentName = '';
  List<dynamic> _myData = [];
  String _avisId = '';
  String _verified = '';

  //Getters
  int get resStatusCode => _resStatusCode;
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;
  String get agentName => _agentName;
  List<dynamic> get myData => _myData;
  String get avisId => _avisId;
  String get verified => _verified;

  Future<VerifyModel> verifyUsers ({
    required String avs_id,
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
      'avs_id': avs_id,
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
          .put(url, body: jsonBody, headers: await Headers.fullHeader)
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



  Future<AvisListModel> getAvisList() async{
    String numb = '08102637956';
    Uri url = Uri.parse('https://ccendpoints.herokuapp.com/api/v2/retrieve-avs-by-phone?phone=$numb');
    http.Response? response;

    response = await http
        .get(url, headers: await Headers.fullHeader)
        .timeout(Duration(seconds: _timeout));

    var jsonString = response.body;
    Map<String, dynamic> responseData = json.decode(response.body);
    debugPrint('responseDatappppp ===> $responseData');

    List<dynamic> gottenData = responseData['data'];
    // String avsId = responseData['data']['avs_id'] ?? '';
    // String verifiedd = responseData['data']['verified'] ?? '';
    // String status = responseData['status'] ?? '';
    // debugPrint('statusCode ===> ${response.statusCode}');
    // debugPrint("agentNamee ===========> $agentNamee");
    // debugPrint("agentPhonee ===========> $agentPhonee");
    // debugPrint("avsId ===========> $avsId");
    // debugPrint("verifiedd ===========> $verifiedd");
    // debugPrint("status ===========> $status");

    if(response.statusCode == 200){
      _isLoading = false;
      _myData = gottenData;
      // _agentName = agentNamee;
      // _agentPhone = agentPhonee;
      // _avisId = avsId;
      // _verified = verifiedd;
      // debugPrint("messageTrue ==========> $message");

      notifyListeners();
      return AvisListModel.fromJson(responseData);
    }else{
      // debugPrint("messageElse =========> $message");
      _isLoading = false;
      _resMessage = 'Network connecton error';
      notifyListeners();
      // debugPrint('status==========> ${result.status}');
      throw Exception('Exception===========> Something went wrong');
    }

  }


}