import 'package:carrinho_cheio/core/navigator/app_navigator.dart';
import 'package:carrinho_cheio/core/theme/app_colors.dart';
import 'package:carrinho_cheio/core/widgets/custom_app_bar.dart';
import 'package:carrinho_cheio/core/widgets/custom_elevated_button.dart';
import 'package:carrinho_cheio/core/widgets/custom_text_field.dart';
import 'package:carrinho_cheio/core/widgets/generic_dialog.dart';
import 'package:carrinho_cheio/features/lists/domain/entities/list_entity.dart';
import 'package:carrinho_cheio/features/lists/domain/entities/product_entity.dart';
import 'package:carrinho_cheio/features/lists/presentation/bloc/lists.bloc.dart';
import 'package:carrinho_cheio/features/lists/presentation/bloc/lists_event.dart';
import 'package:carrinho_cheio/features/lists/presentation/bloc/lists_state.dart';
import 'package:carrinho_cheio/features/lists/presentation/bloc/lists_status_enum.dart';
import 'package:carrinho_cheio/features/lists/presentation/widgets/category_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_validators/form_validator.dart';

class ListDetailsPage extends StatefulWidget {
  const ListDetailsPage({
    super.key,
    required this.listId,
  });

  final int listId;

  @override
  State<ListDetailsPage> createState() => _ListDetailsPageState();
}

class _ListDetailsPageState extends State<ListDetailsPage> {
  void _openAddProductDialog() {
    final controller = TextEditingController();
    int? selectedCategoryId;

    GenericDialog.show(
      context: context,
      title: 'Adicionar produto',
      icon: Icons.add_shopping_cart,
      confirmButtonText: 'Adicionar',
      content: Column(
        spacing: 10,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField(
            controller: controller,
            labelText: 'Nome',
            inputFormatters: [
              LengthLimitingTextInputFormatter(20),
            ],
            validator: (value) {
              return Validator.required(
                errorMessage: 'Insira o nome do produto',
              )(value);
            },
          ),
          CategoryDropdown(
            value: selectedCategoryId,
            onChanged: (value) {
              setState(() {
                selectedCategoryId = value;
              });
            },
          ),
        ],
      ),
      onConfirm: () {
        context.read<ListsBloc>().add(
          AddProductEvent(
            listId: widget.listId,
            productName: controller.text.trim(),
            categoryId: selectedCategoryId ?? 1,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CustomElevatedButton(
        onPressed: _openAddProductDialog,
        prefixIcon: Icons.add_shopping_cart,
        child: const Text('Adicionar produto'),
      ),
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: Column(
          children: [
            const _BackButton(),
            const SizedBox(height: 20),
            BlocBuilder<ListsBloc, ListsState>(
              builder: (context, state) {
                final list = state.lists?.cast<ListEntity?>().firstWhere(
                  (item) => item?.id == widget.listId,
                  orElse: () => null,
                );

                if (list == null) {
                  return const Expanded(
                    child: Center(
                      child: Text('Lista não encontrada'),
                    ),
                  );
                }

                return Expanded(
                  child: _ListContent(
                    list: list,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Material(
        borderRadius: BorderRadius.circular(25),
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: AppNavigator.pop,
          child: const Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.arrow_back_ios,
                  size: 18,
                ),
                SizedBox(width: 10),
                Text('Voltar à tela principal'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ListContent extends StatelessWidget {
  const _ListContent({
    required this.list,
  });

  final ListEntity list;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 420,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 15,
          children: [
            _ListHeader(list: list),
            Expanded(
              child: list.products.isEmpty
                  ? Center(
                      child: Text(
                        'Adicione um produto à lista!',
                      ),
                    )
                  : _ProductsList(list: list),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListHeader extends StatelessWidget {
  const _ListHeader({
    required this.list,
  });

  final ListEntity list;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          list.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        Text(
          list.total == 0 ? '0 itens' : '${list.current} de ${list.total} itens comprados',
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _ProductsList extends StatelessWidget {
  const _ProductsList({
    required this.list,
  });

  final ListEntity list;

  @override
  Widget build(BuildContext context) {
    final products = [...list.products]
      ..sort((a, b) {
        if (a.isChecked == b.isChecked) return 0;
        return a.isChecked ? 1 : -1;
      });
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: products.length,
      separatorBuilder: (_, _) => const SizedBox(height: 10),

      itemBuilder: (_, index) {
        final product = products[index];

        return _ProductTile(
          list: list,
          product: product,
        );
      },
    );
  }
}

class _ProductTile extends StatelessWidget {
  const _ProductTile({
    required this.list,
    required this.product,
  });

  final ListEntity list;
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListsBloc, ListsState>(
      builder: (context, state) {
        final bool isLoading = state.status == ListsStatus.loadingProductChange;

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 10,
                children: [
                  Checkbox(
                    value: product.isChecked,
                    checkColor: AppColors.white,
                    onChanged: isLoading
                        ? null
                        : (value) {
                            context.read<ListsBloc>().add(
                              CheckProductEvent(
                                listId: list.id,
                                productName: product.name,
                                isChecked: value ?? false,
                              ),
                            );
                          },
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: product.isChecked ? TextDecoration.lineThrough : null,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        product.category,
                        style: TextStyle(
                          decoration: product.isChecked ? TextDecoration.lineThrough : null,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              IconButton(
                icon: Icon(Icons.delete_outline, color: isLoading ? AppColors.grey : Theme.of(context).textTheme.displayMedium!.color),
                onPressed: () {
                  isLoading
                      ? null
                      : context.read<ListsBloc>().add(
                          RemoveProductEvent(
                            listId: list.id,
                            productName: product.name,
                          ),
                        );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
