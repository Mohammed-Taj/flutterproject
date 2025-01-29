import 'package:flutter/material.dart';

class ImageSlider extends StatelessWidget {
  final Function(int) onChange;
  final int currentSlide;
  const ImageSlider({
    super.key,
    required this.currentSlide,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    // Responsive height for the slider
    final screenHeight = MediaQuery.of(context).size.height;
    final sliderHeight = screenHeight > 600 ? 250.0 : 200.0;

    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
              height: sliderHeight,
              width: double.infinity,
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(20), // More modern rounded corners
                child: PageView(
                  scrollDirection: Axis.horizontal,
                  allowImplicitScrolling: true,
                  onPageChanged: onChange,
                  physics: const ClampingScrollPhysics(),
                  children: [
                    Image.asset(
                      "images/slider.jpg",
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      "images/image1.png",
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      "images/slider3.png",
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        // Page indicator with animation
        Positioned.fill(
          bottom: 10,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3, // Based on the number of images
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: currentSlide == index ? 15 : 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color:
                        currentSlide == index ? Colors.white : Colors.grey[400],
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      if (currentSlide == index)
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 3,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
