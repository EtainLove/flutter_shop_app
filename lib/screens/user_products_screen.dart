import 'package:flutter/material.dart';
import 'package:flutter_shop_app/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../widgets/user_product_item.dart';
import './edit_product_screen.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user-products';

  Future<void> _refreshProducts(BuildContext context) async {
    return await Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    // final productsData = Provider.of<Products>(context);
    print('rebuilding....');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          // RefreshIndicator 가 실행되었을때 리빌드 되는 것을 방지 하기위해 Consumer를 사용하여 분리한다.
          return RefreshIndicator(
            onRefresh: () => _refreshProducts(context),
            child: Consumer<Products>(
              builder: (ctx, productData, child) {
                return Padding(
                  padding: EdgeInsets.all(8),
                  child: ListView.builder(
                    itemCount: productData.items.length,
                    itemBuilder: (ctx, i) => Column(
                      children: [
                        UserProductItem(
                          productData.items[i].id,
                          productData.items[i].title,
                          productData.items[i].imageUrl,
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
