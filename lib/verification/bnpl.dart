

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../common_widgets/LoginButton.dart';
import '../common_widgets/inactiveButton.dart';
import '../common_widgets/loginCircular.dart';
import '../const/snackbar.dart';
import '../const/strings.dart';
import '../const/styles.dart';
import '../repository/remote_data/queries.dart';

class BnplScreen extends StatefulWidget {
  final String avsId;
  const BnplScreen({Key? key, required this.avsId}) : super(key: key);

  @override
  State<BnplScreen> createState() => _BnplScreenState();
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

class _BnplScreenState extends State<BnplScreen> {
  final VerificationRepo _repository = VerificationRepo();
  TextEditingController _clientAddressController = TextEditingController();
  bool enable = false;
  bool workingOne = false;
  bool workingTwo = false;
  bool workingThree = false;
  bool enablerOne = false;
  bool enablerTwo = false;
  bool enablerThree = false;


  bool _checkBox = false;
  String? auto;
  String? autoOne;
  String? autoThree;
  String? autoTwo;
  bool _nextCheckBox = false;
  bool _nextCheckBoxOne = false;
  bool _nextCheckBoxThree = false;
  bool _checkBoxOne = false;
  bool _checkBoxThree = false;
  bool _checkBoxTwo = false;
  bool _nextCheckBoxTwo = false;

  @override
  void initState() {
    super.initState();
    final enable = _checkBoxOne == true && _checkBoxTwo == true && _checkBoxThree == true? true: false;
    setState(() => this.enable = enable);

  }



  @override
  void dispose() {
    _clientAddressController;
    super.dispose();
  }



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
                Text('BNPL verification', style: kFaqStyle,),
                SizedBox(height: 5.h,),
                Text(Strings.UpdateProfile, style: kFeatureStyle,),
                SizedBox(height: 15.h,),
                Text('Does client reside at the address', style: kFirstN),
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
                                value: _checkBoxThree,
                                checkColor: kWhite,
                                activeColor: kSafeGreen,
                                onChanged: (bool? value){
                                  if(value != null && _nextCheckBoxThree == false){
                                    setState(() {
                                      _checkBoxThree = value;
                                      autoThree = 'Yes';
                                      workingOne = true;
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
                                value: _nextCheckBoxThree,
                                checkColor: kWhite,
                                activeColor: kSafeGreen,
                                onChanged: (bool? value){
                                  if(value != null && _checkBoxThree == false){
                                    setState(() {
                                      _nextCheckBoxThree = value;
                                      autoThree = 'No';
                                      enablerOne = true;
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
                Text('Ownership status', style: kFirstN,),
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
                          return DropdownMenuItem<String>(value: items,child: Text(items, style: kFirstN,),);
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
                                value: _checkBoxOne,
                                checkColor: kWhite,
                                activeColor: kSafeGreen,
                                onChanged: (bool? value){
                                  if(value != null && _nextCheckBoxOne == false){
                                    setState(() {
                                      _checkBoxOne = value;
                                      autoOne = 'Yes';
                                      workingTwo = true;
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
                                value: _nextCheckBoxOne,
                                checkColor: kWhite,
                                activeColor: kSafeGreen,
                                onChanged: (bool? value){
                                  if(value != null && _checkBoxOne == false){
                                    setState(() {
                                      _nextCheckBoxOne = value;
                                      autoOne = 'No';
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
                                value: _checkBoxTwo,
                                checkColor: kWhite,
                                activeColor: kSafeGreen,
                                onChanged: (bool? value){
                                  if(value != null && _nextCheckBoxTwo == false){
                                    setState(() {
                                      _checkBoxTwo = value;
                                      autoTwo = 'Yes';
                                      workingThree = true;
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
                                value: _nextCheckBoxTwo,
                                checkColor: kWhite,
                                activeColor: kSafeGreen,
                                onChanged: (bool? value){
                                  if(value != null && _checkBoxTwo == false){
                                    setState(() {
                                      _nextCheckBoxTwo = value;
                                      autoTwo = 'No';
                                      enablerThree = true;
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
                (autoOne != null && autoTwo != null && autoThree != null)? Consumer<VerificationRepo>(
                    builder: (context, verify, child) {
                      return GestureDetector(
                        onTap: ()async{
                          await verify.verifyUsers(
                            avs_id: widget.avsId,
                            client_address: autoThree.toString(),
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


// (_checkBoxOne == true  && _checkBoxTwo == true && _checkBoxThree == true && _nextCheckBoxOne == false && _nextCheckBoxTwo == false && _nextCheckBoxThree == false || _nextCheckBoxOne == true && _nextCheckBoxTwo == true && _nextCheckBoxThree == true && _checkBoxOne == false  && _checkBoxTwo == false && _checkBoxThree == false)