import 'package:bp_question_2/features/product_list/ProductCard.dart';
import 'package:bp_question_2/features/product_list/product_detail_modal.dart';
import 'package:bp_question_2/features/product_list/product_list_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/product.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Products'),
      ),
      body: _buildBody(context, ref),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref) {
    Status status = ref.watch(productNotifierProvider).status;
    List<Product> productList = ref.watch(productNotifierProvider).products;

    switch (status) {
      case Status.loading:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case Status.error:
        return _buildErrorPage(context, ref);
      case Status.idle:
        return productList.isEmpty
            ? _buildEmptyState(context, ref)
            : _buildProducts(context, ref);
    }
  }

  Widget _buildProducts(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productNotifierProvider).products;
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (ctx, idx) => ProductCard(
        onPressed: () {
          // showModalBottomSheet(
          //   context: context,
          //   isScrollControlled: true,
          //   builder: (ctx) => ProductBottomSheet(product: products[idx]),
          // );
          showDialog(
            context: context,
            builder: (ctx) => ProductModal(product: products[idx]),
          );
        },
        product: products.elementAt(idx),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, WidgetRef ref) {
    return const Center(
      child: Text('No products Available'),
    );
  }

  Widget _buildErrorPage(BuildContext context, WidgetRef ref) {
    String? errorMessage = ref.watch(productNotifierProvider).message;
    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            Icons.error_outline,
            color: Theme.of(context).colorScheme.error,
            size: 36,
          ),
          if (errorMessage != null && errorMessage.isNotEmpty)
            Text(
              errorMessage,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ElevatedButton(
            onPressed: _reload(ref),
            child: Text('Reload'),
          ),
        ],
      ),
    );
  }

  VoidCallback _reload(WidgetRef ref) {
    return () {
      ref.refresh(productNotifierProvider);
    };
  }
}
