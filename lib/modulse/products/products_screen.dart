import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/reuseble_components.dart';
import '../../shared/models/model_gategories.dart';
import '../../shared/models/models_products.dart';
import '../../shared/style/colors.dart';

class ProductsHome extends StatelessWidget {
  const ProductsHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocConsumer<ShopHomeCubit, ShopHomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ShopHomeCubit homeCubit = ShopHomeCubit.get(context);

          return homeCubit.homeDataModels != null &&
                  homeCubit.homeCategoriesData != null
              ? showProducts(homeCubit.homeDataModels,
                  homeCubit.homeCategoriesData, width, height,  homeCubit)
              : const Center(child: CircularProgressIndicator());
        });
  }

  Widget showProducts(HomeProductsData? model, HomeCategoriesData? categories,
          double width, double height, ShopHomeCubit  homeCubit) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          color: Colors.grey[300],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  color: Colors.white,
                  height: 45,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3.0),
                    child: ListView.separated(
                        itemBuilder: (context, index) => buildCategories(categories!.data.infoCategories[index]),
                        itemCount: categories!.data.infoCategories.length,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) => const SizedBox(
                              width: 5,
                            )),
                  )),
              CarouselSlider(
                items: model?.data.banners //هي جديدة بعمل ليست من ودجت
                    .map((e) => Image(
                          image: NetworkImage(e.image),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ))
                    .toList(),
                options: CarouselOptions(
                    height: 150,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(seconds: 3),
                    autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                    scrollDirection: Axis.horizontal,
                    viewportFraction: 1),
              ),
              const SizedBox(
                height: 2,
              ),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                childAspectRatio: height >= width ? 1 / 1.70 : 1.06 / 1,
                children: List.generate(model!.data.products.length,
                    (index) => buildProducts(model.data.products[index],homeCubit)),
              )
            ],
          ),
        ),
      );


//HomeCategoriesData
  Widget buildCategories(info) {
    return InkWell(
        onTap: () {

        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300]),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: Text(info.name),
              ),
            ),
          ],
        ));
  }
}
