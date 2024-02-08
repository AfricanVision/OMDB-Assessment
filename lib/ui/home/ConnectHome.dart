import 'package:omdbassestment/about/external/data/MovieSearchResponse.dart';

//connects the model to the view.
//sends the results from the api call in the OMDB api query to the view.
abstract class ConnectHome{
  setMovie(MovieSearchResponse movieSearchResponse) {}
}