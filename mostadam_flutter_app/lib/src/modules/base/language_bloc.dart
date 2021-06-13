

import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:mostadam_flutter_app/src/components/SharedPreference.dart';

import 'language_model.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageState(Locale('ar', '')));

  @override
  Stream<LanguageState> mapEventToState(LanguageEvent event) async* {
    if (event is LanguageLoadStarted) {
      yield* _mapLanguageLoadStartedToState();
    } else if (event is LanguageSelected) {
      yield* _mapLanguageSelectedToState(event.languageCode);
    }
  }

  Stream<LanguageState> _mapLanguageLoadStartedToState() async* {
    final sharedPrefs = await SharedPreferencesService.instance;

    final defaultLanguageCode = sharedPrefs.languageCode;
    Locale locale;
    if (defaultLanguageCode == null) {
      locale = Locale('ar', '');
      await sharedPrefs.setLanguage(locale.languageCode);
    } else {
      locale = Locale(defaultLanguageCode);
    }

    yield LanguageState(locale);
  }

  Stream<LanguageState> _mapLanguageSelectedToState(Language selectedLanguage) async* {
    final sharedPrefs = await SharedPreferencesService.instance;
    final defaultLanguageCode = sharedPrefs.languageCode;

    if (selectedLanguage == Language.AR && defaultLanguageCode != "ar") {
      yield* _loadLanguage(sharedPreferencesService: sharedPrefs,languageCode: Language.AR.toString().split(".").last.toLowerCase());
    } else if (selectedLanguage == Language.EN && defaultLanguageCode != "en") {
      yield* _loadLanguage(sharedPreferencesService: sharedPrefs,languageCode: Language.EN.toString().split(".").last.toLowerCase());
    }
  }

  Stream<LanguageState> _loadLanguage({SharedPreferencesService sharedPreferencesService, String languageCode, String countryCode = ''}) async* {
    final locale = Locale(languageCode, countryCode);
    await sharedPreferencesService.setLanguage(locale.languageCode);
    yield LanguageState(locale);
  }

}


abstract class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

class LanguageLoadStarted extends LanguageEvent {}

class LanguageSelected extends LanguageEvent {
  final Language languageCode;

  LanguageSelected(this.languageCode) : assert(languageCode != null);

  @override
  List<Object> get props => [languageCode];
}

class LanguageState extends Equatable {
  final Locale locale;
  const LanguageState(this.locale) : assert(locale != null);

  @override
  List<Object> get props => [locale];
}