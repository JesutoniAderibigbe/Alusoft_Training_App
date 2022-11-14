// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Aluhomepage extends StatefulWidget {
  const Aluhomepage({Key? key}) : super(key: key);

  @override
  State<Aluhomepage> createState() => _AluhomepageState();
}

class _AluhomepageState extends State<Aluhomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hello, User!',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text('Course',style: TextStyle(fontSize: 25,color:Colors.white ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text('Cross Platform', style:TextStyle(fontSize: 20,fontWeight:FontWeight.bold,color: Colors.white),
                ),
            )],
            ),
          ),
          SizedBox(
            height: 200,
            child: GridView.builder(
                itemCount: 2,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 30,
                ),
                itemBuilder: (context, int) {
                  return Container(
                    margin: EdgeInsets.all(12),
                    padding: EdgeInsets.all(23),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.pink,
                        width: 2.0,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/flutter.jpg',
                        width: 100,
                      ),
                    ),
                    
                  );
                }),
          ),
          SizedBox(height: 6,),
ListView(
  children: [
    CarouselSlider(items: [
      Container(
        margin:EdgeInsets.all(6.0),
        child: Column(
          children: [
            Image.asset('assets/images/flutter.jpg',height: 121,)
          ],
        ),
      ),
        Container(
        margin:EdgeInsets.all(6.0),
        child: Column(
          children: [
            Image.asset('assets/images/flutter.jpg',height: 121,)
          ],
        ),
      ),
        Container(
        margin:EdgeInsets.all(6.0),
        child: Column(
          children: [
            Image.asset('assets/images/flutter.jpg',height: 121,)
          ],
        ),
      )
    ], options: CarouselOptions(
  height: 180.0,
  enlargeCenterPage: true,
  autoPlay: true,
  aspectRatio: 16/9,
  autoPlayCurve: Curves.fastOutSlowIn,
  enableInfiniteScroll: true,
  autoPlayAnimationDuration: Duration(milliseconds: 1000),
  viewportFraction: 0.8
))
  ],
)
        ],
      ),
    );
  }
}
