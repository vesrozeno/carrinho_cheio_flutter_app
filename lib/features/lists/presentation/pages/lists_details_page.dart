import 'package:carrinho_cheio/features/lists/presentation/bloc/lists.bloc.dart';
import 'package:carrinho_cheio/features/lists/presentation/bloc/lists_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/list_entity.dart';

class ListDetailsPage extends StatefulWidget {
  const ListDetailsPage({
    super.key,
    required this.list,
  });

  final ListEntity list;

  @override
  State<ListDetailsPage> createState() => _ListDetailsPageState();
}

class _ListDetailsPageState extends State<ListDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(widget.list.title),
      ),

      body: widget.list.products.isEmpty
          ? const Center(
              child: Text('Nenhum produto na lista'),
            )
          : ListView.builder(
              itemCount: widget.list.products.length,
              itemBuilder: (context, index) {
                final product = widget.list.products[index];

                return ListTile(
                  leading: Checkbox(
                    value: product.isChecked,
                    onChanged: (value) {
                      context.read<ListsBloc>().add(
                        CheckProduct(
                          listId: widget.list.id,
                          productName: product.name,
                          isChecked: value ?? false,
                        ),
                      );
                    },
                  ),
                  title: Text(product.name),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      context.read<ListsBloc>().add(
                        RemoveProduct(
                          listId: widget.list.id,
                          productName: product.name,
                        ),
                      );
                    },
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openAddProductDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _openAddProductDialog() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Adicionar produto'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Nome do produto',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                final name = controller.text.trim();

                if (name.isEmpty) return;

                context.read<ListsBloc>().add(
                  AddProduct(
                    listId: widget.list.id,
                    productName: name,
                  ),
                );

                Navigator.pop(context);
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }
}
