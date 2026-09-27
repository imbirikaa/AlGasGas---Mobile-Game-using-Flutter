import 'package:barra_modo3/screens/explanation.dart';
import 'package:barra_modo3/widgets/exit_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class LoadScreen extends StatelessWidget {
  const LoadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExitConfirmationScope(
        message: "هل أنت متأكد تبي تطلع ؟",
        subtitle: null,
        onConfirm: () {
          Navigator.of(context).pop();
          SystemNavigator.pop();
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
