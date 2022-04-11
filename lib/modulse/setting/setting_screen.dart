import 'package:appshopeflutter/shared/components/reuseble_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/models/model_setting.dart';
import 'edit_profile_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit, ShopHomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ShopHomeCubit homeCubit = ShopHomeCubit.get(context);
          return Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      maxRadius: 60,
                      backgroundImage: NetworkImage(
                          "https://keymanagementinsights.com/wp-content/uploads/2022/01/Sword-Art-Online-Season-5-1.jpg"),
                    ),
                    SizedBox(height: 10,),
                    Text(homeCubit.infoSetting!.data.name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 40,),
                drawRowSetting(homeCubit.settingScreenInfo),
              ],
            ),
          );
        });
  }
}

Widget drawRowSetting( List<SettingIcon>? listInfo) {
  return Expanded(
    child: ListView.separated(
      itemBuilder: (context, index) => rowSetting(listInfo![index].icon,listInfo[index].title,context,index),
      separatorBuilder: (context,index)=>const SizedBox(height: 3),
      itemCount: listInfo!.length,
    ),
  );
}

Widget rowSetting(IconData icon,String title , context,index
    ) {
  return Container(
    height: 50,
    child: InkWell(
        onTap:(){ShopHomeCubit.get(context).changeSettingScreen(index, context);},
        child: Row(
          children: [
            Icon(icon,color: Colors.teal),
            const SizedBox(
              width: 20,
            ),
            Text(title,style: TextStyle(color: Colors.teal,fontSize: 15),)
          ],
        )),
  );
}

