import 'package:appshopeflutter/modulse/register/cubit/cubit.dart';
import 'package:appshopeflutter/shared/components/block_observer.dart';
import 'package:appshopeflutter/shared/network/local/shared_preferences.dart';
import 'package:appshopeflutter/shared/network/remote/api_dio.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'layout/cubit/cubit.dart';
import 'layout/home_screen.dart';
import 'modulse/home_boarding/home_boarding_screen.dart';
import 'modulse/log_in/cubit/cubit.dart';
import 'modulse/log_in/cubit/states.dart';
import 'modulse/log_in/log_in_screen.dart';

void main() async {
  WidgetsFlutterBinding();
  Bloc.observer = MyBlocObserver();
  DioHelper.inti();
  await CacheHelper.init();
  Widget homeScreen;

  if (CacheHelper.getData(key: "OnBoarding") != null) {
    if (CacheHelper.getData(key: "token") != null) {
      homeScreen = const HomeShop();
    }
    else {
      homeScreen = const LogIn();
    }
  }
  else {
    homeScreen = const OnBoardingScreen();
  }
  runApp(MyApp(home: homeScreen));
}

class MyApp extends StatelessWidget {
  final Widget home;

  const MyApp({Key? key, required this.home}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ShopLoginCubit(),
          ),
          BlocProvider(
            create: (context) => ShopHomeCubit()
              ..getHomeData()
              ..getCategoriesData()
              ..getProfile(),
          ),
          BlocProvider(
            create: (context) => ShopRegisterCubit(),
          ),

        ],
        child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return MaterialApp(
                home: home,
                debugShowCheckedModeBanner: false,
                theme: ThemeData().copyWith(//هون عدلت عل برايمري للون مشان الايقونات لانو مافيني عدل عل ديفولت الا لوصل لهون
                  colorScheme: ThemeData().colorScheme.copyWith(
                        primary: Colors.teal,
                      ),
                ),
              );
            }));
  }

// This widget is the root of your application.
}
