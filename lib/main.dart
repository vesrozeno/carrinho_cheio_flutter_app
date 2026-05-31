import 'package:carrinho_cheio/core/navigator/app_navigator.dart';
import 'package:carrinho_cheio/core/theme/app_theme.dart';
import 'package:carrinho_cheio/core/theme/theme_controller.dart';
import 'package:carrinho_cheio/features/shopping_lists/presentation/bloc/shopping_lists.bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:carrinho_cheio/core/bootstrap/app_bootstrap.dart';
import 'package:carrinho_cheio/features/auth/presentation/pages/login_page.dart';
import 'package:carrinho_cheio/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:carrinho_cheio/injection/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();
  await setupDependencies();
  await AppBootstrap.initialize();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => getIt<AuthBloc>()),
        BlocProvider<ShoppingListsBloc>(create: (_) => getIt<ShoppingListsBloc>()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.themeMode,
      builder: (_, mode, _) {
        return MaterialApp(
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: mode,
          navigatorKey: AppNavigator.navigatorKey,
          scaffoldMessengerKey: AppNavigator.scaffoldKey,
          initialRoute: '/login',
          routes: {
            '/login': (_) => const LoginPage(),
          },
        );
      },
    );
  }
}
