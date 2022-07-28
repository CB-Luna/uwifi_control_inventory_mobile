import 'package:bizpro_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:bizpro_app/providers/providers.dart';
import 'package:bizpro_app/screens/screens.dart';
import 'package:bizpro_app/theme/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Future<void> displaySplashImage;
  @override
  void initState() {
    displaySplashImage = Future.delayed(const Duration(seconds: 6));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context, listen: false);
    return Scaffold(
      body: Center(
        child: StreamBuilder(
          stream: bloc.state,
          builder: (context, AsyncSnapshot<String?> snapshot) {
            if (snapshot.hasData && snapshot.data != '') {
              SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
                await Navigator.pushAndRemoveUntil(
                    context,
                    PageRouteBuilder(
                      pageBuilder: ((context, animation, secondaryAnimation) =>
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
                  userState.readToken(),
                  displaySplashImage,
                ]),
                builder: (_, AsyncSnapshot<List> snapshot) {
                  if (!snapshot.hasData) {
                    return Container(
                      color: Colors.transparent,
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
                    return const EmprendimientosScreen();
                  }
                },
              );
            }
            return Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: SpinKitRipple(
                  color: AppTheme.of(context).primaryColor,
                  size: 50,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
