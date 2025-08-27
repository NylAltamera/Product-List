import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/product_model.dart';
import '../services/api_manager.dart';
import '../widgets/widget_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  List<Product> products = [];
  bool isLoading = false;
  int skip = 0;
  bool allLoaded = false;

  @override
  void initState() {
    super.initState();
    _fetchMore();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        _fetchMore();
      }
    });
  }

  Future<void> _fetchMore() async {
    if (isLoading || allLoaded) return;
    setState(() => isLoading = true);

    List<Product> newProducts = await ApiService.fetchProducts(skip);
    if (newProducts.isEmpty) {
      allLoaded = true;
    } else {
      skip += 15;
      products.addAll(newProducts);
    }

    setState(() => isLoading = false);
  }

  void _showDetails(Product product) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView( 
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Center(
                      child: Image.network(product.thumbnail)
                    ),
                    SizedBox(height: 15),
                    Text(
                      product.title,
                      style: WidgetStyles.productTitleStyle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 5),
                    Text("Brand: ${product.brand}", 
                      style: WidgetStyles.productBrandStyle,
                    ),
                    SizedBox(height: 5),
                    Text("Price: \$${product.price.toStringAsFixed(2)}"),
                    SizedBox(height: 10),
                    Text("Description:", 
                      style: WidgetStyles.descriptionHeadingStyle,
                    ),
                    Text(product.description),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.close),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(Product product, int index) {
    return GestureDetector(
      onTap: () => _showDetails(product),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Text(
              '${index + 1}',
              style: WidgetStyles.productCardIndexStyle,
            ),
            SizedBox(width: 15),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          style: WidgetStyles.productCardTitleStyle,
                        ),
                        SizedBox(height: 5),
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: WidgetStyles.productCardPriceStyle,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: product.thumbnail,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FStore - Product Viewer', 
          style: TextStyle(
            fontWeight: FontWeight.bold
          )
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: products.length + (isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < products.length) {
            return _buildProductCard(products[index], index);
          } else {
            return Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: CircularProgressIndicator()
              ),
            );
          }
        },
      ),
    );
  }
}
