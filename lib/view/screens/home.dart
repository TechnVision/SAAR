import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saar/providers/user_profile_provider.dart';
import 'package:saar/services/routes.dart';
import 'package:saar/utils/sp_helper.dart';
import 'package:saar/utils/string_utils.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //AppBar
  PreferredSizeWidget appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text(StringUtils.appName),
    );
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserDetailsProvider>(context);
    return
        Scaffold(
          appBar: appBar(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 150.0,
                width: double.infinity,
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(userProvider.userProfile!.party),
                      Text(userProvider.userProfile!.compGstNo),
                    ],
                  ),
                ),
              ),
              const Divider(
                thickness: 1.0,
              ),
              InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesPath.dispatchInfo);
                  },
                  child: Container(
                    height: 150.0,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.delivery_dining,
                          size: 35.0,
                        ),
                        Text(StringUtils.dispatch),
                      ],
                    ),
                  )),
              const Divider(
                thickness: 1.0,
              ),
              InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesPath.outstanding);
                  },
                  child: Container(
                    height: 150.0,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.outbond_outlined,
                          size: 35.0,
                        ),
                        Text(StringUtils.outstanding),
                      ],
                    ),
                  )),
              const Divider(
                thickness: 1.0,
              ),
              const SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(200.0, 45.0)),
                        onPressed: () async {
                          var details = Provider.of<UserDetailsProvider>(context, listen: false);
                          await SPHelper().storage.deleteAll();
                          details.auth.signOut();
                          Navigator.pushNamedAndRemoveUntil(context,
                              RoutesPath.mobileLogin, (route) => false);
                        },
                        child: const Text(
                          StringUtils.logout,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
    );
  }
}



