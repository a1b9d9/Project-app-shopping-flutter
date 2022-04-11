import 'package:appshopeflutter/shared/components/reuseble_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/style/colors.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    return BlocConsumer<ShopHomeCubit, ShopHomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ShopHomeCubit homeCubit = ShopHomeCubit.get(context);

          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
              child: Column(
                children: [
                  formField(
                      controller: searchController,
                      label: "Search",
                      onFieldSubmitted: (value) {
                        homeCubit.searchInfo(value);
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child:  buildSearch(homeCubit),
                  )
                ],
              ),
            ),
          );
        });
  }






















Widget buildSearch(ShopHomeCubit homeCubit){
    return ListView.separated(
        itemBuilder: (context, index)
        {
              if (homeCubit.search == null)
                {
                 return const Center(
                    child: Text("Enter to Search anItem",
                        style: TextStyle(color: Colors.grey)),
                  );
                }
              else if(homeCubit.search !=0 )
                {
                  return showSearch(
                    homeCubit.search!.data.data1[index],
                  );
                }
              else{
                return const Center(
                  child: Text("No Item",
                      style: TextStyle(color: Colors.grey)),
                );

              }
            }, separatorBuilder: (context, index) =>
            const SizedBox(height: 10),
        itemCount: homeCubit.search != null
            ? homeCubit.search!.data.data1.length
            : 0);
}

  Widget showSearch(info) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
        child: Row(children: [
          Stack(alignment: AlignmentDirectional.bottomStart, children: [
            Image(
              image: NetworkImage(info.image),
              width: 100,
              height: 100,
              fit: BoxFit.fill,
            ),

          ]),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(info.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w400)),
                Row(
                  children: [
                    Text("${info.price}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14, height: 1.3, color: defaultColor)),
                    const SizedBox(
                      width: 5,
                    ),

                    const Spacer(),
                    IconButton(
                      onPressed: () {
                      },
                      icon: info.inFavorites==false
                      ?const Icon(
                        Icons.favorite_border,
                        size: 25,
                      )
                      :const Icon(
                        Icons.favorite,
                        size: 25,
                        color:Colors.redAccent,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }



}



