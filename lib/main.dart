import 'package:carrinho_cheio/core/events/ui_event.dart';
import 'package:carrinho_cheio/core/navigator/app_navigator.dart';
import 'package:carrinho_cheio/core/theme/app_theme.dart';
import 'package:carrinho_cheio/core/theme/theme_cubit.dart';
import 'package:carrinho_cheio/core/widgets/app_toast.dart';
import 'package:carrinho_cheio/features/auth/presentation/bloc/auth_event.dart';
import 'package:carrinho_cheio/features/auth/presentation/bloc/auth_state.dart';
import 'package:carrinho_cheio/features/lists/presentation/bloc/lists.bloc.dart';
import 'package:carrinho_cheio/features/lists/presentation/bloc/lists_event.dart';
import 'package:carrinho_cheio/features/lists/presentation/bloc/lists_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:carrinho_cheio/core/bootstrap/app_bootstrap.dart';
import 'package:carrinho_cheio/features/auth/presentation/pages/login_page.dart';
import 'package:carrinho_cheio/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:carrinho_cheio/injection/injection.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await dotenv.load();
  await setupDependencies();
  await AppBootstrap.initialize();

  await getIt<ThemeCubit>().initialize();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => getIt<AuthBloc>()),
        BlocProvider<ListsBloc>(create: (_) => getIt<ListsBloc>()),
        BlocProvider<ThemeCubit>(create: (_) => getIt<ThemeCubit>()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return ToastificationWrapper(
          child: MultiBlocListener(
            listeners: [
              BlocListener<AuthBloc, AuthState>(
                listenWhen: (previous, current) => previous.uiEvent != current.uiEvent,
                listener: (context, state) {
                  final event = state.uiEvent;

                  if (event == null) return;

                  if (event.type == UiEventType.error) {
                    AppToast.showError(message: event.message);
                  } else {
                    AppToast.showSuccess(message: event.message);
                  }

                  context.read<AuthBloc>().add(
                    ClearAuthUIEvent(),
                  );
                },
              ),

              BlocListener<ListsBloc, ListsState>(
                listenWhen: (previous, current) => previous.uiEvent != current.uiEvent,
                listener: (context, state) {
                  final event = state.uiEvent;

                  if (event == null) return;

                  if (event.type == UiEventType.error) {
                    AppToast.showError(message: event.message);
                  } else {
                    AppToast.showSuccess(message: event.message);
                  }

                  context.read<ListsBloc>().add(
                    ClearUIEvent(),
                  );
                },
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: themeMode,
              navigatorKey: AppNavigator.navigatorKey,
              scaffoldMessengerKey: AppNavigator.scaffoldKey,
              initialRoute: '/login',
              routes: {
                '/login': (_) => const LoginPage(),
              },
            ),
          ),
        );
      },
    );
  }
}
