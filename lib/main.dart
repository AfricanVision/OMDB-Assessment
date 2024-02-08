
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:omdbassestment/ui/splash/Splash.dart';
import 'package:omdbassestment/utils/Colors.dart';
import 'about/internal/application/TextType.dart';
import 'designs/Component.dart';


void main() async{

  //initialise the .env file that securely store all api keys and endpoints.

  await dotenv.load(fileName: ".env");

  //initialise the project.

  runApp(const OmdbAssessment());

}



class OmdbAssessment extends StatelessWidget {
  const OmdbAssessment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      builder: (context,children) {
        return MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(0.6, 1.1)), child: children!);
      },
      theme: ThemeData(
        disabledColor: colorGrey,
        dialogTheme: DialogTheme(
          backgroundColor: colorPrimaryDark,
          elevation: 5,
          contentTextStyle: TextStyle(
              color: colorGrey,
              fontFamily: getTextType(TextType.Regular),
              fontSize: 12,
            ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          titleTextStyle:TextStyle(
              color: colorGrey,
              fontFamily: getTextType(TextType.Bold),
              fontSize: 16,
            ),
        ),
        dividerColor: colorGrey, colorScheme: ColorScheme.fromSwatch(primarySwatch: createMaterialColor(colorPrimary)).copyWith(error: colorPrimary)


      ),
      home: const Splash(),
    );
  }
}
