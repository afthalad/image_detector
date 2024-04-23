import '../../presentation/screens/home_screen.dart';
import '../../presentation/screens/splash_screen.dart';

class AppRoutes {
  static const splashScreen = 'splas_screen';
  static const homeScreen = 'home_screen';
  static const screwSelectScreen = 'screw_select_screen';

  static final routes = {
    homeScreen: (context) => const HomeScreen(),
    splashScreen: (context) => const SplashScreen(),
    // screwSelectScreen: (context) =>  ScrewSelectScreen(),
  };
}
