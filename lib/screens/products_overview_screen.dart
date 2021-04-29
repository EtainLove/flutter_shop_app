import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

import '../widgets/product_grid.dart';
// import '../providers/products.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showFavoritesOnly = false;

  @override
  Widget build(BuildContext context) {
    // final productsContainer = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text('MyShap'), actions: [
        PopupMenuButton(
          onSelected: (FilterOptions selectedValue) {
            setState(() {
              if (selectedValue == FilterOptions.Favorites) {
                // productsContainer.showFavoritesOnly();
                _showFavoritesOnly = true;
              } else {
                // productsContainer.showAll();
                _showFavoritesOnly = false;
              }
            });
          },
          icon: Icon(Icons.more_vert),
          itemBuilder: (_) => [
            PopupMenuItem(
              child: Text('Only Favorites'),
              value: FilterOptions.Favorites,
            ),
            PopupMenuItem(
              child: Text('Show All'),
              value: FilterOptions.All,
            ),
          ],
        ),
      ]),
      body: ProductGrid(_showFavoritesOnly),
    );
  }
}
