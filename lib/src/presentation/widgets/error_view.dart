import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final void Function() onreTry;
  final String errorMsg;
  final int? statusCode;
  const ErrorView({
    super.key,
    required this.onreTry,
    required this.errorMsg,
    this.statusCode,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(errorMsg),
            16.spaceH,
            ElevatedButton(
              onPressed: onreTry,
              child: const Text("Retry"),
            )
          ],
        ),
      ),
    );
  }
}
