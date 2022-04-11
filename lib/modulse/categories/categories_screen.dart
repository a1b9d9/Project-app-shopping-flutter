import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/reuseble_components.dart';

class CategoriesHome extends StatelessWidget {
  const CategoriesHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopHomeCubit, ShopHomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ShopHomeCubit homeCubit = ShopHomeCubit.get(context);

          return homeCubit.homeCategoriesData != null
              ? drawListCategories( homeCubit.homeCategoriesData!.data)
              : const Center(child: CircularProgressIndicator());
        });
  }


}
