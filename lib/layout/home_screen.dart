import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../modulse/search/search_screen.dart';
import '../shared/components/reuseble_components.dart';
import '../shared/style/colors.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class HomeShop extends StatelessWidget {
  const HomeShop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit, ShopHomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ShopHomeCubit homeCubit = ShopHomeCubit.get(context);
          return Scaffold(
            appBar: AppBar( actions: [IconButton(onPressed: (){navi(context, const SearchItem());}, icon: const Icon(Icons.search))]),
            drawer: Drawer(
                child: ListView.builder(
              itemBuilder: (context, index) => buildIconDrawer(
                  index: index,
                  context: context,
                  function: () {
                    homeCubit.changeColorIcon(index);
                  },
                  select: defaultColor,
                  unselect: secondColor,
                  data: homeCubit.dataDrawer[index],
                  imageUrl:
                      "https://student.valuxapps.com/storage/uploads/users/VtfbyEsM1j_1645427052.jpeg"),
              itemCount: homeCubit.dataDrawer.length,
            )),
            body: homeCubit.screen,
          );
        });
  }
}
