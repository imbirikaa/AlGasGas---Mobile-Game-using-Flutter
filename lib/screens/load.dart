import 'package:barra_modo3/screens/explanation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class LoadScreen extends StatelessWidget {
  const LoadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          // Show a confirmation dialog
          final shouldGoBack = await showDialog<bool>(
            context: context,
            builder: (context) {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: AlertDialog(
                  title: Text(
                    "تأكيد",
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary,
                              
                    ),
                  ),
                  content: Text(
                    "هل أنت متأكد تبي تطلع ؟",
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                     color: Theme.of(context).colorScheme.secondary,
                              
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () =>
                          Navigator.of(context).pop(false), // Stay on the page
                      child: Text(
                        "لا",
                        style: TextStyle(
                      fontFamily: 'Rubik',
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.primary,
                              
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        SystemNavigator.pop();
                      }, // Go back
                      child: Text(
                        "نعم",
                        style: TextStyle(
                      fontFamily: 'Rubik',
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Colors.redAccent,
                                  
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
          return shouldGoBack ?? false; // Return false if dialog is dismissed
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primary.withAlpha(200),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'لعبة من القصقاص ؟',
                  style: TextStyle(
                      fontFamily: 'Rubik',
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                    color: Theme.of(context).colorScheme.onSecondary,
                        
                  ),
                ),
                SizedBox(height: 30),
                Image.asset(
                  'assets/images/spy.png',
                  width: 200,
                  color: const Color.fromARGB(240, 255, 255, 255),
                ),
                SizedBox(height: 30),
                SizedBox(height: 30),
                ElevatedButton.icon(
                  iconAlignment: IconAlignment.end,
                  label: Text(
                    'ابدأ اللعبة',
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary,
                              
                    ),
                  ),
                  icon: Icon(Icons.start),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (ctx) => ExplanationScreen()),
                      (route) => false,
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
