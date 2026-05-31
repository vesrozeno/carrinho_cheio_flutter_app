import 'package:carrinho_cheio/core/widgets/app_toast.dart';
import 'package:carrinho_cheio/features/lists/presentation/bloc/lists.bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carrinho_cheio/features/lists/presentation/bloc/lists_state.dart';
import 'package:carrinho_cheio/features/lists/presentation/bloc/lists_status_enum.dart';

class ListsBasePage extends StatefulWidget {
  const ListsBasePage({
    super.key,
    required this.mainContent,
  });

  final Widget mainContent;

  @override
  State<ListsBasePage> createState() => _ListsBasePageState();
}

class _ListsBasePageState extends State<ListsBasePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ListsBloc, ListsState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        switch (state.status) {
          case ListsStatus.success:
            AppToast.showError(message: state.message ?? 'Ação realizada com sucesso!');
          case ListsStatus.error:
            AppToast.showError(message: state.message ?? 'Erro ao gerenciar listas');
          case ListsStatus.loading:
          case ListsStatus.initial:
            break;
        }
      },
      child: widget.mainContent,
    );
  }
}
