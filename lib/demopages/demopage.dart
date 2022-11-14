import 'package:flutter/material.dart';
import 'package:animated_background/animated_background.dart';

class House extends StatefulWidget {
  const House({Key? key}) : super(key: key);

  @override
  State<House> createState() => _HouseState();
}

class _HouseState extends State<House> with SingleTickerProviderStateMixin {
  ParticleOptions particles = const ParticleOptions(
      baseColor: Colors.pink,
      spawnOpacity: 0.0,
      opacityChangeRate: 0.25,
      minOpacity: 0.1,
      maxOpacity: 0.4,
      particleCount: 100,
      spawnMaxRadius: 15.0,
      spawnMaxSpeed: 100.0,
      spawnMinSpeed: 30,
      spawnMinRadius: 7.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBackground(
        vsync: this,
        behaviour: RandomParticleBehaviour(options: particles),
        child: Center(child: Text("Hey")),
      ),
    );
  }
}
