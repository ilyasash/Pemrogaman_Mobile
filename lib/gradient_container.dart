import 'package:flutter/material.dart';
import 'package:module3_app/dice_roller.dart'; 

class GradientContainer extends StatelessWidget {
  const GradientContainer(this.colors, {super.key});

  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
        ),
      ),
      child: const Center(
        child: DiceRoller(), 
      ),
    );
  }
}
