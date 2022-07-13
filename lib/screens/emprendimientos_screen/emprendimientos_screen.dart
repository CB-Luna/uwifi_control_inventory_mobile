import 'package:bizpro_app/providers/providers.dart';
import 'package:bizpro_app/screens/emprendimientos_screen/network_stream_widget.dart';
import 'package:bizpro_app/screens/screens.dart';
import 'package:bizpro_app/screens/widgets/custom_button.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmprendimientosScreen extends StatefulWidget {
  const EmprendimientosScreen({Key? key}) : super(key: key);

  @override
  State<EmprendimientosScreen> createState() => _EmprendimientosScreenState();
}

class _EmprendimientosScreenState extends State<EmprendimientosScreen> {
  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              const NetworkStreamWidget(),
              Padding(
                padding: const EdgeInsets.only(top: 400),
                child: CustomButton(
                  onPressed: () async {
                    await userState.logout();

                    if (!mounted) return;

                    await Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SplashScreen(),
                      ),
                      (r) => false,
                    );
                  },
                  text: 'Cerrar sesión',
                  options: ButtonOptions(
                    width: 170,
                    height: 50,
                    color: const Color(0xFF006AFF),
                    textStyle: AppTheme.of(context).subtitle2.override(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                    elevation: 0,
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
