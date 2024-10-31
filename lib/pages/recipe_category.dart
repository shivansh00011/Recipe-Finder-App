import 'package:dishcovery/components/recipe_category_view.dart';
import 'package:dishcovery/constants/category_list.dart';
import 'package:dishcovery/pages/all_recipe.dart';
import 'package:flutter/material.dart';

class RecipeCategory extends StatelessWidget {
  const RecipeCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(.1),
      body: Padding(padding: EdgeInsets.symmetric(horizontal:w*.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: h*.08,),
          Text('For You', style: TextStyle(
            fontWeight: FontWeight.bold,  fontSize: w*.06
          ),),
          SizedBox(height: h*.01,),
          SizedBox(
            height: h*.106,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RecipeCategoryView(name: name[0], image: images[0]),
                RecipeCategoryView(name: name[1], image: images[1]),
                RecipeCategoryView(name: name[2], image: images[2]),
                RecipeCategoryView(name: name[3], image: images[3]),
              ],
            ),
          ),
          SizedBox(height: h*.01,),
          Text('For You', style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: w*.055
          ),),
          
          SizedBox(
            height: h*.45,
            child: GridView.builder(
              itemCount: categoriesimages.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: h*.01, mainAxisSpacing: w*.021),
              itemBuilder: (context, index){
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> AllRecipe(recipe: categories[index])));
                  },
                  child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: h*.043,
                          width: w*.08,
                          child: Image.asset(categoriesimages[index]),
                        ),
                        SizedBox(height: h*.003,),
                        Text(categories[index], style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black45
                        ),)
                        
                      ],
                    ),
                  ),
                                ),
                );
              },
              
            ),
          ),
        
          Text('Your Preference', style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: w*.055
          ),),
          SizedBox(height: h*.13,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RecipeCategoryView(name: 'Easy', image: images[0]),
              RecipeCategoryView(name: 'Quick', image: images[2]),
              RecipeCategoryView(name: 'Chicken', image: images[1]),
              RecipeCategoryView(name: 'Meat', image: images[3]),
            ],
          ),
          )

        ],
      ),
      ),
    );
  }
}