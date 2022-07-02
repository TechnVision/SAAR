import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saar/providers/user_profile_provider.dart';
import 'package:saar/utils/string_utils.dart';


class MobileLogin extends StatefulWidget {
  const MobileLogin({Key? key}) : super(key: key);

  @override
  State<MobileLogin> createState() => _MobileLoginState();
}

class _MobileLoginState extends State<MobileLogin> {
  final _mobileNOController = TextEditingController();
  final _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  callLogin() async {
    if (_formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      _formKey.currentState!.save();
      var userDetails =
          Provider.of<UserDetailsProvider>(context, listen: false);
      await userDetails.callUserProfile(context, phoneNumber: _mobileNOController.text);
    } else {
      return;
    }
  }

  callResend() async {
    var userDetails =
    Provider.of<UserDetailsProvider>(context, listen: false);
    setState(() {
      userDetails.otpSent = false;
    });
    userDetails.resendOTP(mobileNo: _mobileNOController.text);
  }


  PreferredSizeWidget appBar(){
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0.0,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mobileNOController.text = "8233029994";
  }

  @override
  Widget build(BuildContext context) {
    var userDetails = Provider.of<UserDetailsProvider>(context);
    return Scaffold(
      appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Form(
          key: _formKey,
            child: Column(
          children: [
            const SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  StringUtils.welcomeMsg,
                  style: TextStyle(fontSize: 22.0),
                ),
              ],
            ),
            const SizedBox(
              height: 30.0,
            ),
            TextFormField(
              controller: _mobileNOController,
              keyboardType: TextInputType.phone,
              validator: (val) {
                if (val!.isEmpty) {
                  return "Enter mobile no.";
                } else if (val.length != 10) {
                  return "Enter valid mobile no.";
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: StringUtils.enterMobileNo),
            ),
            const SizedBox(
              height: 15.0,
            ),
            userDetails.otpSent ? TextFormField(
              controller: _otpController,
              keyboardType: TextInputType.phone,
              validator: (val) {
                if (val!.isEmpty) {
                  return "Enter OTP";
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: StringUtils.enterOTP),
            ) : const SizedBox.shrink(),

            // userDetails.otpSent ? Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     TextButton(onPressed: (){
            //       callLogin();
            //     }, child: const Text("Resend Code")),
            //   ],
            // ) : const SizedBox.shrink(),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if(userDetails.otpSent){
                          FocusManager.instance.primaryFocus?.unfocus();
                          userDetails.verifyOTP(context, otp: _otpController.text);
                        }else{
                          callLogin();
                        }
                      },
                      child: userDetails.loading
                          ? const Center(child: CircularProgressIndicator(),)
                          : userDetails.otpSent ? const Text(StringUtils.login) : const Text("Send OTP"),
                    ))
              ],
            ),
          ],
        )),
      ),
    );
  }
}
