import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatefulWidget {
  final String? label;
  final String? hintText;
  final bool isPassword;
  final bool readOnly;
  final Widget? suffix;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? initialValue;
  final void Function()? onTap;
  final void Function(String val)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

  const AppTextField({
    super.key,
    this.label,
    this.hintText,
    this.controller,
    this.initialValue,
    this.suffix,
    this.onTap,
    this.keyboardType,
    this.onChanged,
    this.inputFormatters,
    this.validator,
    this.isPassword = false,
    this.readOnly = false,
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
          onTap: widget.onTap,
          readOnly: widget.readOnly,
          initialValue: widget.initialValue,
          onChanged: widget.onChanged,
          controller: widget.controller,
          obscureText: isObsecure,
          keyboardType: widget.keyboardType,
          style: context.textTheme.displayMedium?.copyWith(
            color: widget.readOnly ? AppColors.kBlack900.withOpacity(.6) : AppColors.kBlack900,
          ),
          inputFormatters: widget.inputFormatters,
          validator: widget.validator,
          decoration: InputDecoration(
            hintText: widget.hintText,
            contentPadding: const EdgeInsets.all(14),
            focusedBorder: widget.readOnly
                ? OutlineInputBorder(
                    borderRadius: 10.borderRadius2,
                    borderSide: const BorderSide(
                      color: AppColors.kGrey100,
                    ),
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: 10.borderRadius2,
              borderSide: const BorderSide(
                color: AppColors.kGrey100,
              ),
            ),
            suffixIcon: widget.suffix ??
                (widget.isPassword
                    ? IconButton(
                        onPressed: () {
                          isObsecure = !isObsecure;
                          setState(() {});
                        },
                        icon: Icon(
                          !isObsecure ? Icons.remove_red_eye : Icons.remove_red_eye_outlined,
                        ),
                      )
                    : null),
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

  @override
  void dispose() {
    widget.controller?.dispose();
    super.dispose();
  }
}
