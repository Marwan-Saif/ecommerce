import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce_app/models/categories_model.dart';
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
              condition: ShopCubit.get(context).homeModel != null &&
                  ShopCubit.get(context).categoriesModel != null,
              builder: (context) => ProductsBuilder(
                  ShopCubit.get(context).homeModel!,
                  ShopCubit.get(context).categoriesModel!,
                  context),
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ));
  }

  Widget ProductsBuilder(
      HomeModel model, CategoriesModel categoriesModel, context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              )),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Categories",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          buildCategoryItem(categoriesModel.data!.data[index]),
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 10),
                      itemCount: categoriesModel.data!.data.length),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "New PRODUCTS",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              childAspectRatio: 1 / 1.58,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                model.data!.products.length,
                (index) =>
                    buildGrideProduct(model.data!.products[index], context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGrideProduct(ProductsModel model, context) => Container(
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
                    color: Colors.red,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                    child: const Text(
                      "DISCOUNT",
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
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
                    style: const TextStyle(
                        fontSize: 14, height: 1.3, fontWeight: FontWeight.w500),
                  ),
                  Row(
                    children: [
                      Text(
                        '${(model.price as num).round()}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: defaultColor,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${(model.oldPrice as num).round()}',
                          style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            ShopCubit.get(context)
                                .changeFavorites(productId: model.id);
                          
                            // print(model.id);
                            // print(ShopCubit.get(context).favorites[model.id]);
                            // print(model.inFavorites);
                          },
                          icon: CircleAvatar(
                            backgroundColor:
                                ShopCubit.get(context).favorites[model.id]!
                                    ? defaultColor
                                    : Colors.grey,
                            child: const Icon(
                              Icons.favorite_border,
                              size: 14,
                              color: Colors.white,
                            ),
                          ))
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      );

  Widget buildCategoryItem(DataModel data) =>
      Stack(alignment: AlignmentDirectional.bottomStart, children: [
        Image(
          fit: BoxFit.cover,
          image: NetworkImage('${data.image}'),
          height: 100,
          width: 100,
        ),
        Container(
          width: 100,
          color: Colors.black.withOpacity(0.5),
          child: Text(
            data.name!.toUpperCase(),
            maxLines: 1,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
          ),
        )
      ]);
}
