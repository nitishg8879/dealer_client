import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final String? label;
  final String? hintText;
  final bool isPassword;
  const AppTextField({
    super.key,
    this.label,
    this.hintText,
    this.isPassword = false,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool isObsecure = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: context.textTheme.titleSmall?.copyWith(
              color: AppColors.kBlack900,
            ),
          ),
        ],
        2.spaceH,
        TextFormField(
          obscureText: isObsecure,
          style: context.textTheme.displayMedium,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(14),
            border: OutlineInputBorder(
              borderRadius: 10.borderRadius2,
              borderSide: const BorderSide(
                color: AppColors.kGrey100,
              ),
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () {
                      isObsecure = !isObsecure;
                      setState(() {});
                    },
                    icon: Icon(
                      !isObsecure ? Icons.remove_red_eye : Icons.remove_red_eye_outlined,
                    ),
                  )
                : null,
            enabledBorder: OutlineInputBorder(
              borderRadius: 10.borderRadius2,
              borderSide: const BorderSide(
                color: AppColors.kFoundationWhite600,
              ),
            ),
            isDense: true,
          ),
        )
      ],
    );
  }
}
