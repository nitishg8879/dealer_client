import 'package:bike_client_dealer/core/services/app_local_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppLocaleCubit extends Cubit<Locale> {
  final AppLocalService _appLocalService;

  AppLocaleCubit(this._appLocalService)
      : super(Locale(_appLocalService.selectedLangauge));

  void changeLocale(String languageCode) {
    _appLocalService.saveNewlanguage();
    emit(Locale(languageCode));
  }
}
