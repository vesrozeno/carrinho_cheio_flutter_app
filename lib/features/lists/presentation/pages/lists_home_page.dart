import 'package:carrinho_cheio/core/navigator/app_navigator.dart';
import 'package:carrinho_cheio/core/widgets/custom_app_bar.dart';
import 'package:carrinho_cheio/core/widgets/custom_elevated_button.dart';
import 'package:carrinho_cheio/features/lists/presentation/bloc/lists.bloc.dart';
import 'package:carrinho_cheio/features/lists/presentation/pages/lists_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carrinho_cheio/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:carrinho_cheio/features/auth/presentation/bloc/auth_state.dart';
import 'package:carrinho_cheio/features/lists/presentation/bloc/lists_state.dart';
import 'package:carrinho_cheio/features/lists/presentation/bloc/lists_status_enum.dart';
import 'package:carrinho_cheio/features/lists/presentation/bloc/lists_event.dart';

class ListsHomePage extends StatefulWidget {
  const ListsHomePage({super.key});

  @override
  State<ListsHomePage> createState() => _ListsHomePageState();
}

class _ListsHomePageState extends State<ListsHomePage> {
  @override
  void initState() {
    super.initState();

    final authState = context.read<AuthBloc>().state;
    final userId = authState.user?.id;

    if (userId != null) {
      context.read<ListsBloc>().add(
        LoadListsRequested(),
      );
    }
  }

  Future<void> _onRefresh() async {
    final authState = context.read<AuthBloc>().state;
    final userId = authState.user?.id;

    if (userId != null) {
      context.read<ListsBloc>().add(
        LoadListsRequested(),
      );
    }
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
            BlocBuilder<ListsBloc, ListsState>(
              builder: (context, state) {
                final isLoading = state.status == ListsStatus.loading;

                return ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          final name = controller.text.trim();
                          final userId = context.read<AuthBloc>().state.user?.id;

                          if (name.isEmpty || userId == null) return;

                          context.read<ListsBloc>().add(
                            CreateList(
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
        //TODO: bloc de lista e snack
      },
      child: Scaffold(
        floatingActionButton: CustomElevatedButton(
          onPressed: () {
            _openCreateListDialog(context);
          },
          prefixIcon: Icons.add,
          child: Text('Nova lista'),
        ),
        appBar: CustomAppBar(),
        body: BlocBuilder<ListsBloc, ListsState>(
          builder: (context, state) {
            switch (state.status) {
              case ListsStatus.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );

              case ListsStatus.error:
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

              case ListsStatus.success:
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
                          AppNavigator.push(ListDetailsPage(list: list));
                        },
                      );
                    },
                  ),
                );

              case ListsStatus.initial:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
