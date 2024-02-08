import 'package:dio/dio.dart';
import '../about/external/data/SearchParams.dart';

abstract class ConnectComms{

  //Links the network call to the comms class that handles network request calls.
  Future<Response> searchForMovie(SearchParams request);

}