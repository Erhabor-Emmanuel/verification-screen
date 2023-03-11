import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../common_widgets/LoginButton.dart';
import '../common_widgets/formNo.dart';
import '../common_widgets/formWidget.dart';
import '../const/assets.dart';
import '../const/strings.dart';
import '../const/styles.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
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

class _VerificationScreenState extends State<VerificationScreen> {
  File? _image;
  String? base64PersonImage;

  pickImage(ImageSource source) async {

    try{
      final XFile? image = await ImagePicker().pickImage(source: source, imageQuality: 25);
      if(image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        _image = imageTemporary;
        base64PersonImage = base64Encode(_image!.readAsBytesSync());
      });
    } on PlatformException catch (e){
      debugPrint('$e');
    }
  }

  TextEditingController _residentialAddressController = TextEditingController();
  bool _checkBox = false;
  String? auto;
  bool _nextCheckBox = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLoanCard,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 15.r, right: 15.r, top: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(Strings.kCompleteSetup, style: kFaqStyle,),
                SizedBox(height: 5.h,),
                Text(Strings.UpdateProfile, style: kFeatureStyle,),
                SizedBox(height: 15.h,),
                FormWidget(text: Strings.kName, hText: 'name', controller: _residentialAddressController),
                SizedBox(height: 10.h,),
                FormWidget(text: Strings.kEmail, hText: 'Email', controller: _residentialAddressController),
                SizedBox(height: 10.h,),
                FormWidget(text: Strings.kPhn, hText: 'Phone no.', controller: _residentialAddressController),
                SizedBox(height: 10.h,),
                FormWidget(text: Strings.kLandE, hText: 'email', controller: _residentialAddressController),
                SizedBox(height: 10.h,),
                const FormNum(text: Strings.kLandN, hText: 'Phone no.',),
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
                          return DropdownMenuItem<String>(value: items,child: Text(items, style: kDetailAccount,),);
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
                // SizedBox(height: 15.h,),
                // Text(Strings.kProfileP, style: kFirstN),
                // SizedBox(height: 7.h,),
                // SizedBox(
                //   width: MediaQuery.of(context).size.width,
                //   height: 180.0.h,
                //   child: Column(
                //     children: [
                //       Container(
                //         width: MediaQuery.of(context).size.width -10,
                //         height: 120.h,
                //         color: kSignup,
                //         child: base64PersonImage != null ? Image.file(_image!, fit: BoxFit.cover,) :
                //         Image.asset(Assets.group, fit: BoxFit.cover,),
                //       ),
                //       Padding(
                //         padding: EdgeInsets.only(left: 5.0.r),
                //         child: IntrinsicHeight(
                //           child: Row(
                //             children: [
                //               Container(
                //                 padding: EdgeInsets.only(left: 13.0.r, right: 18.0.r, top: 10.0.r, bottom: 10.0.r),
                //                 height: 60.h,
                //                 decoration: BoxDecoration(
                //                   color: kWhite,
                //                   borderRadius: BorderRadius.only(
                //                     bottomLeft: Radius.circular(10.0.r),
                //                     bottomRight: Radius.circular(10.0.r),
                //                   ),
                //                 ),
                //                 child: Row(
                //                   children: [
                //                     InkWell(
                //                       onTap:(){
                //                         pickImage(ImageSource.camera);
                //                       },
                //                       child: Row(
                //                         children: [
                //                           SizedBox(child: Image.asset(Assets.camera)),
                //                           SizedBox(width: 15.w,),
                //                           Text(Strings.kPicture, style: kDetailAccount),
                //                         ],
                //                       ),
                //                     ),
                //                     VerticalDivider(
                //                       width: 36.w,
                //                       thickness: 2.0,
                //                       color: kDivide,
                //                     ),
                //                     InkWell(
                //                       onTap: (){
                //                         pickImage(ImageSource.gallery);
                //                       },
                //                       child: Row(
                //                         children: [
                //                           SizedBox(child: Image.asset(Assets.gallery)),
                //                           SizedBox(width: 15.w,),
                //                           Text(Strings.kUpload, style: kDetailAccount)
                //                         ],
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(height: 10.h,),
                FormWidget(text: Strings.kRentV, hText: 'answer', controller: _residentialAddressController),
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
                FormWidget(text: Strings.kTenantA, hText: 'address', controller: _residentialAddressController),
                SizedBox(height: 10.h,),
                FormWidget(text: Strings.kBusN, hText: 'Business name', controller: _residentialAddressController),
                SizedBox(height: 10.h,),
                const FormNum(text: Strings.kMerchantAmount, hText: 'approved amount',),
                SizedBox(height: 10.h,),
                FormWidget(text: Strings.kClientA, hText: 'Client Address', controller: _residentialAddressController),
                SizedBox(height: 10.h,),
                Text('Clients apartment status', style: kFirstN,),
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
                        items: Status.map((items) {
                          return DropdownMenuItem<String>(value: items,child: Text(items, style: kDetailAccount,),);
                        }).toList(),
                        value: myStatus,
                        onChanged: (value){
                          setState(() {
                            myStatus = value;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h,),
                Text(Strings.kItem, style: kFirstN),
                SizedBox(height: 5.h,),
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
                Text(Strings.kAfford, style: kFirstN),
                SizedBox(height: 5.h,),
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
                SizedBox(height: 35.h,),
                LoginB(text: Strings.kConfirm, style: kLoginButton)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
