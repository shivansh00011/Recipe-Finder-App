import 'package:dishcovery/components/circle_button.dart';
import 'package:dishcovery/components/custom_clip_path.dart';
import 'package:dishcovery/components/ingredient_list.dart';
import 'package:dishcovery/constants/share.dart';
import 'package:dishcovery/constants/start_cooking.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DetailScreen extends StatefulWidget {
  final Map<String, dynamic> item;
  const DetailScreen({super.key, required this.item});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  @override
  Widget build(BuildContext context) {
    var myBox = Hive.box('saved');

    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 236, 236),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: h*.44,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(widget.item['image']), fit: BoxFit.cover)
                  ),
                ),
                Positioned(
                  top: h*.06, left: w*.05,
                  child: const CircleAvatar(
                  backgroundColor: Colors.redAccent,
                  child: BackButton(color: Colors.white,),
                ))
              ],
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: w*.04),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20,),
                Text(widget.item['label'], style: TextStyle(fontSize: w*.05, fontWeight: FontWeight.w700, color: Colors.black ),),
                const SizedBox(height:22),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: (){
                        ShareRecipe.share(widget.item['url']);
                      },
                      child: CircleButton(icon: Icons.share, label: 'Share')),
                      ValueListenableBuilder(valueListenable: myBox.listenable(), builder:(context,box,_){
                        String key = widget.item['label'];
                        bool saved = myBox.containsKey(key); 
                        if(saved){
                          return  GestureDetector(
                            onTap: (){
                              myBox.delete(key);
                              const SnackBar(
                                duration: Duration(seconds: 1),
                                content: Text('Recipe Deleted'));
                            },
                            child: CircleButton(icon: Icons.favorite, label: 'Saved'));
                        }else{
                          return  GestureDetector(
                            onTap: (){
                              myBox.put(key, key);
                              const SnackBar(
                                duration: Duration(seconds: 1),
                                content: Text('Recipe Saved Successfully'));
                            },
                            child: CircleButton(icon: Icons.favorite_outline, label: 'Save'));

                        }
                      } ),
                   
                   
                  ],
                ),
                SizedBox(height: h*.02,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Direction', style: TextStyle(fontWeight: FontWeight.bold, fontSize: w*.04),),
                    SizedBox(width: w*.34,child: ElevatedButton(onPressed: (){
                      StartCooking.startcooking(widget.item['url']);
                    }, child: const Text('Start'),))
                  ],
                ), 
                SizedBox(height: h*.02,),
        
                Container(
                  height: h*.07,
                  width: w,
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: ClipPath(
                          clipper: CustomClipPath(),
                          child: Container(
                            color: Colors.redAccent,
                            child: Center(
                              child: Text('Ingredients Required', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,fontSize: w*.04),),
                            ),
                          ),
                        )),
                        Expanded(
                          flex: 1,
                          child: Container(
                            color: Colors.white,
                            child: const Center(
                              child: Text('6\nItems'),
                            ),
                          ))
                    ],
                  ),
                ),
                SizedBox(height: h*1.8,
                child: IngredientList(
                  ingredients: widget.item['ingredients'],
                ),
                ),
                

        
        
              ],
            ),
            )
          ],
        ),
      ),
    );
  }
}