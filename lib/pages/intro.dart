import 'package:dishcovery/pages/login.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/first.png'), fit: BoxFit.fill )
      ),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginPage()));
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 560, right: 20, left: 20),
              child: Container(
                height: 60,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(14)
                ),
                child: const Center(
                  child: Text("Get Started", style: TextStyle(fontSize: 20, color: Colors.white, decoration: TextDecoration.none),),
                ),
                 
              ),
            )
          ],
        ),
      ),
    );
  }
}