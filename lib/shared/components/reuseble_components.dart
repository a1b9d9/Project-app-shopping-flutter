import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/show_image_screen.dart';
import '../models/model_data_drawer.dart';
import '../models/models_favourite.dart';
import '../style/colors.dart';

void navi(context, Widget page) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );

void naviAndExit(context, Widget page) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => page),
      (route) => false,
    );

Widget formField({
  required TextEditingController controller,
   TextInputType? type,
  required String label,
  FormFieldValidator<String>? validat,
  ValueChanged<String>? onchange,
  ValueChanged<String>? onFieldSubmitted,
  VoidCallback? editingComplete,
  GestureTapCallback? OneTap,
  Widget? preIcon,
  Widget? prefix,
  Widget? sufIcon,
  Widget? suffix,
  InputBorder? enabledBorder,
  bool obscure = false,
  bool onlyread = false,
  TextInputAction? inputAction = TextInputAction.next,
}) =>
    TextFormField(
      textInputAction: inputAction,
      onEditingComplete: editingComplete,
      controller: controller,
      keyboardType: type,
      onChanged: onchange,
      onFieldSubmitted: onFieldSubmitted,
      onTap: OneTap,
      readOnly: onlyread,
      obscureText: obscure,
      validator: validat,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: preIcon,
        suffixIcon: sufIcon,
        suffix: suffix,
        enabledBorder: enabledBorder,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

Future<bool?> toast({required String message, required ToastColor state}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 10,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 14.0);

Color chooseToastColor(ToastColor color) {
  if (ToastColor.success == color) {
    return Colors.green;
  }
  if (ToastColor.warning == color) {
    return Colors.yellow;
  } else {
    return Colors.red;
  }
}

enum ToastColor { success, error, warning }

Widget buildIconDrawer({
  required BuildContext context,
  required int index,
  Color select = Colors.grey,
  Color unselect = Colors.white,
  required GestureTapCallback function,
  required DataDrawer data,
  required String imageUrl,
}) {
  if (index == 0) {
    return DrawerHeader(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [select, Colors.grey])),
        child: Column(
          children: [
            InkWell(
                onTap: () {
                  navi(
                      context,
                      ShowImage(
                        image: imageUrl,
                      ));
                },
                child: CircleAvatar(
                  maxRadius: 50,
                  backgroundImage: NetworkImage(imageUrl),
                )),
            Text(data.title),
          ],
        ));
  } else {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 8),
      child: SizedBox(
        height: 45,
        child: InkWell(
          onTap: function,
          child: Row(
            children: [
              Icon(
                data.icon,
                color: currentIndex == index ? select : unselect,
              ),
              const SizedBox(
                width: 15,
              ),
              Text(data.title,
                  style: TextStyle(
                    color: currentIndex == index ? select : unselect,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildProducts(info, ShopHomeCubit homeCubit) {
  return Column(
    children: [
      Stack(alignment: AlignmentDirectional.bottomStart, children: [
        Image(
          image: NetworkImage(info.image),
          width: double.infinity,
          height: 200,
          fit: BoxFit.fill,
        ),
        if (info.oldPrice != info.price)
          Container(
              color: Colors.red,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text("Discount", style: TextStyle(color: Colors.white)),
              )),
      ]),
      Expanded(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(info.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, height: 1.3)),
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
                    if (info.oldPrice != info.price)
                      Text(
                        "${info.oldPrice}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 10,
                            height: 1.3,
                            color: Colors.grey[500],
                            decoration: TextDecoration.lineThrough),
                      ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          homeCubit.enableDisableIcon(info.id);
                        },
                        icon: homeCubit.changeIcon(info.id)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

Widget drawListCategories(info) {
  return ListView.separated(
      itemBuilder: (context, index) =>
          showCategories(info.infoCategories[index]),
      separatorBuilder: (context, index) =>
          Container(height: 1, color: Colors.grey[300]),
      itemCount: 5);
}

Widget showCategories(info) {
  return InkWell(
    onTap: () {},
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
      child: Row(children: [
        Image(
          image: NetworkImage(info.image),
          width: 100,
          height: 100,
        ),
        const SizedBox(width: 10),
        Text(info.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
        const Spacer(),
        const Icon(Icons.arrow_forward_ios_rounded)
      ]),
    ),
  );
}

Widget drawListFavourite(
    ListFavourites listFavourites, ShopHomeCubit homeCubit) {
  return ListView.separated(
      itemBuilder: (context, index) => showFavourite(
          listFavourites.data.data1[index].data2,
          homeCubit: homeCubit,
          index: index),
      separatorBuilder: (context, index) =>
          Container(height: 1, color: Colors.grey[300]),
      itemCount: listFavourites.data.data1.length);
}

Widget showFavourite(info,
    {required ShopHomeCubit homeCubit, required int index}) {
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
          if (info.oldPrice != info.price)
            Container(
                color: Colors.red,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child:
                      Text("Discount", style: TextStyle(color: Colors.white)),
                )),
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
                  if (info.oldPrice != info.price)
                    Text(
                      "${info.oldPrice}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 10,
                          height: 1.3,
                          color: Colors.grey[500],
                          decoration: TextDecoration.lineThrough),
                    ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                       homeCubit.enableDisableIcon(info.id,
                           enable: true, index: index);
                    },
                    icon: const Icon(
                      Icons.favorite,
                      size: 25,
                      color: Colors.redAccent,
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
