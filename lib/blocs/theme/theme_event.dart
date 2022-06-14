part of 'theme_bloc.dart';

abstract class ThemeEvent {
  const ThemeEvent();
}

class ChangeThemeEvent extends ThemeEvent {
  MaterialColor color;
  ChangeThemeEvent({required this.color});
}

class GetThemeEvent extends ThemeEvent {}