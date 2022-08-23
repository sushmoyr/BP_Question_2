import 'package:bp_question_2/features/product_list/product_service.dart';
import 'package:bp_question_2/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Status { loading, error, idle }

@immutable
class ProductListState {
  final Status status;
  final String? message;
  final List<Product> products;

  const ProductListState(
      {required this.status, this.message, required this.products});

  factory ProductListState.initial() => const ProductListState(
        status: Status.idle,
        products: <Product>[],
      );

  ProductListState copyWith({
    Status? status,
    String? message,
    List<Product>? products,
  }) =>
      ProductListState(
        status: status ?? this.status,
        products: products ?? this.products,
        message: message ?? this.message,
      );
}

class ProductNotifier extends StateNotifier<ProductListState> {
  ProductNotifier(this.productService) : super(ProductListState.initial()) {
    fetchProducts();
  }

  final ProductService productService;

  fetchProducts() async {
    state = state.copyWith(status: Status.loading);

    try {
      final products = await productService.fetchProducts();
      state = state.copyWith(status: Status.idle, products: products);
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      state = state.copyWith(status: Status.error, message: e.toString());
    }
  }
}

final productNotifierProvider =
    StateNotifierProvider<ProductNotifier, ProductListState>(
        (ref) => ProductNotifier(ref.watch(productServiceProvider)));
