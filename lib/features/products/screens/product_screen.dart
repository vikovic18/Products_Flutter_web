import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:products_web/common_widgets/body_text.dart';
import 'package:products_web/features/products/controllers/product_controller.dart';
import 'package:products_web/features/products/widgets/products_grid_view.dart';
import 'package:products_web/models/products_model.dart';
import 'package:products_web/utils/colors.dart';

class ProductsScreen extends ConsumerStatefulWidget {
  const ProductsScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends ConsumerState<ProductsScreen> {
  final TextEditingController searchController = TextEditingController();
  List<ProductModel> searchList = [];

  
  Widget _containerCategory(i, height, width) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.blackColor)),
      child: const Center(
        child: BodyText(
            color: AppColors.blackColor,
            size: 15,
            text: 'Converse shoes',
            weight: FontWeight.w400),
      ),
    );
  }

  Widget _adidaImage(i) {
    return Row(children: [
      Image.asset(
        "assets/images/adidas.png",
        height: 50,
        width: 50,
      ),
      const SizedBox(
        width: 19,
      )
    ]);
  }


  void filterProducts(String query) {
    final allProductList = ref.watch(productControllerProvider).allproducts;
    if (query.isNotEmpty) {
      List<ProductModel> dummyListData = [];
      for (var item in allProductList) {
        if (item.title!.s!.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      }
      setState(() {
        searchList.clear();
        searchList.addAll(dummyListData);
      });
    }
    else {
      setState(() {
        searchList.clear();
        searchList.addAll(allProductList);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(size.width, size.height * 0.12),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: size.height * 0.10,
                width: size.width,
                color: AppColors.redColor,
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Card(
                    elevation: 5,
                    color: AppColors.whiteColor,
                    child: SizedBox(
                      height: size.width < 700
                          ? size.height * 0.09
                          : size.height * 0.07,
                      width: size.width < 700
                          ? size.width * 0.80
                          : size.width * 0.40,
                      child: Center(
                        child: Padding(
                            padding: const EdgeInsets.only(left: 21, right: 21),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: TextField(
                                      onChanged: (value) {
                                        filterProducts(value);
                                      },
                                      controller: searchController,
                                      decoration: InputDecoration(
                                          hintStyle: GoogleFonts.inter(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.blackColor),
                                          prefixIcon: const Icon(Icons.search),
                                          border: InputBorder.none,
                                          hintText: 'Search for a product')),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 7),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const VerticalDivider(
                                        width: 20,
                                        thickness: 1,
                                        indent: 14,
                                        // endIndent: 0,
                                        color: AppColors.blackColor,
                                      ),
                                      size.width >= 850
                                          ? const BodyText(
                                              color: AppColors.blackColor,
                                              size: 15,
                                              text: 'category',
                                              weight: FontWeight.w400)
                                          : const SizedBox(),
                                      SizedBox(
                                        width: size.width * 0.01,
                                      ),
                                      const Icon(
                                        Icons.expand_more,
                                        size: 25,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )),
                      ),
                    ),
                  ))
            ],
          )),
      body: SingleChildScrollView(
        child: Column(children: [
          size.width <= 800
              ? const SizedBox(
                  height: 20,
                )
              : const SizedBox(),
          const Center(
              child: BodyText(
                  color: AppColors.blackColor,
                  size: 35,
                  text: 'My Products',
                  weight: FontWeight.w700)),
          SizedBox(height: size.height * 0.04),
          size.width > 800
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                      5,
                      (i) => _containerCategory(
                          i, size.height * 0.07, size.width * 0.17)),
                )
              : const SizedBox(),
          SizedBox(
            height: size.height * 0.04,
          ),
          Container(
            height: size.height,
            color: AppColors.greyColor,
            child: Column(
              children: [
                size.width > 800
                    ? Padding(
                        padding: EdgeInsets.only(
                            top: size.height * 0.08, left: 25, right: 25),
                        child: Card(
                          elevation: 2,
                          child: SizedBox(
                            height: size.height * 0.14,
                            width: size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        "assets/images/adidda_logo.png",
                                        height: 82,
                                        width: 82,
                                      ),
                                    ),
                                    const BodyText(
                                        color: AppColors.blackColor,
                                        size: 20,
                                        text: 'Adidda Sport wears',
                                        weight: FontWeight.w700),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: List.generate(
                                          5, (i) => _adidaImage(i)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/images/adidas.png",
                                            height: 50,
                                            width: 50,
                                            fit: BoxFit.contain,
                                          ),
                                          Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                color: Colors.black54,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: const Center(
                                              child: BodyText(
                                                  color: AppColors.whiteColor,
                                                  size: 20,
                                                  text: '10+',
                                                  weight: FontWeight.w700),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
                SizedBox(height: size.height * 0.06),
                ProductsGridView(
                  size: size,
                  searchList: searchList,
                  searchText: searchController.text.trim(),
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
