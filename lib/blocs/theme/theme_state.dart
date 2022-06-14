part of 'theme_bloc.dart';

abstract class ThemeState {
  const ThemeState();
  

}

class ThemeInitial extends ThemeState {
      MaterialColor color;
  ThemeInitial({required this.color});
}


