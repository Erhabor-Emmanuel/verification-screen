
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../common_widgets/LoginButton.dart';
import '../common_widgets/formNo.dart';
import '../common_widgets/formWidget.dart';
import '../common_widgets/loginCircular.dart';

import '../const/snackbar.dart';
import '../const/strings.dart';
import '../const/styles.dart';
import '../repository/remote_data/queries.dart';

class MerchantScreen extends StatefulWidget {
  final String avsId;
  const MerchantScreen({Key? key, required this.avsId}) : super(key: key);

  @override
  State<MerchantScreen> createState() => _MerchantScreenState();
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

class _MerchantScreenState extends State<MerchantScreen> {
  final VerificationRepo _repository = VerificationRepo();
  TextEditingController _businessNameController = TextEditingController();
  TextEditingController _approvedAmountController = TextEditingController();
  bool enable = false;


  @override
  void dispose() {
    _businessNameController;
    _approvedAmountController;
    super.dispose();
  }

  bool _checkBox = false;
  String? auto;
  String? autoOne;
  String? autoTwo;
  bool _nextCheckBox = false;
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
                Text('Complete Merchant verification', style: kFaqStyle,),
                SizedBox(height: 5.h,),
                Text(Strings.UpdateProfile, style: kFeatureStyle,),
                SizedBox(height: 15.h,),
                FormWidget(text: Strings.kBusN, hText: 'Business name', controller: _businessNameController),
                SizedBox(height: 10.h,),
                FormNum(text: Strings.kMerchantAmount, hText: 'approved amount', controller: _approvedAmountController,),
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
                Consumer<VerificationRepo>(
                    builder: (context, verify, child) {
                      return GestureDetector(
                        onTap: ()async{
                          await verify.verifyUsers(
                            avs_id: widget.avsId,
                            business_name: _businessNameController.text,
                            approve_amount: _approvedAmountController.text,
                            ownership_status: myStatus.toString(),
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
                ),
                SizedBox(height: 25.h,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
