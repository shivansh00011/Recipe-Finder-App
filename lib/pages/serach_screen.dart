import 'package:dishcovery/components/custom_app_bar.dart';
import 'package:dishcovery/constants/search_tag.dart';
import 'package:dishcovery/pages/all_recipe.dart';
import 'package:flutter/material.dart';

class SerachScreen extends StatelessWidget {
  const SerachScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    TextEditingController search = TextEditingController();
    return Scaffold(
      appBar: const CustomAppBar(title: 'Search', back: false),
      body: Padding(padding: EdgeInsets.symmetric(vertical: h*.016, horizontal: w*.032),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: search,
      decoration: InputDecoration(
        hintText: "What's cooking on your mind?",
        hintStyle: TextStyle(color: Colors.grey[600]), // Hint text style
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: Colors.blue), // Border color when focused
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.search, color: Colors.blue), // Search icon
          onPressed: () {
            // Define your search action here
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AllRecipe(recipe: search.text)));
          },
        ),
      ),

    ),
    SizedBox(height: h*.04,),
    Text('Search Tags', style: TextStyle(
      fontWeight: FontWeight.bold,fontSize: w*.06
    ),),
    Wrap(
      spacing: 6,
      children: tags.map((label){
        return ElevatedButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AllRecipe(recipe: label )));
        }, child: Text(label));
        
      },
    ).toList()
    )
        ],
      ),
      ),
    );
  }
}