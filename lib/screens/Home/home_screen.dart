import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/category.dart';
import 'package:shop/models/product_model.dart';
import 'package:shop/provider/HomeProvider.dart';
import 'package:shop/screens/Home/Widgets/home_app_bar.dart';
import 'package:shop/screens/Home/Widgets/image_slider.dart';
import 'package:shop/screens/Home/Widgets/product_cart.dart';
import 'package:shop/screens/Home/Widgets/search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<List<Product>> selectcategories = [
      all,
      shoes,
      beauty,
      womenFashion,
      jewelry,
      menFashion
    ];

    return Scaffold(
      body: SingleChildScrollView(
        // Remove Expanded here
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 35),
              // Custom AppBar
              const CustomAppBar(),
              const SizedBox(height: 20),
              // Search Bar
              const MySearchBAR(),
              const SizedBox(height: 20),
              Consumer<HomeProvider>(
                // Make sure HomeProvider is properly initialized
                builder: (context, homeProvider, child) {
                  return ImageSlider(
                    currentSlide: homeProvider.currentSlider,
                    onChange: (value) {
                      homeProvider.updateSlider(value);
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              // Category Selection
              Consumer<HomeProvider>(
                builder: (context, homeProvider, child) {
                  return CategoryItems(
                    onCategorySelected: (index) {
                      homeProvider.updateCategory(index);
                    },
                    selectedIndex: homeProvider.selectedIndex,
                  );
                },
              ),
              const SizedBox(height: 20),
              if (selectcategories.isNotEmpty)
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Special For You",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      "See all",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 10),
              // Shopping Items (GridView)
              Consumer<HomeProvider>(
                // Ensure HomeProvider state is properly managed
                builder: (context, homeProvider, child) {
                  return GridView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemCount:
                        selectcategories[homeProvider.selectedIndex].length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product: selectcategories[homeProvider.selectedIndex]
                            [index],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryItems extends StatelessWidget {
  final Function(int) onCategorySelected;
  final int selectedIndex;

  const CategoryItems({
    super.key,
    required this.onCategorySelected,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoriesList.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onCategorySelected(index),
            child: CategoryItemCard(
              category: categoriesList[index],
              isSelected: selectedIndex == index,
            ),
          );
        },
      ),
    );
  }
}

class CategoryItemCard extends StatelessWidget {
  final Category category;
  final bool isSelected;

  const CategoryItemCard({
    super.key,
    required this.category,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: isSelected
            ? Colors.deepOrangeAccent
            : Colors.transparent, // Add color dynamically
      ),
      child: Column(
        children: [
          Container(
            height: 65,
            width: 65,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(category.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            category.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
