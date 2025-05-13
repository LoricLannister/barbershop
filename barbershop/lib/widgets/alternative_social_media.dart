import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class AlternativeSocialMedia extends StatelessWidget {
  const AlternativeSocialMedia({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Brand(Brands.google, size: 50),
        Brand(Brands.facebook, size: 50),
        Brand(Brands.instagram, size: 50),
      ],
    );
  }
}
