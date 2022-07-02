import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saar/providers/user_profile_provider.dart';
import '../../services/routes.dart';
import '../../utils/sp_helper.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  callLoginCheck() async {
    String? login = await SPHelper().storage.read(key: "login");
    if(login == "true"){
      var userProvider = Provider.of<UserDetailsProvider>(context, listen: false);
      String? mobile = await SPHelper().storage.read(key: "mobile");
      await userProvider.callUserProfile(context, phoneNumber: mobile!);
      Navigator.pushNamedAndRemoveUntil(context, RoutesPath.home, (route) => false);
    }else{
      Navigator.pushNamedAndRemoveUntil(context, RoutesPath.mobileLogin, (route) => false);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callLoginCheck();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/splash.png"),
          fit: BoxFit.cover,
        )
      ),
      // child: const Scaffold(
        // body: Center(child: FlutterLogo(size: 150.0,),),
      // ),
    );
  }
}
