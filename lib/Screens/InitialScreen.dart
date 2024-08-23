// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'PlayScreen.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
                "https://dm0qx8t0i9gc9.cloudfront.net/watermarks/image/rDtN98Qoishumwih/seamless-texture-with-tic-tac-toe-vector_Xyx2l8_SB_PM.jpg"),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 60,
              right: 60,
              top: 610,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/playScreen');
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(20),
                  elevation: 10,
                  backgroundColor: Color(0xff03756a),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "𝑷𝒍𝒂𝒚 𝑵𝒐𝒘 !!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
