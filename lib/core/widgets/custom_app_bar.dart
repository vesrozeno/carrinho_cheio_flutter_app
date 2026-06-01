import 'package:carrinho_cheio/core/navigator/app_navigator.dart';
import 'package:carrinho_cheio/core/theme/app_colors.dart';
import 'package:carrinho_cheio/core/theme/theme_cubit.dart';
import 'package:carrinho_cheio/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      flexibleSpace: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 45,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              Row(
                spacing: screenWidth * 0.04,
                children: [
                  BlocBuilder<ThemeCubit, ThemeMode>(
                    builder: (context, themeMode) {
                      return IconButton(
                        tooltip: 'Alterar tema',
                        onPressed: () {
                          context.read<ThemeCubit>().toggleTheme();
                        },
                        icon: Icon(
                          themeMode == ThemeMode.dark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                        ),
                        color: AppColors.white,
                      );
                    },
                  ),
                  IconButton(
                    tooltip: 'Sair',
                    onPressed: () {
                      AppNavigator.pushAndRemoveUntil(
                        const LoginPage(),
                      );
                    },
                    icon: const Icon(
                      Icons.logout_outlined,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
