import 'package:appshopeflutter/modulse/log_in/cubit/cubit.dart';
import 'package:appshopeflutter/modulse/log_in/cubit/states.dart';
import 'package:appshopeflutter/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/reuseble_components.dart';
import '../log_in/log_in_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var passController = TextEditingController();
    return BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var bloc = ShopRegisterCubit.get(context);
        return Scaffold(
          backgroundColor: defaultColorBackGround,
          appBar: AppBar(
            backgroundColor: defaultColorBackGround,
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Register",
                            style: TextStyle(
                                color: defaultColorLogIn,
                                fontSize: 30,
                                fontWeight: FontWeight.w600)),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text("Welcome To Our App Shop ",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 25,
                        ),
                        formField(
                          controller: nameController,
                          type: TextInputType.text,
                          label: "Name",
                          preIcon: const Icon(Icons.how_to_reg),
                          validat: (value) {
                            if (value!.isEmpty) {
                              return "please enter your Name";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        formField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          label: "Email Address",
                          preIcon: const Icon(Icons.email),
                          validat: (value) {
                            if (value!.isEmpty) {
                              return "please enter your email";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        formField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          label: "Phone",
                          preIcon: const Icon(Icons.phone),
                          validat: (value) {
                            if (value!.isEmpty) {
                              return "please enter your Phone";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        formField(
                          controller: passController,
                          type: TextInputType.visiblePassword,
                          label: "Password",
                          preIcon: const Icon(Icons.lock),
                          obscure: bloc.secure,
                          sufIcon: IconButton(
                            icon: Icon(
                              bloc.secure
                                  ? Icons.visibility_off
                                  : Icons.remove_red_eye,
                            ),
                            onPressed: () {
                              bloc.changeIcon();
                            },
                          ),
                          validat: (value) {
                            if (value!.isEmpty) {
                              return "please enter your Password";
                            }
                          },
                          onFieldSubmitted: (v) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        state is! ShopRegisterLoadingState
                            ? Container(
                                width: double.infinity,
                                color: defaultColorLogIn,
                                height: 40,
                                child: MaterialButton(
                                  onPressed: () {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus(); //هون لنسكر الكيبورد

                                    if (formKey.currentState!.validate()) {
                                      bloc.userRegister(context:context ,
                                          name:nameController.text,
                                          phone: phoneController.text,
                                          email: emailController.text,
                                          password: passController.text);
                                    }
                                  },
                                  child: const Text("Register",
                                      style: TextStyle(color: Colors.white)),
                                ),
                              )
                            : Center(
                                child: CircularProgressIndicator(
                                  color: defaultColor,
                                ),
                              ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Are you have an account?"),
                            TextButton(
                                onPressed: () {
                                  naviAndExit(context, const LogIn());
                                },
                                child: Text(
                                  "Login",
                                  style: TextStyle(color: defaultColorLogIn),
                                ))
                          ],
                        ),
                      ]),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
