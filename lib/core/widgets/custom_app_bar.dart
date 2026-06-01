import 'package:carrinho_cheio/core/theme/app_colors.dart';
import 'package:carrinho_cheio/core/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carrinho_cheio/core/navigator/app_navigator.dart';
import 'package:carrinho_cheio/features/auth/presentation/pages/login_page.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Row(
              children: [
                SizedBox(
                  height: 46,
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),

                const Spacer(),

                BlocBuilder<ThemeCubit, ThemeMode>(
                  builder: (context, themeMode) {
                    return IconButton(
                      onPressed: () => context.read<ThemeCubit>().toggleTheme(),
                      icon: themeMode == ThemeMode.dark ? const Icon(Icons.light_mode_outlined) : const Icon(Icons.dark_mode_outlined),
                      color: AppColors.white,
                    );
                  },
                ),

                const SizedBox(width: 40),

                IconButton(
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
          ),
        ),
      ),
    );
  }
}
