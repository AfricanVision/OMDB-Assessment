import 'package:flutter/cupertino.dart';
import 'package:omdbassestment/about/external/data/MovieSearchResponse.dart';
import 'package:omdbassestment/about/external/data/SearchParams.dart';
import '../base/ParentViewModel.dart';
import 'ConnectHome.dart';

class ViewHome extends ParentViewModel {

  ConnectHome connection;

  ViewHome(BuildContext context, this.connection) : super(context);

  //Function to query information from the OMDB api.

  void searchMovie(SearchParams request) {
    hasNetwork(() => { closeNetwork(), searchMovie(request)}).then((value) => {
      if(value){
        showLoading("Searching...."),
        getDataManager().searchForMovie(request).then((response) => {
          closeLoading(),
          connection.setMovie(MovieSearchResponse.fromJson(response.data))
        }).onError((error, stackTrace) => {
          handleError(error, () => {dismissError(), searchMovie(request)}, () => {dismissError()}, "Retry")
        })
      }
    });
  }


}