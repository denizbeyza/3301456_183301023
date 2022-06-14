part of 'theme_bloc.dart';

abstract class ThemeState {
  const ThemeState();
}

class ThemeInitial extends ThemeState {}

class ColorChangeState extends ThemeState {
  MaterialColor color;
  ColorChangeState({required this.color});
}
