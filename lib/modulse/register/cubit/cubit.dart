
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:appshopeflutter/shared/network/remote/api_dio.dart';

import '../../../shared/components/reuseble_components.dart';
import '../../../shared/network/remote/end_point_url.dart';
import '../../log_in/log_in_screen.dart';
import '../../register/cubit/states.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);


  void userRegister(
      {url = register, required String email, required String password, required String name, required String phone,required context}) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url: url, data: {"email": email, "password": password,"name":name,"phone":phone},)
        .then((value) {
      // print(value.data);
      if (value.data["status"] == false) {
        toast(message: value.data["message"], state: ToastColor.error);
        emit(ShopRegisterErrorState(value.toString()));
      } else {
        emit(ShopRegisterSuccessState());
        toast(message: value.data["message"], state: ToastColor.success);
        naviAndExit(context,const LogIn());

      }
    }).catchError((error) {
      emit(ShopRegisterErrorState(error.toString()));
      toast(message: error.toString(), state: ToastColor.success);

    });
  }

  bool secure = false;

  void changeIcon() {
    if (secure) {
      secure = false;
      emit(ChangeVisiblePasswordRegister());
    } else {
      secure = true;
      emit(ChangeVisiblePasswordRegister());
    }
  }
}
