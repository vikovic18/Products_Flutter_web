import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:products_web/common_widgets/error.dart';
import 'package:products_web/features/products/controllers/product_controller.dart';
import 'package:products_web/features/products/widgets/product_widget.dart';
import 'package:products_web/models/products_model.dart';

class ProductsGridView extends ConsumerWidget {
  const ProductsGridView(
      {Key? key,
      required this.size,
      required this.searchText,
      required this.searchList})
      : super(key: key);

  final String searchText;
  final List<ProductModel> searchList;
  final Size size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allProductLists = ref.watch(allProductsProvider);
    return Expanded(
        child: allProductLists.when(
            data: (allProducts) {
              return GridView.builder(
                  shrinkWrap: true,
                  itemCount: searchText.isNotEmpty && searchList.isNotEmpty
                      ? searchList.length
                      : allProducts.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: size.width < 800
                          ? 2
                          : size.width <= 1024
                              ? 3
                              : 4,
                      childAspectRatio: 3 / 2,
                      mainAxisSpacing: 18,
                      crossAxisSpacing: 5),
                  itemBuilder: (BuildContext ctx, int index) {
                    return searchText.isNotEmpty && searchList.isNotEmpty
                        ? ProductWidget(
                            id: searchList[index].id!.s.toString(),
                            size: size,
                            title: searchList[index].title!.s.toString(),
                            price: double.parse(
                                searchList[index].price!.n.toString()),
                            image: searchList[index].image!.s.toString(),
                          )
                        : ProductWidget(
                            id: allProducts[index].id!.s.toString(),
                            size: size,
                            title: allProducts[index].title!.s.toString(),
                            price: double.parse(
                                allProducts[index].price!.n.toString()),
                            image: allProducts[index].image!.s.toString(),
                          );
                  });
            },
            error: (err, trace) {
              return ErrorScreen(error: err.toString());
            },
            loading: () => const SizedBox()));
  }
}
