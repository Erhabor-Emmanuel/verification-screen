
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

class RentScreen extends StatefulWidget {
  final String avsId;
  const RentScreen({Key? key, required this.avsId}) : super(key: key);

  @override
  State<RentScreen> createState() => _RentScreenState();
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

class _RentScreenState extends State<RentScreen> {
  final VerificationRepo _repository = VerificationRepo();
  TextEditingController _landEmailController = TextEditingController();
  TextEditingController _landPhController = TextEditingController();
  TextEditingController _rentValueController = TextEditingController();
  bool enable = false;


  @override
  void dispose() {
    _landEmailController;
    _landPhController;
    _rentValueController;
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
                Text('Rent acquisition verification', style: kFaqStyle,),
                SizedBox(height: 5.h,),
                Text(Strings.UpdateProfile, style: kFeatureStyle,),
                SizedBox(height: 15.h,),
                FormWidget(text: Strings.kLandE, hText: 'email', controller: _landEmailController),
                SizedBox(height: 10.h,),
                FormNum(text: Strings.kLandN, hText: 'Phone no.', controller: _landPhController,),
                SizedBox(height: 10.h,),
                FormNum(text: Strings.kRentV, hText: 'answer', controller: _rentValueController),
                SizedBox(height: 25.h,),
                Consumer<VerificationRepo>(
                    builder: (context, verify, child) {
                      return GestureDetector(
                        onTap: ()async{
                          await verify.verifyUsers(
                            avs_id: widget.avsId,
                            landlord_email: _landEmailController.text,
                            landlord_phone: _landPhController.text,
                            rent_value: _rentValueController.text,
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
