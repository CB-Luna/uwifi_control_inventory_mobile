import 'package:uwifi_control_inventory_mobile/theme/theme.dart';
import 'package:uwifi_control_inventory_mobile/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:uwifi_control_inventory_mobile/providers/system/user_provider.dart';

import 'package:uwifi_control_inventory_mobile/screens/control_form/main_screen_selector.dart';
import 'package:uwifi_control_inventory_mobile/screens/screens.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
    this.splashTimer = 10,
  }) : super(key: key);

  final int splashTimer;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Future<void> displaySplashImage;
  @override
  void initState() {
    displaySplashImage = Future.delayed(Duration(seconds: widget.splashTimer));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context, listen: false);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: StreamBuilder(
            stream: bloc.state,
            builder: (context, AsyncSnapshot<String?> snapshot) {
              if (snapshot.hasData && snapshot.data != '') {
                SchedulerBinding.instance
                    .addPostFrameCallback((timeStamp) async {
                  await Navigator.pushAndRemoveUntil(
                      context,
                      PageRouteBuilder(
                        pageBuilder:
                            ((context, animation, secondaryAnimation) =>
                                ChangePasswordScreen(
                                  token: snapshot.data!,
                                )),
                        transitionDuration: const Duration(seconds: 0),
                      ),
                      ((route) => false));
                });
              } else {
                return FutureBuilder(
                  future: Future.wait([
                    userState.readTokenPocketbase(),
                    displaySplashImage,
                  ]),
                  builder: (_, AsyncSnapshot<List> snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        color: AppTheme.of(context).tertiaryColor,
                        child: Builder(
                          builder: (context) => Image.asset(
                            'assets/images/Final_Comp.gif',
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }
                    if (snapshot.data![0] == '') {
                      return const LoginScreen();
                    } else {
                      return const MainScreenSelector();
                    }
                  },
                );
              }
              return Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: SpinKitRipple(
                    color: AppTheme.of(context).tertiaryColor,
                    size: 50,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
