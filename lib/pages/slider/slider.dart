import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:techno_teacher/api_utility/cont_urls.dart';
import 'package:techno_teacher/utils/images.dart';

class SliderView extends StatelessWidget {
  const SliderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        viewportFraction: .95,
        autoPlay: true,
        height: 170,
        disableCenter: true,
      ),
      itemCount: slider.isNotEmpty ? slider.length : Images.data.length,
      itemBuilder: (context, index, _) {
        return Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: slider.isEmpty
                ? Image.asset(
                    Images.data[index][0],
                    fit: BoxFit.fill,
                  )
                : Image.network(
                    "${TGuruJiUrl.url}/${slider[index]['slider']}",
                    fit: BoxFit.fill,
                    loadingBuilder: (context, child, loadingProgress) {
                      return loadingProgress == true
                          ? Center(child: CircularProgressIndicator())
                          : child;
                    },
                  ),
          ),
        );
      },
    );
  }
}
