import 'package:flutter/material.dart';

class ShowImage extends StatelessWidget {
  final String image;

  const ShowImage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Image.network(image)),

    );
  }
}
