
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../about/external/data/ApiError.dart';
import '../../about/internal/application/NavigatorType.dart';
import '../../about/internal/application/TextType.dart';
import '../../about/internal/memory/InternalMemory.dart';
import '../../comms/Comms.dart';
import '../../configs/Navigator.dart';
import '../../utils/Colors.dart';
import '../../designs/Component.dart';
import '../../informatics/AppDataManager.dart';
import '../../informatics/DataManager.dart';
import '../home/Home.dart';

//the base class for all view in the application.

class ParentViewModel extends ChangeNotifier{

  OverlayEntry? loadingEntry;

  OverlayEntry? networkEntry;

  OverlayEntry? errorEntry;

  late DataManager dataManager;

  BuildContext context;

  OverlayState? overlayState;

  ParentViewModel(this.context){
    overlayState = Overlay.of(context);
    dataManager = AppDataManager(InternalMemory(),  Comms(InternalMemory()));

  }

  DataManager getDataManager(){
    return dataManager;
  }


  //function to show loading screen on api call.
  void showLoading(String loadingText) async {

      if (loadingEntry == null) {
        _hideKeyboard();
        loadingEntry = OverlayEntry(builder: (context) {
          return Scaffold(
            backgroundColor: colorPrimaryDark.withOpacity(0.95),
            body: SafeArea(
              child: Center(child: Column(mainAxisSize: MainAxisSize.min,
                children: [const SpinKitDancingSquare(
                  color: colorPrimary,
                  size: 120,
                ),
                  Padding(padding: const EdgeInsets.only(top: 40, bottom: 40),
                    child: textWithColor(
                        loadingText,  24, TextType.Bold,colorPrimary),
                  )
                ],),),
            ),);
        });

        overlayState?.insert(loadingEntry!);
        notifyListeners();
    }
  }

  _hideKeyboard(){
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }



  void noNetwork(Function() actions) async {

    if (networkEntry == null) {
      _hideKeyboard();
      networkEntry = OverlayEntry(builder: (context) {
        return Scaffold(
          backgroundColor: colorPrimaryDark1.withOpacity(0.95),
          body: SafeArea(
            child: Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.wifi_off_sharp,
                size: 120,
                color: Colors.white,),
                Padding(padding: const EdgeInsets.only(top: 40, bottom: 40, left: 40, right: 40),
                  child: Column(mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    textWithColor(
                        "Oops, No Internet Connections", 30, TextType.Bold,colorWhite),
                    Padding(padding: const EdgeInsets.only(top: 10),
                    child:   textWithColor(
                        "Kindly make sure that your wifi or cellular data are turned on and try again.", 14, TextType.Medium,colorWhite),),

                 Padding(padding: const EdgeInsets.only(top: 40),
                    child: raisedButton("Retry", actions),)
                  ],),
                )
              ],),),
          ),);
      });

      overlayState?.insert(networkEntry!);
      notifyListeners();
    }
  }

  Future<bool> hasNetwork(Function() actions) async {
    closeLoading();
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }else{
      noNetwork(actions);
      return false;
    }

  }

  //Application error handling function the processes all network related error.
  handleError(Object? error, Function() actions, Function() closeAction,String buttonName) {

    closeLoading();

    if (error is DioException) {

      DioException dioError = error;

      if (error.type == DioExceptionType.connectionTimeout) {
        showError(actions, closeAction, ApiError(error: "An error occurred while processing you request.",
            response: "Kindly ensure that you have a stable internet connection.",), buttonName);
      }else if (error.type == DioExceptionType.receiveTimeout) {
        showError(actions, closeAction, ApiError(error: "An error occurred while processing you request.",
          response: "Kindly ensure that you have a stable internet connection.",), buttonName);
      }else if (dioError.response?.statusCode == 401) {
        showError(actions, closeAction, ApiError(error: "You do not have the required rights to query from this request.",
          response: "Request Error.",), buttonName);
      }else if(dioError.response?.statusCode == 500){

        ApiError error = getRequestError(dioError.response?.data);

          showError(actions, closeAction, error, buttonName);

      }else {
       showError(actions, closeAction, ApiError(error: "An error occurred while processing you request.",
            response: "Request Error",), buttonName);
      }

    }else if(error is Exception){
      showError(actions, closeAction, ApiError( error: "An error occurred while processing you request.",
          response: "Request Error",), buttonName);
    }else if(error is int){
      showError(actions, closeAction, ApiError( error: "An error occurred while processing you request.",
          response: "Request Error",), buttonName);
    } else {
      showError(actions, closeAction, ApiError( error: "An error occurred while processing you request.",
          response: "Request Error",), buttonName);
    }

  }


  closeLoading(){
    if(loadingEntry != null){
        loadingEntry?.remove();
        loadingEntry = null;
        notifyListeners();
    }
  }

  closeNetwork(){
    if(networkEntry != null){
      networkEntry?.remove();
      networkEntry = null;
      notifyListeners();
    }
  }

  dismissError(){
    if(errorEntry != null){
      errorEntry?.remove();
      errorEntry = null;
      notifyListeners();
    }
  }



  void showError(Function() actions, Function() closeActions, ApiError error, String buttonText) async {

    if (errorEntry == null) {
      _hideKeyboard();
      errorEntry = OverlayEntry(builder: (context) {
        return Scaffold(
          backgroundColor: colorMilkWhite,
          body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints viewportConstraints) {
              return ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                  minWidth: viewportConstraints.maxWidth,
                ),
                child: SafeArea(child: SingleChildScrollView(child:
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    
                    const Align(alignment: Alignment.center,
                      child: Icon(
                        Icons.error,
                        size: 260,
                        color: colorPrimary,
                      ),),

                    SizedBox(width: double.infinity,
                      child: Card(
                        color: colorWhite,
                        child: Padding(padding: const EdgeInsets.only( left: 16, right: 16, top: 24, bottom: 24),
                          child: text(error.response, 20, TextType.Bold),),
                      ),),

                    Padding(padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16, top: 24),
                        child: text(error.error, 12, TextType.Regular)),

                    Padding(padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [

                        Expanded(child: textButtonWithOption(buttonText, 16,TextType.Bold,colorPrimary,actions),),

                        Expanded(child: raisedButton("Close", closeActions),)


                      ],),)

                  ],),),),
              );
            },
          ),
        );
      });

      overlayState?.insert(errorEntry!);
      notifyListeners();
    }
  }




  @override
  void dispose() {
    closeLoading();
    closeNetwork();
    dismissError();
    super.dispose();
  }

  ApiError getRequestError(data) {

    ApiError error;
    try{
      error = ApiError.fromJson(data);
    }catch (e) {

      error = ApiError(response: "Request Error.", error: "An error occurred while processing you request.",);
    }

    return error;
  }




  void launchClientHome() async{

      ApplicationNavigation().navigateToPage(NavigatorType.makeNewMain, const Home(), context);


  }


}
