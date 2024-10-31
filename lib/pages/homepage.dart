import 'package:dishcovery/components/home_appbar.dart';
import 'package:dishcovery/components/tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           const  HomeAppBar(),

            const SizedBox(height: 20,),
            Container(
              height: 220,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(14)
              ),
              child: SizedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                
                  
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, top: 37),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Cook the best\nrecipes at home", style: GoogleFonts.didactGothic(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
                          const SizedBox(height: 30,),
                          Container(
                            height: 35,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14)
                            ),
                            child: Center(
                              child: Text("Explore", style: GoogleFonts.montserrat(fontSize: 15),),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 12,),
                    Container(
                      height: 390,
                      width: 170,
                      decoration: const BoxDecoration(
                        image: DecorationImage(image: AssetImage('assets/chef.png'))
                      ),
                    )
                  ],
                ),
              ),

            ),

            const SizedBox(height: 25,),

            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Categories", style: TextStyle(fontWeight: FontWeight.bold),),
                Text("See all", style: TextStyle(color: Colors.blue,),)

              ],
            ),
            const SizedBox(height: 18,),
            const TabBarWidget()

            
            
          ],
        ),
        ),
      )),
    );
  }
}