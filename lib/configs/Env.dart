import 'package:flutter_dotenv/flutter_dotenv.dart';


String uriPath = dotenv.get('OMDB_URI_PATH', fallback: '');

String apiKey = dotenv.get('API_KEY', fallback: '');

String localisedAppVersion = dotenv.get('LOCALISED_APP_VERSION', fallback: '');
