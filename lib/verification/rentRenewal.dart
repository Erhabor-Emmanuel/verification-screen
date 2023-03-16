import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../common_widgets/LoginButton.dart';
import '../common_widgets/formNo.dart';
import '../common_widgets/formWidget.dart';
import '../common_widgets/inactiveButton.dart';
import '../common_widgets/loginCircular.dart';
import '../const/assets.dart';
import '../const/snackbar.dart';
import '../const/strings.dart';
import '../const/styles.dart';
import '../repository/remote_data/queries.dart';

class RentRenewalScreen extends StatefulWidget {
  final String avsId;
  const RentRenewalScreen({Key? key, required this.avsId}) : super(key: key);

  @override
  State<RentRenewalScreen> createState() => _RentRenewalScreenState();
}

String? myGender = 'Flat';
List<String> Genders = [
  'Flat',
  'Self-Contain',
  'Duplex',
];

String? myStatus = 'Tenant';
List<String> Status = [
  'Tenant',
  'Owner',
  'Squatter',
];

class _RentRenewalScreenState extends State<RentRenewalScreen> {
  final VerificationRepo _repository = VerificationRepo();
  TextEditingController _landEmailController = TextEditingController();
  TextEditingController _landPhController = TextEditingController();
  TextEditingController _rentValueController = TextEditingController();
  bool enable = false;
  bool workerOne = false;
  bool workerTwo = false;
  bool enablerOne = false;
  bool enablerTwo = false;

  @override
  void initState() {
    super.initState();
    _landEmailController.addListener(() {
      final enable = _landEmailController.text.isNotEmpty && _landPhController.text.isNotEmpty && _rentValueController.text.isNotEmpty? true: false;
      setState(() => this.enable = enable);
    });

    _landPhController.addListener(() {
      final enable = _landPhController.text.isNotEmpty && _landEmailController.text.isNotEmpty &&_rentValueController.text.isNotEmpty? true:false;
      setState(() => this.enable = enable);
    });

    _rentValueController.addListener(() {
      final enable = _rentValueController.text.isNotEmpty && _landPhController.text.isNotEmpty && _landEmailController.text.isNotEmpty? true:false;
      setState(() => this.enable = enable);
    });
  }



  @override
  void dispose() {
    _landEmailController;
    _landPhController;
    _rentValueController;
    super.dispose();
  }

  bool _checkBox = false;
  bool _checkBoxFour = false;
  String? auto;
  String? autoFour;
  String? autoOne;
  String? autoTwo;
  bool _nextCheckBox = false;
  bool _nextCheckBoxFour = false;
  bool _nextCheckBoxOne = false;
  bool _checkBoxOne = false;
  bool _checkBoxTwo = false;
  bool _nextCheckBoxTwo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back, color: kBlack),
          ),
          backgroundColor: kLoanCard,
          elevation: 0.5
      ),
      backgroundColor: kLoanCard,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 15.r, right: 15.r, top: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Rent renewal verification', style: kFaqStyle,),
                SizedBox(height: 5.h,),
                Text(Strings.UpdateProfile, style: kFeatureStyle,),
                SizedBox(height: 15.h,),
                FormWidget(text: Strings.kLandE, hText: 'email', controller: _landEmailController),
                SizedBox(height: 10.h,),
                FormNum(text: Strings.kLandN, hText: 'Phone no.', controller: _landPhController,),
                SizedBox(height: 10.h,),
                Text('Apartment Type', style: kFirstN,),
                SizedBox(height: 5.h,),
                DropdownButtonHideUnderline(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 42.h,
                    decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(12.0.r)
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 5.0.r),
                      child: DropdownButton(
                        items: Genders.map((items) {
                          return DropdownMenuItem<String>(value: items,child: Text(items, style: kFirstN,),);
                        }).toList(),
                        value: myGender,
                        onChanged: (value){
                          setState(() {
                            myGender = value;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h,),
                FormNum(text: Strings.kRentV, hText: 'answer', controller: _rentValueController),
                SizedBox(height: 10.h,),
                Text(Strings.kOwed, style: kFirstN),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 160.w,
                      height: 58.h,
                      child: Card(
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: kWhite,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15.0.r, right: 15.0.r),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(Strings.kYes, style: kFirstN),
                              Checkbox(
                                value: _checkBox,
                                checkColor: kWhite,
                                activeColor: kSafeGreen,
                                onChanged: (bool? value){
                                  if(value != null && _nextCheckBox == false){
                                    setState(() {
                                      _checkBox = value;
                                      auto = 'Yes';
                                      workerOne = true;
                                    });
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 160.w,
                      height: 58.h,
                      child: Card(
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: kWhite,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15.0.r, right: 15.0.r),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(Strings.kNo, style: kFirstN),
                              Checkbox(
                                value: _nextCheckBox,
                                checkColor: kWhite,
                                activeColor: kSafeGreen,
                                onChanged: (bool? value){
                                  if(value != null && _checkBox == false){
                                    setState(() {
                                      _nextCheckBox = value;
                                      enablerOne = true;
                                      auto = 'No';
                                    });
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h,),
                Text('Does the tenant reside at address', style: kFirstN),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 160.w,
                      height: 58.h,
                      child: Card(
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: kWhite,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15.0.r, right: 15.0.r),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(Strings.kYes, style: kFirstN),
                              Checkbox(
                                value: _checkBoxFour,
                                checkColor: kWhite,
                                activeColor: kSafeGreen,
                                onChanged: (bool? value){
                                  if(value != null && _nextCheckBoxFour == false){
                                    setState(() {
                                      _checkBoxFour = value;
                                      autoFour = 'Yes';
                                      workerTwo = true;
                                    });
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 160.w,
                      height: 58.h,
                      child: Card(
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: kWhite,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15.0.r, right: 15.0.r),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(Strings.kNo, style: kFirstN),
                              Checkbox(
                                value: _nextCheckBoxFour,
                                checkColor: kWhite,
                                activeColor: kSafeGreen,
                                onChanged: (bool? value){
                                  if(value != null && _checkBoxFour == false){
                                    setState(() {
                                      _nextCheckBoxFour = value;
                                      autoFour = 'No';
                                      enablerTwo = true;
                                    });
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25.h,),
                (enable && auto != null && autoFour != null)? Consumer<VerificationRepo>(
                    builder: (context, verify, child) {
                      return GestureDetector(
                        onTap: ()async{
                          await verify.verifyUsers(
                            avs_id: widget.avsId,
                            landlord_email: _landEmailController.text,
                            landlord_phone: _landPhController.text,
                            apartment_type: myGender.toString(),
                            rent_value: _rentValueController.text,
                            owed_previous: auto.toString(),
                            tenant_address: autoFour.toString(),
                            device_status: autoOne.toString(),
                            ownership_status: myStatus.toString(),
                            client_afford: autoTwo.toString(),
                          );
                          debugPrint("message:::  ${verify.resMessage}");
                          if(verify.resStatusCode == 200){
                            showingSnacks(context, verify.resMessage);
                            // Future.delayed(Duration(seconds: 1));
                            _repository.getAvisList();
                            Navigator.pop(context);
                          }else{
                            showingErrorSnacks(context, verify.resMessage);
                          }
                        },
                        child: verify.isLoading? LoginCircular(text: '', style: kLoginButton,):
                        LoginB(text: Strings.kConfirm, style: kLoginButton),
                      );
                    }
                ) :
                InActiveLoginB(text: Strings.kConfirm, style: kLoginButton,),
                SizedBox(height: 25.h,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
