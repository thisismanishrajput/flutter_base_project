import 'package:clean_arch_base/src/features/products/domain/entities/product.dart';
import 'package:clean_arch_base/src/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({required this.product, super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(product.thumbnail)),
        title: Text(
          product.title,
          style: context.h6,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          product.description,
          style: context.bodyMd,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text('\$${product.price}', style: context.h6),
            Text('⭐ ${product.rating}', style: context.bodySm),
          ],
        ),
      ),
    );
  }
}
