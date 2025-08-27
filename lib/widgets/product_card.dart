import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/product_model.dart';
import 'widget_styles.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  final int index;

  const ProductItem({
    super.key,
    required this.product,
    required this.onTap,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Text(
        "${index + 1}", 
        style: WidgetStyles.productCardIndexStyle,
      ),
      title: Text(
        product.title,
        style: WidgetStyles.productCardTitleStyle,
      ),
      subtitle: Text(
        "\$${product.price.toStringAsFixed(2)}",
        style: WidgetStyles.productCardPriceStyle,
      ),
      trailing: SizedBox(
        width: 60,
        child: CachedNetworkImage(imageUrl: product.thumbnail),
      ),
      onTap: onTap,
    );
  }
}
