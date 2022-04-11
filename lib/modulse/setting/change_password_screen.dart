import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/reuseble_components.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  BlocConsumer<ShopHomeCubit, ShopHomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ShopHomeCubit homeCubit = ShopHomeCubit.get(context);

          var newPasswordController = TextEditingController();
          var currentPasswordController = TextEditingController();
          var phoneController = TextEditingController();
          var formKey = GlobalKey<FormState>();

          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Change Password",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        formField(
                          controller: currentPasswordController,
                          label: "Current Password",
                          validat: (value) {
                            if (value!.isEmpty) {
                              return "please enter your Password";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        formField(
                          controller: newPasswordController,
                          label: "New Password",
                          validat: (value) {
                            if (value!.isEmpty) {
                              return "please enter your New Password";
                            }
                          },
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          color: Colors.teal,
                          child: TextButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  // if (oldEmailController !=
                                  //     emailController.text &&
                                  //     oldNameController !=
                                  //         nameController.text &&
                                  //     oldPhoneController !=
                                  //         phoneController.text) {

                                  homeCubit.changePasswordUser(
                                      password: currentPasswordController.text,
                                      newPassword: newPasswordController.text,);
                                  //     }
                                }
                              },
                              child: const Text(
                                "Edit",
                                style: TextStyle(color: Colors.white),
                              )),
                        )
                      ]),
                ),
              ),
            ),
          );
        });
  }}