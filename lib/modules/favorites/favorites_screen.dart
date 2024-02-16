import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce_app/models/favorites_model.dart';
import 'package:e_commerce_app/shared/components/components.dart';
import 'package:e_commerce_app/shared/cubit/cubit.dart';
import 'package:e_commerce_app/shared/cubit/states.dart';
import 'package:e_commerce_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: state is! ShopGetFavDataLoadingState,
            builder: (context) => ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildFavItem(
                    ShopCubit.get(context).favoritesModel!.data!.data![index],
                    context),
                separatorBuilder: (context, index) => myDivider(),
                itemCount:
                    ShopCubit.get(context).favoritesModel!.data!.data!.length),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        });
  }

  Widget buildFavItem(Data model, context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 130,
        width: double.infinity,
        child: Row(
          children: [
            SizedBox(
              height: 120,
              width: 130,
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(model.product!.image!),
                    width: double.infinity,
                    height: 120,
                  ),
                  if (model.product!.discount != 0)
                    Container(
                      color: Colors.red,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 3),
                      child: const Text(
                        "DISCOUNT",
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    )
                ],
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.product!.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 24, height: 1.3, fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.product!.price}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: defaultColor,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if (model.product!.oldPrice != 0)
                        Text(
                          '${model.product!.oldPrice}',
                          style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            ShopCubit.get(context)
                                .changeFavorites(productId: model.product!.id!);

                            // print(model.id);
                            // print(ShopCubit.get(context).favorites[model.id]);
                            // print(model.inFavorites);
                          },
                          icon: CircleAvatar(
                            backgroundColor: ShopCubit.get(context)
                                    .favorites[model.product!.id]!
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
            ),
          ],
        ),
      ),
    );
  }
}
