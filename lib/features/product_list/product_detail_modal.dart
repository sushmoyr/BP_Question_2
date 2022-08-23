import 'package:bp_question_2/models/product.dart';
import 'package:flutter/material.dart';

class ProductModal extends StatelessWidget {
  const ProductModal({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Description',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Text(
              product.description!,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            // Chip(
            //   label: Text(
            //     product.category!,
            //     style: Theme.of(context).textTheme.labelMedium,
            //   ),
            // ),
            // Row(
            //   mainAxisSize: MainAxisSize.min,
            //   children: [
            //     const Icon(
            //       Icons.star,
            //       color: Colors.yellow,
            //       size: 16,
            //     ),
            //     Text(product.rating!.rate!.toStringAsFixed(1)),
            //     const Spacer(),
            //     Text('${product.rating!.count} ratings')
            //   ],
            // ),
            // const SizedBox(height: 4),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     Text(
            //       'BDT ${product.price!.toStringAsFixed(1)}',
            //       style: Theme.of(context).textTheme.titleMedium!.copyWith(
            //             color: Theme.of(context).colorScheme.tertiary,
            //             decoration: TextDecoration.lineThrough,
            //           ),
            //     ),
            //     const SizedBox(width: 8),
            //     Text(
            //       'BDT ${(product.price! * .74).toStringAsFixed(1)}',
            //       style: Theme.of(context).textTheme.titleMedium!.copyWith(
            //             color: Theme.of(context).colorScheme.primary,
            //           ),
            //     )
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
