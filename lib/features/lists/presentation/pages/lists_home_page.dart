import 'package:carrinho_cheio/core/navigator/app_navigator.dart';
import 'package:carrinho_cheio/core/widgets/custom_app_bar.dart';
import 'package:carrinho_cheio/core/widgets/custom_elevated_button.dart';
import 'package:carrinho_cheio/core/widgets/custom_text_field.dart';
import 'package:carrinho_cheio/core/widgets/generic_dialog.dart';
import 'package:carrinho_cheio/core/widgets/will_pop_scope.dart';
import 'package:carrinho_cheio/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:carrinho_cheio/features/lists/domain/entities/list_entity.dart';
import 'package:carrinho_cheio/features/lists/presentation/bloc/lists.bloc.dart';
import 'package:carrinho_cheio/features/lists/presentation/bloc/lists_event.dart';
import 'package:carrinho_cheio/features/lists/presentation/bloc/lists_state.dart';
import 'package:carrinho_cheio/features/lists/presentation/bloc/lists_status_enum.dart';
import 'package:carrinho_cheio/features/lists/presentation/pages/lists_details_page.dart';
import 'package:carrinho_cheio/injection/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_validators/form_validator.dart';

class ListsHomePage extends StatefulWidget {
  const ListsHomePage({super.key});

  @override
  State<ListsHomePage> createState() => _ListsHomePageState();
}

class _ListsHomePageState extends State<ListsHomePage> {
  Future<void> _onRefresh() async {
    context.read<ListsBloc>().add(
      LoadListsEvent(),
    );
  }

  void _openCreateListDialog() {
    final controller = TextEditingController();

    GenericDialog.show(
      context: context,
      title: 'Criar nova lista',
      icon: Icons.assignment_outlined,
      confirmButtonText: 'Criar',
      content: CustomTextField(
        controller: controller,
        labelText: 'Nome',
        inputFormatters: [
          LengthLimitingTextInputFormatter(20),
        ],
        validator: (value) {
          return Validator.required(
            errorMessage: 'Insira o nome da lista',
          )(value);
        },
      ),
      onConfirm: () {
        context.read<ListsBloc>().add(
          CreateListEvent(
            name: controller.text.trim(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        final shouldPop = await showWillPopScopeDialog(context);
        if (shouldPop && context.mounted) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        floatingActionButton: CustomElevatedButton(
          onPressed: _openCreateListDialog,
          prefixIcon: Icons.add_circle_outline,
          child: const Text('Nova lista'),
        ),
        appBar: CustomAppBar(),
        body: BlocBuilder<ListsBloc, ListsState>(
          builder: (context, state) {
            switch (state.status) {
              case ListsStatus.loadingLists:
                return const Center(
                  child: CircularProgressIndicator(),
                );

              case ListsStatus.error:
              case ListsStatus.initial:
                return _ErrorView(
                  onRetry: _onRefresh,
                );

              case ListsStatus.loadingProductChange:
              case ListsStatus.loaded:
              case ListsStatus.success:
                return _ContentView(
                  lists: state.lists ?? [],
                );
            }
          },
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({
    required this.onRetry,
  });

  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Erro ao carregar listas',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            CustomElevatedButton(
              onPressed: onRetry,
              child: const Text('Tentar novamente'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContentView extends StatelessWidget {
  const _ContentView({
    required this.lists,
  });

  final List<ListEntity> lists;

  @override
  Widget build(BuildContext context) {
    final userName = getIt<AuthBloc>().state.user?.name.trim() ?? '';

    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            userName.isNotEmpty ? 'Olá, $userName!' : 'Olá!',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 420,
                ),
                child: lists.isEmpty
                    ? const Center(
                        child: Text(
                          'Você ainda não possui listas',
                        ),
                      )
                    : _ListsView(
                        lists: lists,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ListsView extends StatelessWidget {
  const _ListsView({
    required this.lists,
  });

  final List<ListEntity> lists;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Aqui estão suas listas:',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 15),
        Expanded(
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: lists.length,
            separatorBuilder: (_, _) => const SizedBox(height: 10),
            itemBuilder: (_, index) {
              return _ListCard(
                list: lists[index],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ListCard extends StatelessWidget {
  const _ListCard({
    required this.list,
  });

  final ListEntity list;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(20),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          AppNavigator.push(
            ListDetailsPage(
              listId: list.id,
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    list.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    list.total == 0 ? '0 itens' : '${list.current} de ${list.total} itens comprados',
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
