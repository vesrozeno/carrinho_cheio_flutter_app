import 'package:carrinho_cheio/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:carrinho_cheio/core/navigator/app_navigator.dart';
import 'package:carrinho_cheio/core/theme/theme_controller.dart';
import 'package:carrinho_cheio/core/utils/screen_size.dart';
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
            padding: EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/logo.png',
                  height: 32,
                ),

                const Spacer(),

                IconButton(
                  onPressed: ThemeController.toggleTheme,
                  icon: ThemeController.isDarkMode ? const Icon(Icons.light_mode_outlined) : const Icon(Icons.dark_mode_outlined),
                  color: AppColors.white,
                ),

                SizedBox(width: 40),

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
