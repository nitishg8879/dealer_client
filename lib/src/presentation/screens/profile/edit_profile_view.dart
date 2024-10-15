import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/core/di/injector.dart';
import 'package:bike_client_dealer/core/services/app_local_service.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:bike_client_dealer/core/util/helper_fun.dart';
import 'package:bike_client_dealer/src/data/data_sources/auth_data_source.dart';
import 'package:bike_client_dealer/src/presentation/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class EditProfileView extends StatelessWidget {
  // void Function(String? fullName, String? phoneNo) onSave;
  String? fullName;
  String? email;
  String? phoneNo;
  EditProfileView({
    super.key,
    // required this.onSave,
    this.fullName,
    this.email,
    this.phoneNo,
  });
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      minChildSize: .1,
      maxChildSize: 1,
      expand: false,
      initialChildSize: .55,
      builder: (BuildContext context, ScrollController scrollController) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            controller: scrollController,
            children: [
              AppTextField(
                label: "Full Name",
                initialValue: fullName,
                onChanged: (val) => fullName = val,
                keyboardType: TextInputType.name,
              ),
              16.spaceH,
              AppTextField(
                label: "Email",
                readOnly: true,
                initialValue: email,
              ),
              16.spaceH,
              AppTextField(
                label: "Phone No",
                initialValue: phoneNo,
                onChanged: (val) => phoneNo = val,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
              ),
              24.spaceH,
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: context.pop,
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.kGrey300),
                      child: const Text("Discard"),
                    ),
                  ),
                  16.spaceW,
                  Expanded(
                    child: StatefulBuilder(builder: (context, re) {
                      return ElevatedButton(
                        onPressed: () {
                          if (isLoading) return;
                          re(() {
                            isLoading = true;
                          });
                          getIt
                              .get<AuthDataSource>()
                              .updateUserNameAndPhoneNumber(
                                fullName: fullName,
                                phoneNo: phoneNo,
                              )
                              .catchError((error) {
                            HelperFun.showErrorSnack(error.toString());
                            re(() {
                              isLoading = false;
                            });
                            return false;
                          }).then((val) async {
                            if (val) {
                              getIt.get<AppLocalService>().currentUser?.fullName = fullName;
                              getIt.get<AppLocalService>().currentUser?.phoneNumber = phoneNo;
                              await getIt.get<AppLocalService>().login(getIt.get<AppLocalService>().currentUser!);
                              re(() {
                                isLoading = false;
                              });
                              context.pop(true);
                            }
                          });
                        },
                        child: isLoading
                            ? const SizedBox(
                                width: 14,
                                height: 14,
                                child: CircularProgressIndicator(
                                  strokeWidth: 1.5,
                                  color: AppColors.kWhite,
                                ),
                              )
                            : const Text("Save"),
                      );
                    }),
                  ),
                ],
              ),
              24.spaceH,
            ],
          ),
        );
      },
    );
  }
}
