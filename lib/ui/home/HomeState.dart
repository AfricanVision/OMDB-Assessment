import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omdbassestment/about/external/data/MovieSearchResponse.dart';
import 'package:omdbassestment/about/external/data/SearchParams.dart';
import 'package:stacked/stacked.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../about/internal/application/TextType.dart';
import '../../designs/Responsive.dart';
import '../../utils/Colors.dart';
import '../../designs/Component.dart';
import '../../utils/Validators.dart';
import 'ConnectHome.dart';
import 'Home.dart';
import 'ViewHome.dart';

class HomeState extends State<Home> implements ConnectHome{

  ViewHome? _model;

  bool _plotOption = false;

  MovieSearchResponse? _result;

  final _searchForm = GlobalKey<FormState>();

  final TextEditingController _searchController = TextEditingController();

  final TextEditingController _yearController = TextEditingController();

  int _selectedTypeIndex = 0;

  bool _imdbSearch = false;


  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ViewHome>.reactive(
        viewModelBuilder: () => ViewHome(context, this),
        onViewModelReady: (viewModel) => {
          _model = viewModel,
        },
        builder: (context, viewModel, child) => WillPopScope(
            child: Responsive(mobile: _mobileView(), desktop: _desktopView(), tablet: _tabletView(),
    ), onWillPop: () async {
      if (_model?.loadingEntry == null && _model?.errorEntry == null) {
        _closeApp();
      }
      return false;
    }));
  }

  _mobileView(){
    return Scaffold(
      backgroundColor:  colorWhite,
      body:  LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SafeArea(child: SingleChildScrollView(

            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  color: colorMilkWhite,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      text("Movie",40, TextType.Regular),

                      text("Search",20, TextType.Regular),

                      text("Search for any of your favourite films or series below. Toggle the button to perform an IMDB id search.",10, TextType.Regular),

                      Padding(padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                          child: Form(
                            key: _searchForm,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 16, bottom: 16,),
                              child: Column(mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [

                                  Padding(padding: const EdgeInsets.only( top: 16),
                                    child: inputField("Search",(value) {
                                      return getErrorType(value!, 1);
                                    }, true, TextInputType.text,
                                        "Enter your search parameter.", const Icon(Icons.search,
                                          color: Colors.grey,
                                          size: 14,), _searchController,[LengthLimitingTextInputFormatter(50)]),),

                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      text("IMDB Search?: ",12, TextType.Bold),

                                      Switch(
                                        // This bool value toggles the switch.
                                        value: _imdbSearch,

                                        thumbColor: const MaterialStatePropertyAll<Color>(Colors.black),
                                        onChanged: (bool value) {
                                          // This is called when the user toggles the switch.
                                          setState(() {
                                            _imdbSearch = value;
                                          });
                                        },
                                      ),


                                    ],),

                                  Visibility(
                                    visible: !_imdbSearch,
                                    child:    Padding(padding: const EdgeInsets.only( top: 16),
                                      child: inputField("Year",(value) {
                                        return getErrorType(value!, 2);
                                      }, true, TextInputType.text,
                                          "Enter your movie year.", const Icon(Icons.calendar_month,
                                            color: Colors.grey,
                                            size: 14,), _yearController,[LengthLimitingTextInputFormatter(4)]),),)


                                ],),
                            ),)),


                      Padding(padding: const EdgeInsets.only(left: 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Visibility(
                              visible: !_imdbSearch,
                              child: ToggleSwitch(
                                initialLabelIndex: _selectedTypeIndex,
                                totalSwitches: 4,
                                labels: const ['Any','Movie', 'Series', 'Episode'],
                                onToggle: (index) {
                                  _selectedTypeIndex = index ?? 0;
                                },
                              ),
                            ),

                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                text("Plot Length: ",12, TextType.Bold),

                                Switch(
                                  // This bool value toggles the switch.
                                  value: _plotOption,

                                  thumbColor: const MaterialStatePropertyAll<Color>(Colors.black),
                                  onChanged: (bool value) {
                                    // This is called when the user toggles the switch.
                                    setState(() {
                                      _plotOption = value;
                                    });
                                  },
                                ),
                                text(_plotOption ? "Long" : "Short",16, TextType.Bold),


                              ],),
                          ],),),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          textButtonWithOption("Reset", 14, TextType.Bold, colorPrimary, () { _clearAll();}),
                          raisedButton("Search", () { _requestMovies();})
                        ],)


                    ],),),

                Visibility(
                    visible: _result != null,
                    child: Padding(padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          Visibility(
                              visible: (_result?.title ?? "").isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    textWithColor("Title", 10, TextType.Regular, colorAccent),

                                    textWithColor(_result?.title ?? "", 42, TextType.Bold, colorPrimaryDark1),

                                  ],),)),

                          Visibility(
                              visible: (_result?.poster ?? "").isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8, bottom: 8),
                                child:  Image.network(_result?.poster ?? "",
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  height: 400,),)),

                          Visibility(
                            visible: (_result?.title ?? "").isNotEmpty,
                            child:
                            textWithColor("Results Summary:", 24, TextType.Medium, colorPrimaryDark1),),

                          Visibility(
                              visible: (_result?.type ?? "").isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    textWithColor("Type", 10, TextType.Regular, colorAccent),

                                    textWithColor((_result?.type ?? "").toUpperCase(), 18, TextType.Regular, colorPrimaryDark1),

                                  ],),)),

                          Visibility(
                              visible: (_result?.year ?? "").isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    textWithColor("Year", 10, TextType.Regular, colorAccent),

                                    textWithColor(_result?.year ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                  ],),)),

                          Visibility(
                              visible: (_result?.rated ?? "").isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    textWithColor("Rated", 10, TextType.Regular, colorAccent),

                                    textWithColor(_result?.rated ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                  ],),)),

                          Visibility(
                              visible: (_result?.released ?? "").isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    textWithColor("Released", 10, TextType.Regular, colorAccent),

                                    textWithColor(_result?.released ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                  ],),)),

                          Visibility(
                              visible: (_result?.genre ?? "").isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    textWithColor("Genre", 10, TextType.Regular, colorAccent),

                                    textWithColor(_result?.genre ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                  ],),)),

                          Visibility(
                              visible: (_result?.director ?? "").isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    textWithColor("Director", 10, TextType.Regular, colorAccent),

                                    textWithColor(_result?.director ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                  ],),)),

                          Visibility(
                              visible: (_result?.writer ?? "").isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    textWithColor("Writer", 10, TextType.Regular, colorAccent),

                                    textWithColor(_result?.writer ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                  ],),)),

                          Visibility(
                              visible: (_result?.actors ?? "").isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    textWithColor("Actors", 10, TextType.Regular, colorAccent),

                                    textWithColor(_result?.actors ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                  ],),)),



                          Visibility(
                              visible: (_result?.language ?? "").isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    textWithColor("Language", 10, TextType.Regular, colorAccent),

                                    textWithColor(_result?.language ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                  ],),)),

                          Visibility(
                              visible: (_result?.country ?? "").isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    textWithColor("Country", 10, TextType.Regular, colorAccent),

                                    textWithColor(_result?.country ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                  ],),)),

                          Visibility(
                              visible: (_result?.awards ?? "").isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    textWithColor("Awards", 10, TextType.Regular, colorAccent),

                                    textWithColor(_result?.awards ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                  ],),)),

                          Visibility(
                              visible: (_result?.dVD ?? "").isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    textWithColor("DVD", 10, TextType.Regular, colorAccent),

                                    textWithColor(_result?.dVD ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                  ],),)),


                          Visibility(
                              visible: (_result?.boxOffice ?? "").isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    textWithColor("Box Office", 10, TextType.Regular, colorAccent),

                                    textWithColor(_result?.boxOffice ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                  ],),)),


                          Visibility(
                              visible: (_result?.production ?? "").isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    textWithColor("Production", 10, TextType.Regular, colorAccent),

                                    textWithColor(_result?.production ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                  ],),)),

                          Visibility(
                              visible: (_result?.website ?? "").isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    textWithColor("Website", 10, TextType.Regular, colorAccent),

                                    textWithColor(_result?.website ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                  ],),)),

                          Visibility(
                            visible: (_result?.title ?? "").isNotEmpty,
                            child:
                            Padding(padding: const EdgeInsets.only(top: 24),
                              child: textWithColor("Ratings and Assessments:", 24, TextType.Medium, colorPrimaryDark1),),),

                          Visibility(
                              visible: (_result?.metascore ?? "").isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    textWithColor("Metascore", 10, TextType.Regular, colorAccent),

                                    textWithColor(_result?.metascore ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                  ],),)),

                          Visibility(
                              visible: (_result?.ratings ?? []).isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: _setOtherRatings(),),)),

                          Visibility(
                            visible: (_result?.title ?? "").isNotEmpty,
                            child:
                            Padding(padding: const EdgeInsets.only(top: 24),
                              child: textWithColor("Imdb and More:", 24, TextType.Medium, colorPrimaryDark1),),),



                          Visibility(
                              visible: (_result?.imdbID ?? "").isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    textWithColor("IMDB ID", 10, TextType.Regular, colorAccent),

                                    textWithColor(_result?.imdbID ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                  ],),)),

                          Visibility(
                              visible: (_result?.imdbRating ?? "").isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    textWithColor("IMDB Rating", 10, TextType.Regular, colorAccent),

                                    textWithColor(_result?.imdbRating ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                  ],),)),

                          Visibility(
                              visible: (_result?.imdbVotes ?? "").isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    textWithColor("IMDB Votes", 10, TextType.Regular, colorAccent),

                                    textWithColor(_result?.imdbVotes ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                  ],),)),







                          Visibility(
                              visible: (_result?.plot ?? '').isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    textWithColor("Plot", 10, TextType.Regular, colorAccent),

                                    textWithColor(_result?.plot ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                  ],),)),



                        ],),))
              ],),));
        },
      ),
    );
  }

  _desktopView(){
    return Scaffold(
      backgroundColor:  colorWhite,
      body:  LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SafeArea(child: Row(crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                color: colorMilkWhite,
                width: 400,
                height: double.infinity,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    text("Movie",40, TextType.Regular),

                    text("Search",20, TextType.Regular),

                    text("Search for any of your favourite films or series below. Toggle the button to perform an IMDB id search.",10, TextType.Regular),

                    Padding(padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                        child: Form(
                          key: _searchForm,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 16,),
                            child: Column(mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                Padding(padding: const EdgeInsets.only( top: 16),
                                  child: inputField("Search",(value) {
                                    return getErrorType(value!, 1);
                                  }, true, TextInputType.text,
                                      "Enter your search parameter.", const Icon(Icons.search,
                                        color: Colors.grey,
                                        size: 14,), _searchController,[LengthLimitingTextInputFormatter(50)]),),

                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    text("IMDB Search?: ",12, TextType.Bold),

                                    Switch(
                                      // This bool value toggles the switch.
                                      value: _imdbSearch,

                                      thumbColor: const MaterialStatePropertyAll<Color>(Colors.black),
                                      onChanged: (bool value) {
                                        // This is called when the user toggles the switch.
                                        setState(() {
                                          _imdbSearch = value;
                                        });
                                      },
                                    ),


                                  ],),

                                Visibility(
                                  visible: !_imdbSearch,
                                  child:    Padding(padding: const EdgeInsets.only( top: 16),
                                    child: inputField("Year",(value) {
                                      return getErrorType(value!, 2);
                                    }, true, TextInputType.text,
                                        "Enter your movie year.", const Icon(Icons.calendar_month,
                                          color: Colors.grey,
                                          size: 14,), _yearController,[LengthLimitingTextInputFormatter(4)]),),)


                              ],),
                          ),)),


                    Padding(padding: const EdgeInsets.only(left: 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          Visibility(
                            visible: !_imdbSearch,
                            child: ToggleSwitch(
                              initialLabelIndex: _selectedTypeIndex,
                              totalSwitches: 4,
                              labels: const ['Any','Movie', 'Series', 'Episode'],
                              onToggle: (index) {
                                _selectedTypeIndex = index ?? 0;
                              },
                            ),
                          ),

                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              text("Plot Length: ",12, TextType.Bold),

                              Switch(
                                // This bool value toggles the switch.
                                value: _plotOption,

                                thumbColor: const MaterialStatePropertyAll<Color>(Colors.black),
                                onChanged: (bool value) {
                                  // This is called when the user toggles the switch.
                                  setState(() {
                                    _plotOption = value;
                                  });
                                },
                              ),
                              text(_plotOption ? "Long" : "Short",16, TextType.Bold),


                            ],),
                        ],),),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        textButtonWithOption("Reset", 14, TextType.Bold, colorPrimary, () { _clearAll();}),
                        raisedButton("Search", () { _requestMovies();})
                      ],)


                  ],),),

              Visibility(
                  visible: _result != null,
                  child: Padding(padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        Visibility(
                            visible: (_result?.title ?? "").isNotEmpty,
                            child: Padding(padding: const EdgeInsets.only(top: 8),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  textWithColor("Title", 10, TextType.Regular, colorAccent),

                                  textWithColor(_result?.title ?? "", 42, TextType.Bold, colorPrimaryDark1),

                                ],),)),

                        Visibility(
                            visible: (_result?.poster ?? "").isNotEmpty,
                            child: Padding(padding: const EdgeInsets.only(top: 8, bottom: 8),
                              child:  Image.network(_result?.poster ?? "",
                                width: double.infinity,
                                fit: BoxFit.cover,
                                height: 400,),)),

                        Visibility(
                          visible: (_result?.title ?? "").isNotEmpty,
                          child:
                          textWithColor("Results Summary:", 24, TextType.Medium, colorPrimaryDark1),),

                        Visibility(
                            visible: (_result?.type ?? "").isNotEmpty,
                            child: Padding(padding: const EdgeInsets.only(top: 8),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  textWithColor("Type", 10, TextType.Regular, colorAccent),

                                  textWithColor((_result?.type ?? "").toUpperCase(), 18, TextType.Regular, colorPrimaryDark1),

                                ],),)),

                        Visibility(
                            visible: (_result?.year ?? "").isNotEmpty,
                            child: Padding(padding: const EdgeInsets.only(top: 8),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  textWithColor("Year", 10, TextType.Regular, colorAccent),

                                  textWithColor(_result?.year ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                ],),)),

                        Visibility(
                            visible: (_result?.rated ?? "").isNotEmpty,
                            child: Padding(padding: const EdgeInsets.only(top: 8),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  textWithColor("Rated", 10, TextType.Regular, colorAccent),

                                  textWithColor(_result?.rated ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                ],),)),

                        Visibility(
                            visible: (_result?.released ?? "").isNotEmpty,
                            child: Padding(padding: const EdgeInsets.only(top: 8),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  textWithColor("Released", 10, TextType.Regular, colorAccent),

                                  textWithColor(_result?.released ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                ],),)),

                        Visibility(
                            visible: (_result?.genre ?? "").isNotEmpty,
                            child: Padding(padding: const EdgeInsets.only(top: 8),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  textWithColor("Genre", 10, TextType.Regular, colorAccent),

                                  textWithColor(_result?.genre ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                ],),)),

                        Visibility(
                            visible: (_result?.director ?? "").isNotEmpty,
                            child: Padding(padding: const EdgeInsets.only(top: 8),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  textWithColor("Director", 10, TextType.Regular, colorAccent),

                                  textWithColor(_result?.director ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                ],),)),

                        Visibility(
                            visible: (_result?.writer ?? "").isNotEmpty,
                            child: Padding(padding: const EdgeInsets.only(top: 8),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  textWithColor("Writer", 10, TextType.Regular, colorAccent),

                                  textWithColor(_result?.writer ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                ],),)),

                        Visibility(
                            visible: (_result?.actors ?? "").isNotEmpty,
                            child: Padding(padding: const EdgeInsets.only(top: 8),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  textWithColor("Actors", 10, TextType.Regular, colorAccent),

                                  textWithColor(_result?.actors ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                ],),)),



                        Visibility(
                            visible: (_result?.language ?? "").isNotEmpty,
                            child: Padding(padding: const EdgeInsets.only(top: 8),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  textWithColor("Language", 10, TextType.Regular, colorAccent),

                                  textWithColor(_result?.language ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                ],),)),

                        Visibility(
                            visible: (_result?.country ?? "").isNotEmpty,
                            child: Padding(padding: const EdgeInsets.only(top: 8),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  textWithColor("Country", 10, TextType.Regular, colorAccent),

                                  textWithColor(_result?.country ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                ],),)),

                        Visibility(
                            visible: (_result?.awards ?? "").isNotEmpty,
                            child: Padding(padding: const EdgeInsets.only(top: 8),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  textWithColor("Awards", 10, TextType.Regular, colorAccent),

                                  textWithColor(_result?.awards ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                ],),)),

                        Visibility(
                            visible: (_result?.dVD ?? "").isNotEmpty,
                            child: Padding(padding: const EdgeInsets.only(top: 8),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  textWithColor("DVD", 10, TextType.Regular, colorAccent),

                                  textWithColor(_result?.dVD ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                ],),)),


                        Visibility(
                            visible: (_result?.boxOffice ?? "").isNotEmpty,
                            child: Padding(padding: const EdgeInsets.only(top: 8),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  textWithColor("Box Office", 10, TextType.Regular, colorAccent),

                                  textWithColor(_result?.boxOffice ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                ],),)),


                        Visibility(
                            visible: (_result?.production ?? "").isNotEmpty,
                            child: Padding(padding: const EdgeInsets.only(top: 8),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  textWithColor("Production", 10, TextType.Regular, colorAccent),

                                  textWithColor(_result?.production ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                ],),)),

                        Visibility(
                            visible: (_result?.website ?? "").isNotEmpty,
                            child: Padding(padding: const EdgeInsets.only(top: 8),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  textWithColor("Website", 10, TextType.Regular, colorAccent),

                                  textWithColor(_result?.website ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                ],),)),

                        Visibility(
                          visible: (_result?.title ?? "").isNotEmpty,
                          child:
                          Padding(padding: const EdgeInsets.only(top: 24),
                            child: textWithColor("Ratings and Assessments:", 24, TextType.Medium, colorPrimaryDark1),),),

                        Visibility(
                            visible: (_result?.metascore ?? "").isNotEmpty,
                            child: Padding(padding: const EdgeInsets.only(top: 8),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  textWithColor("Metascore", 10, TextType.Regular, colorAccent),

                                  textWithColor(_result?.metascore ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                ],),)),

                        Visibility(
                            visible: (_result?.ratings ?? []).isNotEmpty,
                            child: Padding(padding: const EdgeInsets.only(top: 8),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: _setOtherRatings(),),)),

                        Visibility(
                          visible: (_result?.title ?? "").isNotEmpty,
                          child:
                          Padding(padding: const EdgeInsets.only(top: 24),
                            child: textWithColor("Imdb and More:", 24, TextType.Medium, colorPrimaryDark1),),),



                        Visibility(
                            visible: (_result?.imdbID ?? "").isNotEmpty,
                            child: Padding(padding: const EdgeInsets.only(top: 8),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  textWithColor("IMDB ID", 10, TextType.Regular, colorAccent),

                                  textWithColor(_result?.imdbID ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                ],),)),

                        Visibility(
                            visible: (_result?.imdbRating ?? "").isNotEmpty,
                            child: Padding(padding: const EdgeInsets.only(top: 8),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  textWithColor("IMDB Rating", 10, TextType.Regular, colorAccent),

                                  textWithColor(_result?.imdbRating ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                ],),)),

                        Visibility(
                            visible: (_result?.imdbVotes ?? "").isNotEmpty,
                            child: Padding(padding: const EdgeInsets.only(top: 8),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  textWithColor("IMDB Votes", 10, TextType.Regular, colorAccent),

                                  textWithColor(_result?.imdbVotes ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                ],),)),







                        Visibility(
                            visible: (_result?.plot ?? '').isNotEmpty,
                            child: Padding(padding: const EdgeInsets.only(top: 8),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  textWithColor("Plot", 10, TextType.Regular, colorAccent),

                                  textWithColor(_result?.plot ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                ],),)),



                      ],),))
            ],));
        },
      ),
    );
  }

  _tabletView(){
    return Scaffold(
      backgroundColor:  colorWhite,
      body:  LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SafeArea(child: SingleChildScrollView(

            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  color: colorMilkWhite,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      text("Movie",40, TextType.Regular),

                      text("Search",20, TextType.Regular),

                      text("Search for any of your favourite films or series below. Toggle the button to perform an IMDB id search.",10, TextType.Regular),

                      Padding(padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                          child: Form(
                            key: _searchForm,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 16, bottom: 16,),
                              child: Column(mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [

                                  Padding(padding: const EdgeInsets.only( top: 16),
                                    child: inputField("Search",(value) {
                                      return getErrorType(value!, 1);
                                    }, true, TextInputType.text,
                                        "Enter your search parameter.", const Icon(Icons.search,
                                          color: Colors.grey,
                                          size: 14,), _searchController,[LengthLimitingTextInputFormatter(50)]),),

                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      text("IMDB Search?: ",12, TextType.Bold),

                                      Switch(
                                        // This bool value toggles the switch.
                                        value: _imdbSearch,

                                        thumbColor: const MaterialStatePropertyAll<Color>(Colors.black),
                                        onChanged: (bool value) {
                                          // This is called when the user toggles the switch.
                                          setState(() {
                                            _imdbSearch = value;
                                          });
                                        },
                                      ),


                                    ],),

                                  Visibility(
                                    visible: !_imdbSearch,
                                    child:    Padding(padding: const EdgeInsets.only( top: 16),
                                      child: inputField("Year",(value) {
                                        return getErrorType(value!, 2);
                                      }, true, TextInputType.text,
                                          "Enter your movie year.", const Icon(Icons.calendar_month,
                                            color: Colors.grey,
                                            size: 14,), _yearController,[LengthLimitingTextInputFormatter(4)]),),)


                                ],),
                            ),)),


                      Padding(padding: const EdgeInsets.only(left: 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Visibility(
                              visible: !_imdbSearch,
                              child: ToggleSwitch(
                                initialLabelIndex: _selectedTypeIndex,
                                totalSwitches: 4,
                                labels: const ['Any','Movie', 'Series', 'Episode'],
                                onToggle: (index) {
                                  _selectedTypeIndex = index ?? 0;
                                },
                              ),
                            ),

                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                text("Plot Length: ",12, TextType.Bold),

                                Switch(
                                  // This bool value toggles the switch.
                                  value: _plotOption,

                                  thumbColor: const MaterialStatePropertyAll<Color>(Colors.black),
                                  onChanged: (bool value) {
                                    // This is called when the user toggles the switch.
                                    setState(() {
                                      _plotOption = value;
                                    });
                                  },
                                ),
                                text(_plotOption ? "Long" : "Short",16, TextType.Bold),


                              ],),
                          ],),),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          textButtonWithOption("Reset", 14, TextType.Bold, colorPrimary, () { _clearAll();}),
                          raisedButton("Search", () { _requestMovies();})
                        ],)


                    ],),),

                Visibility(
                    visible: _result != null,
                    child: Padding(padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          Visibility(
                              visible: (_result?.title ?? "").isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    textWithColor("Title", 10, TextType.Regular, colorAccent),

                                    textWithColor(_result?.title ?? "", 42, TextType.Bold, colorPrimaryDark1),

                                  ],),)),

                          Visibility(
                              visible: (_result?.poster ?? "").isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8, bottom: 8),
                                child:  Image.network(_result?.poster ?? "",
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  height: 400,),)),

                          Visibility(
                            visible: (_result?.title ?? "").isNotEmpty,
                            child:
                            textWithColor("Results Summary:", 24, TextType.Medium, colorPrimaryDark1),),

                          Visibility(
                              visible: (_result?.type ?? "").isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    textWithColor("Type", 10, TextType.Regular, colorAccent),

                                    textWithColor((_result?.type ?? "").toUpperCase(), 18, TextType.Regular, colorPrimaryDark1),

                                  ],),)),

                          Visibility(
                              visible: (_result?.year ?? "").isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    textWithColor("Year", 10, TextType.Regular, colorAccent),

                                    textWithColor(_result?.year ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                  ],),)),

                          Visibility(
                              visible: (_result?.rated ?? "").isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    textWithColor("Rated", 10, TextType.Regular, colorAccent),

                                    textWithColor(_result?.rated ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                  ],),)),

                          Visibility(
                              visible: (_result?.released ?? "").isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    textWithColor("Released", 10, TextType.Regular, colorAccent),

                                    textWithColor(_result?.released ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                  ],),)),

                          Visibility(
                              visible: (_result?.genre ?? "").isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    textWithColor("Genre", 10, TextType.Regular, colorAccent),

                                    textWithColor(_result?.genre ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                  ],),)),

                          Visibility(
                              visible: (_result?.director ?? "").isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    textWithColor("Director", 10, TextType.Regular, colorAccent),

                                    textWithColor(_result?.director ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                  ],),)),

                          Visibility(
                              visible: (_result?.writer ?? "").isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    textWithColor("Writer", 10, TextType.Regular, colorAccent),

                                    textWithColor(_result?.writer ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                  ],),)),

                          Visibility(
                              visible: (_result?.actors ?? "").isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    textWithColor("Actors", 10, TextType.Regular, colorAccent),

                                    textWithColor(_result?.actors ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                  ],),)),



                          Visibility(
                              visible: (_result?.language ?? "").isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    textWithColor("Language", 10, TextType.Regular, colorAccent),

                                    textWithColor(_result?.language ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                  ],),)),

                          Visibility(
                              visible: (_result?.country ?? "").isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    textWithColor("Country", 10, TextType.Regular, colorAccent),

                                    textWithColor(_result?.country ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                  ],),)),

                          Visibility(
                              visible: (_result?.awards ?? "").isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    textWithColor("Awards", 10, TextType.Regular, colorAccent),

                                    textWithColor(_result?.awards ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                  ],),)),

                          Visibility(
                              visible: (_result?.dVD ?? "").isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    textWithColor("DVD", 10, TextType.Regular, colorAccent),

                                    textWithColor(_result?.dVD ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                  ],),)),


                          Visibility(
                              visible: (_result?.boxOffice ?? "").isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    textWithColor("Box Office", 10, TextType.Regular, colorAccent),

                                    textWithColor(_result?.boxOffice ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                  ],),)),


                          Visibility(
                              visible: (_result?.production ?? "").isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    textWithColor("Production", 10, TextType.Regular, colorAccent),

                                    textWithColor(_result?.production ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                  ],),)),

                          Visibility(
                              visible: (_result?.website ?? "").isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    textWithColor("Website", 10, TextType.Regular, colorAccent),

                                    textWithColor(_result?.website ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                  ],),)),

                          Visibility(
                            visible: (_result?.title ?? "").isNotEmpty,
                            child:
                            Padding(padding: const EdgeInsets.only(top: 24),
                              child: textWithColor("Ratings and Assessments:", 24, TextType.Medium, colorPrimaryDark1),),),

                          Visibility(
                              visible: (_result?.metascore ?? "").isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    textWithColor("Metascore", 10, TextType.Regular, colorAccent),

                                    textWithColor(_result?.metascore ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                  ],),)),

                          Visibility(
                              visible: (_result?.ratings ?? []).isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: _setOtherRatings(),),)),

                          Visibility(
                            visible: (_result?.title ?? "").isNotEmpty,
                            child:
                            Padding(padding: const EdgeInsets.only(top: 24),
                              child: textWithColor("Imdb and More:", 24, TextType.Medium, colorPrimaryDark1),),),



                          Visibility(
                              visible: (_result?.imdbID ?? "").isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    textWithColor("IMDB ID", 10, TextType.Regular, colorAccent),

                                    textWithColor(_result?.imdbID ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                  ],),)),

                          Visibility(
                              visible: (_result?.imdbRating ?? "").isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    textWithColor("IMDB Rating", 10, TextType.Regular, colorAccent),

                                    textWithColor(_result?.imdbRating ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                  ],),)),

                          Visibility(
                              visible: (_result?.imdbVotes ?? "").isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    textWithColor("IMDB Votes", 10, TextType.Regular, colorAccent),

                                    textWithColor(_result?.imdbVotes ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                  ],),)),







                          Visibility(
                              visible: (_result?.plot ?? '').isNotEmpty,
                              child: Padding(padding: const EdgeInsets.only(top: 8),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    textWithColor("Plot", 10, TextType.Regular, colorAccent),

                                    textWithColor(_result?.plot ?? "", 18, TextType.Regular, colorPrimaryDark1),

                                  ],),)),



                        ],),))
              ],),));
        },
      ),
    );
  }

  void _closeApp() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  void _requestMovies() {

    if(_searchForm.currentState!.validate()) {

      SearchParams param = SearchParams();

      param.plot = _plotOption;

      if(_imdbSearch){

        param.title =  "";

        param.id = _searchController.text;

      }else {


        param.title = _searchController.text;



        if (_yearController.text.isNotEmpty) {
          param.year = int.parse(_yearController.text);
        }

        switch (_selectedTypeIndex) {
          case 1:
            param.type = 'movie';
            break;
          case 2:
            param.type = 'series';
            break;
          case 3:
            param.type = 'episode';
            break;
          default:
            param.type = "";
            break;
        }
      }

      _model?.searchMovie(param);

    }

  }

  //display the results from the api call.

  @override
  setMovie(MovieSearchResponse movieSearchResponse) {
    _result = movieSearchResponse;
    _model?.notifyListeners();
  }

  String? getErrorType(String value, int option) {
    if(option == 1){
      if(value.isEmpty){
        return "This field is required.";
      }
    }else if(option == 2){
      if(value.isNotEmpty) {
        if (!isNumerical(value)) {
          return "Kindly ensure to only put valid year values.";
        } else if (int.parse(value) > DateTime
            .now()
            .year) {
          return "Kindly ensure to enter a year less than: ${DateTime
              .now()
              .year}.";
        }else if (int.parse(value) < 1960) {
          return "Kindly ensure to enter a year greater than: 1960.";
        }
      }
    }

    return null;
  }

  @override
  void dispose() {

    _searchController.dispose();

    _yearController.dispose();

    super.dispose();

  }

  void _clearAll() {
    _yearController.clear();
    _searchController.clear();
    _selectedTypeIndex = 0;
    _plotOption = false;
    _result = null;
    _imdbSearch = false;
    _model?.notifyListeners();
  }

  _setOtherRatings() {

    return (_result?.ratings ?? []).map((e) => Padding(padding: const EdgeInsets.only(bottom: 8),
    child: Column(mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [

        textWithColor(e.source, 10, TextType.Regular, colorAccent),

        textWithColor(e.value, 18, TextType.Regular, colorPrimaryDark1),
      ],),)).toList();
  }

}