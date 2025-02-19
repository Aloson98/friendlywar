import 'package:flutter/material.dart';
import 'package:friendlywar/components/AppText.dart';
import 'package:friendlywar/components/AppButton.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                opacity: 0.5,
                image: AssetImage('assets/images/BG.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Spacer(),
              Card(
                color: Colors.transparent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: EdgeInsets.only(top: 10, left: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  height: MediaQuery.of(context).size.width * 0.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/images/gaming.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    TitleText(text: 'Welcome'),
                    SizedBox(
                      height: 20,
                    ),
                    subTitle(
                      text:
                          'Hapa ukipigwa kama umepiga, na ukipiga kama umepiga',
                      aligner: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.all(16),
                child: AppButton(
                  text: "Proceed",
                  onPressed: () {
                    // Handle proceed button action
                    Navigator.pushNamed(context, "/login");
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
