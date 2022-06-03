import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_capstone_project/utils/color.constant.dart';
import 'package:flutter_capstone_project/widgets/common/gradient_text.dart';

class CarouselItemData {
  String title;
  String descripton;

  CarouselItemData({required this.title, required this.descripton});
}

class HomeCarousel extends StatefulWidget {
  const HomeCarousel({Key? key}) : super(key: key);

  @override
  State<HomeCarousel> createState() => _HomeCarouselState();
}

class _HomeCarouselState extends State<HomeCarousel> {
  List<CarouselItemData> data = [
    CarouselItemData(title: '01', descripton: "Create \nprofessional \ninvoices"),
    CarouselItemData(title: '02', descripton: "Send \ninvoices \nefficaciously"),
    CarouselItemData(title: '03', descripton: "Automatically \nsend them \nby SMS"),
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        options: CarouselOptions(
          clipBehavior: Clip.none,
          enlargeCenterPage: true,
          aspectRatio: 209 / 227 / 0.5,
          // height: 227,
          enableInfiniteScroll: false,
          viewportFraction: 0.6,
        ),
        items: data
            .map(
              (e) => Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 30,
                      offset: const Offset(0, 3),
                      blurStyle: BlurStyle.outer, // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GradientText(
                      e.title,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                      gradient: ColorConstant.orangeGradient,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      e.descripton,
                      style: TextStyle(
                        color: ColorConstant.darkBlue,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Container(
                      height: 4,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: ColorConstant.orangeGradient,
                      ),
                    )
                  ],
                ),
              ),
            )
            .toList());
  }
}
