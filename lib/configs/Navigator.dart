import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../about/internal/application/NavigatorType.dart';

class ApplicationNavigation {

  void navigateToPage(NavigatorType type, dynamic path, BuildContext context) {
    _runSec(context, type, path);
  }

  Future _runSec(BuildContext context, NavigatorType type, dynamic path) async {


    bool value = true;


      if (kDebugMode) {
        //added to reduce check when conducting changes in emulator and upgrades need for testing.
        value = false;
      }


        switch (type) {
          case NavigatorType.openFully:
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => path));
            break;
          case NavigatorType.justOpen:
            Navigator.push(
                context, PageTransition(type: PageTransitionType.size,
                alignment: Alignment.center,
                child: path));
            break;
          case NavigatorType.replaceCurrent:
            Navigator.pushReplacement(
                context, PageTransition(type: PageTransitionType.scale,
                alignment: Alignment.center,
                curve: Curves.ease,
                duration: Duration(microseconds: 9000),
                child: path));
            break;
          case NavigatorType.makeNewMain:
            Navigator.pushAndRemoveUntil(
                context, PageTransition(type: PageTransitionType.fade,
                alignment: Alignment.center,
                child: path), ModalRoute.withName('/'));
            break;
        }

  }

   Future<dynamic> navigateToPageWithData( dynamic path, BuildContext context) async {
    return await Navigator.push(
      context, MaterialPageRoute(builder: (context) =>
        path,
    ),
    );
  }


}