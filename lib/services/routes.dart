import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saar/view/screens/dispatch_body.dart';
import 'package:saar/view/screens/dispatch_details.dart';
import 'package:saar/view/screens/dispatch_summary.dart';
import 'package:saar/view/screens/home.dart';
import 'package:saar/view/screens/mobile_login.dart';
import 'package:saar/view/screens/outstanding.dart';
import 'package:saar/view/screens/outstanding_details.dart';
import 'package:saar/view/screens/pack_info.dart';
import 'package:saar/view/screens/splash.dart';

class RoutesPath {
  static const String splash = "splash";
  static const String mobileLogin = "mobileLogin";
  static const String home = "home";
  static const String outstanding = "outstanding";
  static const String outstandingDetails = "outstandingDetails";
  static const String dispatchInfo = "dispatchInfo";
  static const String dispatchDetails = "dispatchDetails";
  static const String dispatchBody = "dispatchBody";
  static const String packInfo = "packInfo";
}

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesPath.splash:
        return CupertinoPageRoute(builder: (ctx) => const Splash());

      case RoutesPath.mobileLogin:
        return CupertinoPageRoute(builder: (ctx) => const MobileLogin());
      case RoutesPath.home:
        return CupertinoPageRoute(builder: (ctx) => const Home());

      case RoutesPath.outstanding:
        return CupertinoPageRoute(builder: (ctx) => const OutStanding());

      case RoutesPath.dispatchInfo:
        return CupertinoPageRoute(builder: (ctx) => const DispatchSummary());

      case RoutesPath.dispatchDetails:
        final args = settings.arguments as DispatchDetails;
        return CupertinoPageRoute(
            builder: (ctx) => DispatchDetails(
                compGSTno: args.compGSTno,
                compMobile: args.compMobile,
                partyName: args.partyName));

      case RoutesPath.dispatchBody:
        final args = settings.arguments as DispatchBody;
        return CupertinoPageRoute(
            builder: (ctx) => DispatchBody(
                  compGSTNo: args.compGSTNo,
                  billNo: args.billNo,
                  fvNo: args.fvNo,
                ));

      case RoutesPath.packInfo:
        final args = settings.arguments as PackingInfo;
        return CupertinoPageRoute(
            builder: (ctx) => PackingInfo(
                  compGSTno: args.compGSTno,
                  bookCode: args.bookCode,
                  caseNo: args.caseNo,
                  billNo: args.billNo,
                ));

      case RoutesPath.outstandingDetails:
        final args = settings.arguments as OutstandingDetails;
        return CupertinoPageRoute(
            builder: (ctx) => OutstandingDetails(
                  mobileNo: args.mobileNo,
                  partyName: args.partyName,
                  compGSTno: args.compGSTno,
                ));

      default:
        return CupertinoPageRoute(
            builder: (ctx) => const Scaffold(
                  body: Center(
                    child: Text("No route found"),
                  ),
                ));
    }
  }
}
