import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/config/config.dart';
import 'package:corso_games_app/cubits/cubits.dart';
import 'package:corso_games_app/firebase_options.dart';
import 'package:corso_games_app/models/models.dart';
import 'package:corso_games_app/repositories/repositories.dart';
// import 'package:corso_games_app/simple_bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

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

  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // Bloc.observer = SimpleBlocObserver();

  SystemChannels.textInput.invokeMethod('TextInput.hide');

  runApp(const CorsoGames());
}

class CorsoGames extends StatelessWidget {
  const CorsoGames({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => DatabaseRepository(),
        ),
        RepositoryProvider(
          create: (context) => AuthRepository(
            userRepository: context.read<DatabaseRepository>(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthenticationCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => BrightnessCubit(),
          ),
          BlocProvider(
            create: (context) => HoneygramBoardsCubit(),
          ),
          BlocProvider(
            create: (context) => NavCubit(),
          ),
          BlocProvider(
            create: (context) => TappyBirdCubit(),
          ),
          BlocProvider(
            create: (context) => UserBloc(
              databaseRepository: context.read<DatabaseRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => AuthBloc(
              authCubit: context.read<AuthenticationCubit>(),
              authRepository: context.read<AuthRepository>(),
              databaseRepository: context.read<DatabaseRepository>(),
              userBloc: context.read<UserBloc>(),
            ),
          ),
          BlocProvider(
            create: (context) => ColorsSlideBloc()..add(LoadColorsSlide()),
          ),
          BlocProvider(
            create: (context) => ElWordBloc()..add(LoadElWord()),
          ),
          BlocProvider(
            create: (context) => HoneygramBloc(
              honeygramCubit: context.read<HoneygramBoardsCubit>(),
            )..add(
                LoadHoneygramBoard(
                  context: context,
                  loadFromFile: true,
                ),
              ),
          ),
          BlocProvider(
            create: (context) => MinesweeperBloc()..add(LoadMinesweeper()),
          ),
          BlocProvider(
            create: (context) => SolitareBloc()..add(LoadSolitare()),
          ),
          BlocProvider(
            create: (context) => SnakeBloc()..add(LoadSnake()),
          ),
          BlocProvider(
            create: (context) => TimerBloc(ticker: const Ticker()),
          ),
        ],
        child: BlocBuilder<BrightnessCubit, Brightness>(
          builder: (context, state) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: goRouter,
              theme: state == Brightness.dark ? darkTheme() : lightTheme(),
            );
          },
        ),
      ),
    );
  }
}
