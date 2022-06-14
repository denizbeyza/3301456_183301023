import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/theme/utils.dart';
import '../../static/theme.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final ThemeUtils _utils = ThemeUtils();
  ThemeBloc() : super(ThemeInitial()) {
    on<ChangeThemeEvent>(_themeChangeEvent);
    on<GetThemeEvent>(_getThemeEvent);
  }

  Future<FutureOr<void>> _themeChangeEvent(
      ChangeThemeEvent event, Emitter<ThemeState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("color", Static.colors.indexOf(event.color));
    emit(ColorChangeState(color: event.color));
  }

  Future<FutureOr<void>> _getThemeEvent(
      GetThemeEvent event, Emitter<ThemeState> emit) async {
    MaterialColor color = await _utils.getTheme();
    emit(ColorChangeState(color: color));
  }
}
