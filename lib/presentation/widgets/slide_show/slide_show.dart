import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

import 'package:cinema_ui_flutter/config/constants/size_config.dart';
import 'package:cinema_ui_flutter/domain/entities/movie.dart';

class SlideShow extends StatelessWidget {
  final List<Movie> listSlide;
  const SlideShow({super.key, required this.listSlide});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Swiper(
        itemBuilder: (context, index) {
          final item = listSlide[index];
          return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              item.backdropPath,
              fit: BoxFit.cover,
            ),
          );
        },
        autoplay: true,
        autoplayDelay: 2000,
        itemCount: listSlide.length,
        viewportFraction: 0.7,
        scale: 0.5,
        pagination: SwiperCustomPagination(
          builder: (BuildContext context, SwiperPluginConfig config) {
            final active = config.activeIndex;

            return Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 20,
                width: SizeConfig.screenWidth * 0.4,
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.black54,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ...List.generate(listSlide.length, (index) {
                      return Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: active == index ? Colors.red : Colors.grey,
                        ),
                      );
                    })
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
