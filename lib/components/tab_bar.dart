import 'package:dishcovery/constants/constant_function.dart';
import 'package:dishcovery/pages/detail_screen.dart';
import 'package:flutter/material.dart';

class TabBarWidget extends StatefulWidget {
  const TabBarWidget({super.key});

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            height: h * .05,
            child: TabBar(
              unselectedLabelColor: Colors.red,
              labelColor: Colors.white,
              dividerColor: Colors.white,
              indicator: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              labelPadding: EdgeInsets.symmetric(horizontal: w * .012),
              tabs: const [
                TabItem(title: 'Breakfast'),
                TabItem(title: 'Lunch'),
                TabItem(title: 'Dinner'),
                TabItem(title: 'Quick'),
              ],
            ),
          ),
          SizedBox(height: h * .02),
          SizedBox(
            height: h * .3,
            child: const TabBarView(
              children: [
                HomeTabBarView(recipe: 'breakfast'),
                HomeTabBarView(recipe: 'lunch'),
                HomeTabBarView(recipe: 'dinner'),
                HomeTabBarView(recipe: 'quick'),
              ],
            ),
          ),
          const SizedBox(height: 8),

          const Text('Dish Categories', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold , fontSize: 16),),
          const SizedBox(height: 28,),
          
          // Dish Category Section
          const DishCategorySection(),
        ],
      ),
    );
  }
}

class DishCategorySection extends StatefulWidget {
  const DishCategorySection({super.key});

  @override
  _DishCategorySectionState createState() => _DishCategorySectionState();
}

class _DishCategorySectionState extends State<DishCategorySection> {
  String selectedCategory = 'chicken'; // Default category

  void _updateCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    return Column(
      children: [
        // Dish Category Icons
        SizedBox(
          height: h * 0.1,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              DishCategoryIcon(
                imageUrl: 'https://www.tasteofhome.com/wp-content/uploads/2021/06/Chicken-Vindaloo.jpg?fit=700%2C700',
                title: 'Chicken',
                onTap: () => _updateCategory('chicken'),
              ),
              const SizedBox(width: 52),
              DishCategoryIcon(
                imageUrl: 'https://www.southernliving.com/thmb/KxG5hdQCN7QVFF7ZGt-1i_us9H4=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/StrawberryUpsideDownCake_Fellows_Beauty-04_3x2_8147-94fcbc0ee5a0446ea7a0a3a2c8ed4d5f.jpg',
                title: 'Cake',
                onTap: () => _updateCategory('cake'),
              ),
              const SizedBox(width: 52),
              DishCategoryIcon(
                imageUrl: 'https://images.squarespace-cdn.com/content/v1/551841f8e4b0b6960904347e/1595789540982-IX47LD0OJ0XHPVSVEKT6/07_22_2020_Mutton+Curry_2b_saynomaste.png',
                title: 'Mutton',
                onTap: () => _updateCategory('mutton'),
              ),
              const SizedBox(width: 52),
              DishCategoryIcon(
                imageUrl: 'https://img.freepik.com/free-photo/top-view-delicious-food-table_23-2150857996.jpg',
                title: 'Veg',
                onTap: () => _updateCategory('veg'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Dish Category Tab View
        SizedBox(
          height: h * 0.3, // Set appropriate height
          child: DishCategoryTabView(category: selectedCategory),
        ),
      ],
    );
  }
}

class TabItem extends StatelessWidget {
  final String title;
  const TabItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(fontSize: 11),
          ),
        ),
      ),
    );
  }
}

class HomeTabBarView extends StatelessWidget {
  final String recipe;
  const HomeTabBarView({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 12,
      child: FutureBuilder(
        future: ConstantFunction.getResponse(recipe),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No Data'));
          }
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              Map<String, dynamic> snap = snapshot.data![index];
              int time = snap['totalTime'].toInt();
              int calories = snap['calories'].toInt();
              return Container(
                margin: EdgeInsets.only(right: w * .05),
                width: w * .5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailScreen(item: snap,) ));
                      },
                      child: Container(
                        width: w * .5,
                        height: h * .20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage(snap['image']),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      snap['label'],
                      style: TextStyle(fontSize: w * .04, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${calories.toString()} kcal • ${time.toString()} mins",
                      style: TextStyle(fontSize: w * 0.03, color: Colors.grey),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 15),
            itemCount: snapshot.data!.length,
          );
        },
      ),
    );
  }
}

class DishCategoryIcon extends StatelessWidget {
  final String imageUrl;
  final String title;
  final VoidCallback onTap;

  const DishCategoryIcon({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(imageUrl),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }
}

class DishCategoryTabView extends StatelessWidget {
  final String category;
  const DishCategoryTabView({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    
    return FutureBuilder(
      future: ConstantFunction.getResponse(category),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No Data'));
        }

        return ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> snap = snapshot.data![index];
            int time = snap['totalTime'].toInt();
            int calories = snap['calories'].toInt();

            return Container(
              margin: EdgeInsets.only(right: w * 0.05),
              width: w * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailScreen(item: snap)));
                    },
                    child: Container(
                      width: w * 0.5,
                      height: h * 0.20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: NetworkImage(snap['image']),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    snap['label'],
                    style: TextStyle(fontSize: w * 0.04, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${calories.toString()} kcal • ${time.toString()} mins",
                    style: TextStyle(fontSize: w * 0.03, color: Colors.grey),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(width: 15),
        );
      },
    );
  }
}
