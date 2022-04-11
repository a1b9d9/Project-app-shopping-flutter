import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/reuseble_components.dart';

class InfoProfileScreen extends StatelessWidget {
  const InfoProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit, ShopHomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ShopHomeCubit homeCubit = ShopHomeCubit.get(context);
          String? oldEmailController = homeCubit.infoSetting?.data.email;
          String? oldNameController = homeCubit.infoSetting?.data.name;
          String? oldPhoneController = homeCubit.infoSetting?.data.phone;
          var emailController = TextEditingController(text: oldEmailController);
          var nameController = TextEditingController(text: oldNameController);
          var phoneController = TextEditingController(text: oldPhoneController);
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
                          "Your Profile",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              maxRadius: 60,
                              backgroundImage: NetworkImage(
                                  "https://keymanagementinsights.com/wp-content/uploads/2022/01/Sword-Art-Online-Season-5-1.jpg"),
                            ),
                          ],
                        ),                        const SizedBox(
                          height: 10,
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(homeCubit.infoSetting!.data.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize:15)),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        formField(onlyread: true,
                          controller: nameController,
                          label: "Name",
                          validat: (value) {
                            if (value!.isEmpty) {
                              return "please enter your Name";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        formField(onlyread: true,
                          controller: emailController,
                          label: "Email",
                          validat: (value) {
                            if (value!.isEmpty) {
                              return "please enter your email";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        formField(onlyread: true,
                          controller: phoneController,
                          label: "Phone",
                          validat: (value) {
                            if (value!.isEmpty) {
                              return "please enter your Phone";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                      ]),
                ),
              ),
            ),
          );
        });
  }
}
