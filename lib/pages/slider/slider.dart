import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:techno_teacher/utils/images.dart';

class SliderView extends StatelessWidget {
  const SliderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        // viewportFraction: 1,
        autoPlay: true,
        height: 140,
        enlargeCenterPage: true,
        disableCenter: true,
      ),
      itemCount: Images.sliders.length,
      itemBuilder: (context, index, _) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(Images.sliders[index],fit: BoxFit.fill,),
        );
      },
    );
  }
}
