import 'package:alusoft_app/homepages/onboarding1.dart';
import 'package:alusoft_app/homepages/onboarding2.dart';
import 'package:alusoft_app/homepages/onboarding3.dart';
import 'package:flutter/material.dart';

class PageBuilder extends StatelessWidget {
  const PageBuilder({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        body: const MyStatelessWidget(),
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return PageView(
      /// [PageView.scrollDirection] defaults to [Axis.horizontal].
      /// Use [Axis.vertical] to scroll vertically.
      controller: controller,
      scrollDirection: Axis.vertical,
      children: const <Widget>[
        Center(child: Onboarding1()),
        Center(child: Onboarding2()),
        Center(child: OnBoarding3()),
      ],
      physics: BouncingScrollPhysics(),
    );
  }
}
