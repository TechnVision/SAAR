import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saar/providers/dispatch_info_provider.dart';
import 'package:saar/providers/outstanding_details_provider.dart';
import 'package:saar/providers/package_info_provider.dart';
import 'package:saar/providers/user_profile_provider.dart';
import 'package:saar/services/routes.dart';
import 'package:saar/utils/string_utils.dart';
import 'package:saar/view/screens/mobile_login.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserDetailsProvider()),
        ChangeNotifierProvider(create: (_) => OutstandingDetailsProvider()),
        ChangeNotifierProvider(create: (_) => PackageInfoProvider()),
        ChangeNotifierProvider(create: (_) => DispatchInfoProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: StringUtils.appName,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: Routers.generateRoute,
        initialRoute: RoutesPath.splash,
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute<void>(
            settings: settings,
            builder: (BuildContext context) =>
            const Scaffold(body: Center(child: Text('404 Not Found'))),
          );
        },
      ),
    );
  }
}
