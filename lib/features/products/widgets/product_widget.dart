import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:products_web/common_widgets/body_text.dart';
import 'package:products_web/utils/colors.dart';

class ProductWidget extends ConsumerStatefulWidget {
  const ProductWidget(
      {Key? key,
      required this.id,
      required this.size,
      required this.price,
      required this.title,
      required this.image})
      : super(key: key);

  final Size size;
  final String title;
  final double price;
  final String image;
  final String id;

  @override
  _ProductWidgetState createState() => _ProductWidgetState();
}

class _ProductWidgetState extends ConsumerState<ProductWidget> {
  bool isZoomed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isZoomed = !isZoomed;
        });
      },
      child: Card(
        color: AppColors.whiteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: isZoomed ? 20 : 4,
        margin: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  height: widget.size.width < 350
                      ? 60
                      : widget.size.width < 450
                          ? 70
                          : widget.size.width < 600
                              ? 100
                              : widget.size.width < 700
                                  ? 140
                                  : widget.size.width >= 800
                                      ? 110
                                      : widget.size.width >= 1024
                                          ? 120
                                          : 130,
                  width: widget.size.width,
                  imageUrl: widget.image),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BodyText(
                      color: AppColors.blackColor,
                      size: widget.size.width < 350
                          ? 6
                          : widget.size.width < 450
                              ? 14
                              : widget.size.width <= 700
                                  ? 13
                                  : widget.size.width > 800
                                      ? 15
                                      : widget.size.width >= 1024
                                          ? 15
                                          : 15,
                      text: widget.title,
                      weight: FontWeight.w700),
                  SizedBox(height: 10,),
                  BodyText(
                      color: AppColors.blackColor,
                      size: widget.size.width < 350
                          ? 6
                          : widget.size.width < 450
                              ? 10
                              : widget.size.width <= 700
                                  ? 12
                                  : widget.size.width > 800
                                      ? 12
                                      : widget.size.width >= 1024
                                          ? 13
                                          : 10,
                      text: '\$${widget.price}',
                      weight: FontWeight.w700),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
