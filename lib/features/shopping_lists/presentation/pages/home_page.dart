import 'package:carrinho_cheio/core/routes/app_router.dart';
import 'package:carrinho_cheio/features/auth/presentation/bloc/auth_status_enum.dart';
import 'package:carrinho_cheio/features/shopping_lists/presentation/bloc/shopping_lists.bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carrinho_cheio/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:carrinho_cheio/features/auth/presentation/bloc/auth_event.dart';
import 'package:carrinho_cheio/features/auth/presentation/bloc/auth_state.dart';
import 'package:carrinho_cheio/features/shopping_lists/presentation/bloc/shopping_lists_state.dart';
import 'package:carrinho_cheio/features/shopping_lists/presentation/bloc/shopping_lists_status_enum.dart';
import 'package:carrinho_cheio/features/shopping_lists/presentation/bloc/shopping_lists_event.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    final authState = context.read<AuthBloc>().state;
    final userId = authState.user?.id;

    if (userId != null) {
      context.read<ShoppingListsBloc>().add(
        LoadShoppingListsRequested(),
      );
    }
  }

  Future<void> _onRefresh() async {
    final authState = context.read<AuthBloc>().state;
    final userId = authState.user?.id;

    if (userId != null) {
      context.read<ShoppingListsBloc>().add(
        LoadShoppingListsRequested(),
      );
    }
  }

  void _logout() {
    context.read<AuthBloc>().add(LogoutRequested());
  }

  void _openCreateListDialog(BuildContext context) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Nova Lista'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Nome da lista',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            BlocBuilder<ShoppingListsBloc, ShoppingListsState>(
              builder: (context, state) {
                final isLoading = state.status == ShoppingListsStatus.loading;

                return ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          final name = controller.text.trim();
                          final userId = context.read<AuthBloc>().state.user?.id;

                          if (name.isEmpty || userId == null) return;

                          context.read<ShoppingListsBloc>().add(
                            CreateShoppingList(
                              name: name,
                            ),
                          );

                          Navigator.pop(context);
                        },
                  child: isLoading
                      ? const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Criar'),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == AuthStatus.unauthenticated) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.login,
            (route) => false,
          );
        }
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => _openCreateListDialog(context),
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text('Minhas Listas'),
          actions: [
            IconButton(
              onPressed: _logout,
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: BlocBuilder<ShoppingListsBloc, ShoppingListsState>(
          builder: (context, state) {
            switch (state.status) {
              case ShoppingListsStatus.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );

              case ShoppingListsStatus.error:
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          state.message ?? 'Erro ao carregar listas',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: _onRefresh,
                          child: const Text('Tentar novamente'),
                        ),
                      ],
                    ),
                  ),
                );

              case ShoppingListsStatus.success:
                final lists = state.lists ?? [];

                if (lists.isEmpty) {
                  return RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: ListView(
                      children: const [
                        SizedBox(height: 200),
                        Center(
                          child: Text('Você ainda não possui listas'),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: lists.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final list = lists[index];

                      return ListTile(
                        title: Text(list.title),
                        subtitle: Text(
                          list.total == 0 ? '0 itens' : '${list.current} de ${list.total} itens comprados',
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.shoppingListDetails,
                            arguments: list,
                          );
                        },
                      );
                    },
                  ),
                );

              case ShoppingListsStatus.initial:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
