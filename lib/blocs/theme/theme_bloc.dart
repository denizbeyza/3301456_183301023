import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial(color: Colors.orange)) {
    on<ChangeThemeEvent>(_themeChangeEvent);
  }

  FutureOr<void> _themeChangeEvent(
      ChangeThemeEvent event, Emitter<ThemeState> emit) {
    emit(ThemeInitial(color: event.color));
  }
}
