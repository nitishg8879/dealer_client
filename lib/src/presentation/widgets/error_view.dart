import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final void Function() onreTry;
  final String errorMsg;
  const ErrorView({
    super.key,
    required this.onreTry,
    required this.errorMsg,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(errorMsg),
          16.spaceH,
          ElevatedButton(
            onPressed: onreTry,
            child: const Text("Retry"),
          )
        ],
      ),
    );
  }
}
