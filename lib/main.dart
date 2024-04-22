import 'package:fastner_detector/core/utils/helpers/app_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/configs/routes.dart';
import '../../bloc/image/image_cubit.dart';
import '../../data/providers/image_provider.dart';
import '../../data/repositories/image_repsitory.dart';
import '../../presentation/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreferences.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var repos = [
      RepositoryProvider<ImageRepository>(
        create: (context) => ImageRepository(ImageDataProvider()),
      ),
    ];
    var providers = [
      BlocProvider<ImageCubit>(
        create: (BuildContext context) => ImageCubit(
          context.read<ImageRepository>(),
        ),
      ),
    ];
    return MultiRepositoryProvider(
      providers: repos,
      child: MultiBlocProvider(
        providers: providers,
        child: MaterialApp(
          title: 'Fastner detector',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme(),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const SplashScreen(),
          initialRoute: AppRoutes.splashScreen,
          // initialRoute: AppRoutes.screwSelectScreen,
          routes: AppRoutes.routes,
        ),
      ),
    );
  }
}
