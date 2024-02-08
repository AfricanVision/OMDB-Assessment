import 'dart:typed_data';
import 'package:dio/src/response.dart';

import 'package:omdbassestment/about/external/data/SearchParams.dart';

import '../about/internal/memory/ConnectInternalMemory.dart';
import '../comms/ConnectComms.dart';
import 'DataManager.dart';

//main calls that handles and links together all data related operations, network call, memory call, in application database queries and more.
class AppDataManager implements DataManager {

  ConnectInternalMemory connectInternalMemory;

  ConnectComms connectComms;


  AppDataManager(this.connectInternalMemory, this.connectComms);


  //function to call OMDB api.
  @override
  Future<Response> searchForMovie(SearchParams request) async{
    return await connectComms.searchForMovie(request);
  }

}

