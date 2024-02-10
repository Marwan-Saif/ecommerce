import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce_app/models/home_model.dart';
import 'package:e_commerce_app/shared/cubit/cubit.dart';
import 'package:e_commerce_app/shared/cubit/states.dart';
import 'package:e_commerce_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) => ConditionalBuilder(
              condition: ShopCubit.get(context).homeModel != null,
              builder: (context) =>
                  ProductsBuilder(ShopCubit.get(context).homeModel!),
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ));
  }

  Widget ProductsBuilder(HomeModel model) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          CarouselSlider(
              items: model.data!.banners.map((e) {
                return Image(
                  image: NetworkImage(e.image),
                  width: double.infinity,
                );
              }).toList(),
              options: CarouselOptions(
                height: 250,
                autoPlay: true,
                reverse: true,
                enableInfiniteScroll: true,
                viewportFraction: 1,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              )),
          SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              childAspectRatio: 1 / 1.58,
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(model.data!.products.length,
                  (index) => buildGrideProduct(model.data!.products[index])),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGrideProduct(ProductsModel model) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: double.infinity,
                  height: 200,
                  // fit: BoxFit.cover,
                ),
                if (model.discount != 0)
                  Container(
                    child: Text(
                      "DISCOUNT",
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14, height: 1.3, fontWeight: FontWeight.w500),
                  ),
                  Row(
                    children: [
                      Text(
                        '${(model.price as num).round()}',
                        style: TextStyle(
                          fontSize: 14,
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${(model.old_price as num).round()}',
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      Spacer(),
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.favorite_border))
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      );
}
