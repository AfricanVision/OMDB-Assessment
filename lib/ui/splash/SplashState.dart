import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../about/internal/application/NavigatorType.dart';
import '../../about/internal/application/TextType.dart';
import '../../configs/Navigator.dart';
import '../../designs/Component.dart';
import '../../utils/Colors.dart';
import '../../utils/Images.dart';
import '../home/Home.dart';
import 'ConnectSplash.dart';
import 'Splash.dart';
import 'ViewSplash.dart';

//the initial entry point into the application.

class SplashState extends State<Splash> implements ConnectSplash {

  ViewSplash? _model;

  @override
  Widget build(BuildContext context) {

    return ViewModelBuilder<ViewSplash>.reactive(
        viewModelBuilder: () => ViewSplash(context, this),
        onViewModelReady: (viewModel) => {
          _model = viewModel,
          _initialise()
        },
        builder: (context, viewModel, child) =>  WillPopScope(child: Scaffold(
          backgroundColor:  colorMilkWhite,
          body:  LayoutBuilder(
            builder: (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                    minWidth: viewportConstraints.maxWidth,
                  ),
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children : [
                        text("ROAM", 4, TextType.Medium),
                        Column(mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(logoPng, width: 200, height: 200,fit: BoxFit.contain,),

                            Padding(padding: const EdgeInsets.all(24),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    textWithColor("OMDB Assessment done by:", 14, TextType.Regular, colorPrimaryDark),
                                    textWithColor("ALVIN NYASIMI.", 14, TextType.Bold, colorPrimaryDark),
                                  ],))
                          ],),
                        Padding(padding: EdgeInsets.only(left: 16, right: 16,bottom: MediaQuery.of(context).padding.bottom + 8),
                          child:  text("Roam software engineer assessment test.", 7, TextType.Regular),)
                      ]),
                ),
              );
            },
          ),
        ), onWillPop: () async {
          if (_model?.loadingEntry == null && _model?.errorEntry == null) {
            return false;
          }
          return false;
        }));

  }


  _initialise() async{

    //Show the screen for 2 seconds before loading the home page.
    Timer(const
    Duration(seconds: 2),
            () => ApplicationNavigation().navigateToPage(NavigatorType.openFully, const Home(), context));

  }



}
