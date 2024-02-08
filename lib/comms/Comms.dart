
import 'package:dio/dio.dart';
import 'package:omdbassestment/about/external/data/SearchParams.dart';
import '../about/internal/application/Pair.dart';
import '../about/internal/memory/ConnectInternalMemory.dart';
import '../configs/Env.dart';
import 'CommsDirections.dart';
import 'ConnectComms.dart';

//main class that handles the actual newtork calls.
class Comms implements ConnectComms {

  //Library incharge of performing all application network calls.
  Dio dio = Dio();

  //call interface.
  ConnectInternalMemory helper;

  Comms(this.helper);

  @override
  Future<Response> searchForMovie(SearchParams request) async {
    Pair navigation = await getRequestHeaders(requestMovieFromSearch, request);
    dio.options.headers = navigation.value;
    return await dio.get(navigation.key, options: Options(
        headers: dio.options.headers
    ));
  }

  //Request header function that appends all the related information required to perform an api call.

  Future<Pair> getRequestHeaders(String url, SearchParams urlData) async{

    dio.options.headers = <String, dynamic>{};

    dio.options.contentType = Headers.jsonContentType;

    dio.options.responseType = ResponseType.json;

    dio.options.headers["version"] = localisedAppVersion;

    if((urlData.id ?? "").isNotEmpty){

      url = "$url&i=${urlData.id}";

      if(urlData.plot){
        url = "$url&plot=full";
      }

    }else{

      url= "$url&t=${urlData.title}";

      if(urlData.plot){
        url = "$url&plot=full";
      }

      if(urlData.type.isNotEmpty){
        url = "$url&type=${urlData.type}";
      }

      if(urlData.year.toString().length == 4){
        url = "$url&y=${urlData.year}";
      }

    }


    return Future.value(Pair(url, dio.options.headers));

  }



}