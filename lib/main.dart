import 'package:carrinho_cheio/core/routes/app_router.dart';
import 'package:carrinho_cheio/features/shopping_lists/domain/entities/shopping_list_entity.dart';
import 'package:carrinho_cheio/features/shopping_lists/presentation/bloc/shopping_lists.bloc.dart';
import 'package:carrinho_cheio/features/shopping_lists/presentation/pages/shopping_list_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:carrinho_cheio/core/bootstrap/app_bootstrap.dart';
import 'package:carrinho_cheio/features/auth/presentation/pages/login_page.dart';
import 'package:carrinho_cheio/features/auth/presentation/pages/register_page.dart';
import 'package:carrinho_cheio/features/shopping_lists/presentation/pages/home_page.dart';
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
    return MaterialApp(
      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.login: (_) => const LoginPage(),
        AppRoutes.register: (_) => const RegisterPage(),
        AppRoutes.home: (_) => const HomePage(),
        AppRoutes.shoppingListDetails: (context) {
          final ShoppingListEntity list = ModalRoute.of(context)!.settings.arguments as ShoppingListEntity;

          return ShoppingListDetailsPage(list: list);
        },
      },
    );
  }
}
