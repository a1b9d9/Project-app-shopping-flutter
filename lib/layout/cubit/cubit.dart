import 'package:appshopeflutter/layout/cubit/states.dart';
import 'package:appshopeflutter/shared/models/model_data_drawer.dart';
import 'package:appshopeflutter/shared/models/models_products.dart';
import 'package:appshopeflutter/modulse/products/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:appshopeflutter/shared/network/remote/api_dio.dart';

import '../../modulse/categories/categories_screen.dart';
import '../../modulse/favourite/favourite_screen.dart';
import '../../modulse/log_in/log_in_screen.dart';
import '../../modulse/setting/change_password_screen.dart';
import '../../modulse/setting/edit_profile_screen.dart';
import '../../modulse/setting/info_user_screen.dart';
import '../../modulse/setting/setting_screen.dart';
import '../../shared/components/reuseble_components.dart';
import '../../shared/models/model_gategories.dart';
import '../../shared/models/model_search.dart';
import '../../shared/models/model_setting.dart';
import '../../shared/models/models_favourite.dart';
import '../../shared/network/local/shared_preferences.dart';
import '../../shared/network/remote/end_point_url.dart';

int currentIndex = 1;

class ShopHomeCubit extends Cubit<ShopHomeStates> {
  ShopHomeCubit() : super(ShopHomeInitialState());

  static ShopHomeCubit get(context) => BlocProvider.of(context);

  List<DataDrawer> dataDrawer = [
    DataDrawer(title: "Home", icon: Icons.home),
    DataDrawer(title: "home", icon: Icons.home),
    DataDrawer(title: "Categories", icon: Icons.category),
    DataDrawer(title: "Favorites", icon: Icons.favorite),
    DataDrawer(title: "Setting", icon: Icons.settings),
  ];

  List<Widget> screens = [
    const ProductsHome(),
    const CategoriesHome(),
    const FavoriteHome(),
    const SettingScreen()
  ];
  Widget screen =     const ProductsHome();

  void changeColorIcon(int index) {
    currentIndex = index;
    if (index - 1 == 2) {
      getFavouritesData();
    }
    screen = screens[index - 1];
    emit(ChangeScreen());
  }

  HomeProductsData? homeDataModels;
  late Map<int, bool> listtFavourites = {};

  void getHomeData() {
    emit(ShopHomeLoadingState());
    DioHelper.getData(url: home, token: CacheHelper.getData(key: "token"))
        .then((value) {
      homeDataModels = HomeProductsData.fromJson(value.data);
      homeDataModels?.data.products.forEach((element) {
        //print(element.id);
        listtFavourites[element.id] = false;
      });
      getFavouritesData();
      emit(ShopHomeSuccessState());
      //print(value.data["status"]);
    }).catchError((onError) {
      emit(ShopHomeErrorState(onError.toString()));

      //   print(onError.toString());
    });
  }

  HomeCategoriesData? homeCategoriesData;

  void getCategoriesData() {
    emit(ShopHomeLoadingState());
    DioHelper.getData(url: categories).then((value) {
      homeCategoriesData = HomeCategoriesData.fromJson(value.data);
      emit(ShopHomeCategoriesSuccessState());
      //print(value.data["status"]);
    }).catchError((onError) {
      emit(ShopHomeCategoriesErrorState(onError));
      //   print(onError.toString());
    });
  }

  late ListFavourites listFavourites;

  void getFavouritesData() {
    emit(ShopHomeLoadingState());
    DioHelper.getData(url: favorites, token: CacheHelper.getData(key: "token"))
        .then((value) {
      listFavourites = ListFavourites.fromJson(value.data);
      // print(listFavourites!.data.data.data[0].id);
      listFavourites.data.data1.forEach((element) {
        listtFavourites.update(element.data2.id, (value) => true);
      });

      emit(ShopHomeFavouritesSuccessState());
      //print(value.data["status"]);
    }).catchError((onError) {
      //  print(onError.toString());
      emit(ShopHomeFavouritesErrorState(onError.toString()));
      //print(onError.toString());
    });
  }

  Widget changeIcon(int id) {
    if (listtFavourites[id] == true) {
      return const Icon(
        Icons.favorite,
        size: 25,
        color: Colors.redAccent,
      );
    } else {
      return const Icon(
        Icons.favorite_border,
        size: 25,
      );
    }
  }

  void enableDisableIcon(int id, {bool enable = false, int index = 0}) {
    if (listtFavourites[id] == true) {
      listtFavourites.update(id, (value) => false);
      if (enable) {
        listFavourites.data.data1.removeAt(index);
      }
    } else {
      listtFavourites.update(id, (value) => true);
    }
    emit(ShopHomeLoadingState());
    DioHelper.postData(
        url: favorites,
        token: CacheHelper.getData(key: "token"),
        data: {"product_id": id}).then((value) {
      if (value.data["status"] == true) {
        emit(ShopHomeChangeFavouritesIconSuccessState());
      } else {
        if (listtFavourites[id] == true) {
          listtFavourites.update(id, (value) => false);
        } else {
          listtFavourites.update(id, (value) => true);
        }
        emit(ShopHomeChangeFavouritesIconErrorState(value.data["status"]));
      }
    }).catchError((onError) =>
        emit(ShopHomeChangeFavouritesIconErrorState(onError.toString())));
  }

  Setting? infoSetting;

  void getProfile() {
    emit(ShopHomeSettingLoadingState());
    DioHelper.getData(url: profile, token: CacheHelper.getData(key: "token"))
        .then((value) {
      infoSetting = Setting.fromJson(value.data);
      emit(ShopHomeSettingSuccessState());
    }).catchError((error) {
      emit(ShopHomeSettingErrorState(error.toString()));
    });
  }

  List<SettingIcon>? settingScreenInfo = [
    SettingIcon(icon: Icons.edit, title: "Edit Profile"),
    SettingIcon(icon: Icons.vpn_key_rounded, title: "Change Password"),
    SettingIcon(icon: Icons.info, title: "Information"),
    SettingIcon(icon: Icons.logout, title: "Log out"),
  ];

  void putUpdateProfile(
      {required String name, required String email, required String phone}) {
    emit(ShopHomeUpdateProfileLoadingState());

    DioHelper.putData(
        url: updateProfile,
        token: CacheHelper.getData(key: "token"),
        data: {
          "name": name,
          "email": email,
          "phone": phone,
        }).then((value) {
      if (value.data["status"] == true) {
        getProfile();
        emit(ShopHomeUpdateProfileSuccessState());
        toast(message: value.data["message"], state: ToastColor.success);
      } else {
        toast(message: value.data["message"], state: ToastColor.error);
      }
    }).catchError((onError) {
      emit(ShopHomeUpdateProfileErrorState(onError.toString()));
    });
  }

  void changePasswordUser({
    required String password,
    required String newPassword,
  }) {
    emit(ShopHomeChangePasswordLoadingState());

    DioHelper.postData(
        url: changePassword,
        token: CacheHelper.getData(key: "token"),
        data: {
          "current_password": password,
          "new_password": newPassword,
        }).then((value) {
      if (value.data["status"] == true) {
        emit(ShopHomeChangePasswordSuccessState());
        toast(message: value.data["message"], state: ToastColor.success);
      } else {
        toast(message: value.data["message"], state: ToastColor.error);
      }
    }).catchError((onError) {
      emit(ShopHomeChangePasswordErrorState(onError.toString()));
    });
  }

  void logoutUser(int index, context) {
    emit(ShopHomeLogoutLoadingState());
    DioHelper.postData(
      url: logout,
      token: CacheHelper.getData(key: "token"),
    ).then((value) {
      if (value.data["status"] == true) {
        CacheHelper.clearData(key: "token");
        toast(message: value.data["message"], state: ToastColor.success);
        emit(ShopHomeLogoutSuccessState());
        naviAndExit(context, const LogIn());
      } else {
        toast(message: value.data["message"], state: ToastColor.error);
      }
      emit(ShopHomeLogoutErrorState(value.data["message"].toString()));
    }).catchError((error) {
      emit(ShopHomeLogoutErrorState(error.toString()));
    });
  }

  void changeSettingScreen(int index, context) {
    if (index == 0) {
      navi(context, const EditProfileScreen());
    } else if (index == 1) {
      navi(context, const ChangePasswordScreen());
    } else if (index == 2) {
      navi(context, const InfoProfileScreen());
    } else {
      logoutUser(index, context);
    }
  }

  ListSearch? search;

  void searchInfo(String text) {
    emit(ShopHomeSearchLoadingState());
    DioHelper.postData(
        url: productsSearch,
        token: CacheHelper.getData(key: "token"),
        data: {
          "text": text,
        }).then((value) {
      search = ListSearch.fromJson(value.data);
      emit(ShopHomeSearchSuccessState());
    }).catchError((error) {
      emit(ShopHomeSearchErrorState(error.toString()));
    });
  }
}
