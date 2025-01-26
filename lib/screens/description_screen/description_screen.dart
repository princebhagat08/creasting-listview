import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youbloomdemo/bloc/description_bloc/description_bloc.dart';
import 'package:youbloomdemo/bloc/description_bloc/description_event.dart';
import 'package:youbloomdemo/config/color/color.dart';
import 'package:youbloomdemo/config/text_style/text_style.dart';
import 'package:youbloomdemo/model/product_model.dart';

class DescriptionScreen extends StatelessWidget {
  final Products product;
  const DescriptionScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _backButton(size,context),
              _description(context),
            ],
          ),
        ),
      ),
    );
  }


//   ProductImage widget
Widget _backButton(Size size, BuildContext context){
    return Stack(
      children: [
        SizedBox(
          height: size.height * 0.45,
          width: double.infinity,
          child: Hero(
            tag: product.id ?? '',
            child: CachedNetworkImage(
              imageUrl: product.thumbnail!,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Positioned(
          top: 16,
          left: 16,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.arrow_back),
            ),
          ),
        ),
      ],
    );
}



// Description widget
  Widget _description(BuildContext context){
    return  Transform.translate(
      offset: const Offset(0, -30),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.lightGrey.withOpacity(0.5),
          borderRadius:
          const BorderRadius.vertical(top: Radius.circular(30)),
        ),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                      product.title!,
                      style: xLargeBoldText
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.blackColor.withOpacity(0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.favorite_border,
                      color: Colors.pink),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.deepOrange.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.star,
                          size: 18, color: AppColor.deepOrange),
                      const SizedBox(width: 4),
                      Text(
                        product.rating.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: fontFamily,
                          color: AppColor.deepOrange,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.deepGreen.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${product.stock} in stock',
                    style: TextStyle(
                      color:AppColor.deepGreen,
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Description',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: fontFamily,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.description!,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
                fontFamily: fontFamily,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.blackColor.withOpacity(0.7),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Price',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontFamily: fontFamily,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$${product.price}',
                        style:  TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          fontFamily: fontFamily,
                          color: AppColor.blackColor,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<DescriptionBloc>().add(AddToCart());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primaryColor.withOpacity(0.7),
                      foregroundColor: AppColor.whiteColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.shopping_bag_outlined,color: AppColor.whiteColor,),
                        SizedBox(width: 8),
                        Text(
                          'Add to Cart',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: fontFamily,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
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


}
