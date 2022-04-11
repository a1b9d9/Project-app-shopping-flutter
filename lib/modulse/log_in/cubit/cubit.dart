import 'package:appshopeflutter/modulse/log_in/cubit/states.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:appshopeflutter/shared/network/remote/api_dio.dart';
import '../../../shared/models/model_login.dart';
import '../../../shared/network/local/shared_preferences.dart';
import '../../../shared/network/remote/end_Point_Url.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  late LoginInfo info;

  void userLogin(
      {url = logIn, required String email, required String password}) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: url, data: {"email": email, "password": password})
        .then((value) {
     // print(value.data);
      info = LoginInfo.fromJson(value.data);
      print(info.message);
      if (info.status == false) {
        emit(ShopLoginErrorState(value.toString()));
      } else {
        CacheHelper.putData(key: "token", value:info.data.token).then((value) {
          if (value) {
            emit(ShopLoginSuccessState());
          }
        }).catchError((onError){print(onError);});
      }
    }).catchError((error) {
      emit(ShopLoginErrorState(error.toString()));
      print(error.toString());
      info= LoginInfo(
          status: false,
          message: error.toString(),
          data: DataUserInfo(
              id: 0,
              name: "",
              email: "",
              phone: "",
              image: "",
              points: 0,
              credit: 0,
              token: ""));
    });
  }

  bool secure = false;

  void changeIcon() {
    if (secure) {
      secure = false;
      emit(ChangeVisiblePassword());
    } else {
      secure = true;
      emit(ChangeVisiblePassword());
    }
  }
}
