import 'package:dishcovery/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SaveScreen extends StatelessWidget {
  const SaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    var myBox = Hive.box('saved');
    return Scaffold(
      appBar: CustomAppBar(title: 'Saved', back: false),
      body: Padding(padding: EdgeInsets.only(top: 10, right: 8, left: 8),
      child: ValueListenableBuilder(valueListenable: myBox.listenable(),builder: (context,box,_){
        return ListView.builder(
          itemCount: box.length,
          itemBuilder: (context,index){
            var data = box.values.toList();
            return ListTile(
              title: Container(
                height: h*.085,
                color: Colors.grey[100],
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(data[index]) ),
                      PopupMenuButton(itemBuilder: (context){
                        return const[
                          PopupMenuItem(child: Text('share'), value: 'share',),
                          PopupMenuItem(child: Text('delete'), value: 'delete',)

                        ];
                      })
                  ],
                ),

              ),
            );

        });
      }, ) 
      ),
    );
  }
}