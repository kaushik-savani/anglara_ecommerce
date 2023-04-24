import 'package:anglara_ecommerce/repository/cart_repository.dart';
import 'package:anglara_ecommerce/repository/product_repository.dart';
import 'package:anglara_ecommerce/ui/Homepage/dashboard.dart';
import 'package:anglara_ecommerce/ui/ProductList/product_details.dart';
import 'package:flutter/material.dart';

import '../../model/product_model.dart';

class ProductPage extends StatefulWidget {
  final String category;

  const ProductPage({required this.category});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late ProductRepository _productRepository;

  @override
  void initState() {
    super.initState();
    _productRepository = ProductRepository();
    _productRepository.getProducts(widget.category.toLowerCase());
  }

  @override
  void dispose() {
    _productRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Dashboard(),
                  ));
            },
            icon: const Icon(Icons.arrow_back)),
        title: Text(widget.category),
      ),
      body: StreamBuilder<List<ProductModel>>(
        stream: _productRepository.productsStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
              child: GridView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  ProductModel product = snapshot.data![index];
                  return Card(
                    elevation: 2,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetailsPage(product: product),
                              ),
                            );
                          },
                          child: Container(
                            height: 140,
                            width: 130,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child:
                                Image.network(product.image!, fit: BoxFit.fill),
                          ),
                        ),
                        SizedBox(
                          height: 80,
                          child: ListView(
                            children: [
                              Text(
                                product.title!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '\$${product.price!}',
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    await CartRepository().addToCart(product);
                                  },
                                  child: const Text('Add to cart'),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    mainAxisExtent: 240),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
