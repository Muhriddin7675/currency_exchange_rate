import 'package:flutter/material.dart';

class Exaple extends StatelessWidget {
  const Exaple({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Center(
        child: Image.asset("assets/ic_currency.png",height: 100,width: 100,),
        // child: Image.asset("assets/ic_currency.png",height: 100,width: 100,),
      ),
    );
  }
}
