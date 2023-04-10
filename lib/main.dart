import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/config/config.dart';
import 'package:corso_games_app/cubits/cubits.dart';
import 'package:corso_games_app/firebase_options.dart';
import 'package:corso_games_app/models/models.dart';
import 'package:corso_games_app/repositories/repositories.dart';
import 'package:corso_games_app/screens/screens.dart';
// import 'package:corso_games_app/simple_bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );

  // FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // Bloc.observer = SimpleBlocObserver();
  runApp(const CorsoGames());
}

class CorsoGames extends StatelessWidget {
  const CorsoGames({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => UserRepository(),
        ),
        RepositoryProvider(
          create: (context) => AuthRepository(
            userRepository: context.read<UserRepository>(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
              userRepository: context.read<UserRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => UserBloc(
              authBloc: context.read<AuthBloc>(),
              userRepository: context.read<UserRepository>(),
            )..add(
                LoadUser(
                  context.read<AuthBloc>().state.authUser,
                ),
                // UpdateUser(
                //   user: context.read<AuthBloc>().state.authUser,
                //   userStatus: UserStatus.loading,
                // ),
              ),
          ),
          BlocProvider(
            create: (context) => ColorsSlideBloc()..add(LoadColorsSlide()),
          ),
          BlocProvider(
            create: (context) => ElWordBloc()..add(LoadElWord()),
          ),
          BlocProvider(
            create: (context) => MinesweeperBloc()..add(LoadMinesweeper()),
          ),
          BlocProvider(
            create: (context) => TimerBloc(ticker: const Ticker()),
          ),
          BlocProvider(
            create: (context) => BrightnessCubit(),
          ),
          BlocProvider(
            create: (context) => LoginCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => SignUpCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
        ],
        child: BlocBuilder<BrightnessCubit, Brightness>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: state == Brightness.dark ? darkTheme() : lightTheme(),
              // theme: lightTheme(),
              // darkTheme: darkTheme(),
              initialRoute: SplashScreen.routeName,
              onGenerateRoute: AppRouter.onGenerateRoute,
            );
          },
        ),
      ),
    );
  }
}
