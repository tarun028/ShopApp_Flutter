import 'package:flutter/material.dart';

import '../models/products_model.dart';
import '../services/api_handler.dart';
import '../widget/feeds_widget.dart';

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  List<ProductsModel> productsList = [];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<void> getProducts() async {
    productsList = await APIHandler.getAllProducts(limit: '10');

    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 4,
        title: const Text('All Products'),
      ),
      body:productsList.isEmpty?Container(): GridView.builder(
          //shrinkWrap: true,
          //physics: const NeverScrollableScrollPhysics(),
          itemCount: productsList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 0.0,
              mainAxisSpacing: 0.0,
              childAspectRatio: 0.7),
          itemBuilder: (ctx, index) {
            return FeedsWidget(
              imageUrl: productsList[index].images![0],
              title: productsList[index].title.toString(),
            );
          }),
    );
  }
}
