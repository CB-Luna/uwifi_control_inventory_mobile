import 'package:bizpro_app/providers/providers.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NetworkStreamWidget extends StatelessWidget {
  const NetworkStreamWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NetworkState networkState = Provider.of<NetworkState>(
      context,
      listen: false,
    );

    return StreamBuilder<ConnectivityResult>(
      initialData: ConnectivityResult.none,
      stream: networkState.networkStream,
      builder: (context, snapshot) {
        final connection = snapshot.data ?? ConnectivityResult.none;
        final message = networkState.getConnectionMessage(connection);
        final color = networkState.getConnectionColor(connection);
        return _NetworkStateWidget(message: message, color: color);
      },
    );
  }
}

class _NetworkStateWidget extends StatelessWidget {
  final String message;
  final Color color;

  const _NetworkStateWidget({required this.message, required this.color});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      color: color,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      duration: kThemeAnimationDuration,
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
