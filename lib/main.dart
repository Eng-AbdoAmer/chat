import 'package:chat/core/constant/routes.dart';
import 'package:chat/features/auth/presentation/manager/auth_cubit.dart';
import 'package:chat/features/chat_screen/presentation/cubit/chat_screen_cubit.dart';
import 'package:chat/features/home_page/manger/cubit/home_cubit.dart';
import 'package:chat/features/onboarding_splash/presentation/manager/onboarding_cubit.dart';
import 'package:chat/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/bloc_observer/bloc_observer.dart';
import 'core/services/locator.dart';
import 'core/shared/helper_meuthods.dart';
import 'features/onboarding_splash/presentation/pages/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await Firebase.initializeApp(
  //     name: "chat",
  //     options: const FirebaseOptions(
  //         apiKey: "AIzaSyB4XrGRSo_uWUUZ_GeiJCMQY4pADHJxUpw",
  //         appId: "1:597299988262:android:909c05fcf87e6eed0163e7",
  //         messagingSenderId: "597299988262",
  //         projectId: "chat-fc367",
  //         storageBucket: "gs://chat-fc367.appspot.com"));
  Bloc.observer = MyBlocObserver();

  await setUp();

  // final storage =
  //FirebaseStorage.instanceFor(bucket: "gs://chat-fc367.appspot.com");
  // await NotificationServices.initializeNotification();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OnboardingCubit>(
          create: (BuildContext context) => OnboardingCubit(),
        ),
        BlocProvider<AuthCubit>(
          create: (BuildContext context) => AuthCubit(),
        ),
        BlocProvider<HomeCubit>(
          create: (BuildContext context) => HomeCubit()
            ..getUser()
            ..listeners(),
        ),
        BlocProvider<ChatScreenCubit>(create: (context) => ChatScreenCubit()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutesNamed.welcome,
        onGenerateRoute: AppRouter.generateRoute,
        home: const SplashScreen(),
      ),
    );
  }
}
