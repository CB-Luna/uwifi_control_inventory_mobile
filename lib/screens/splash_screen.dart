import 'package:bizpro_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:bizpro_app/providers/providers.dart';
import 'package:bizpro_app/screens/screens.dart';
import 'package:bizpro_app/theme/theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

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
                future: userState.readToken(),
                builder: (_, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return SizedBox(
                      width: 50,
                      height: 50,
                      child: SpinKitRipple(
                        color: AppTheme.of(context).primaryColor,
                        size: 50,
                      ),
                    );
                  }
                  if (snapshot.data == '') {
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
