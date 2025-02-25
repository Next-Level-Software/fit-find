// ignore_for_file: non_constant_identifier_names

import 'package:flutter_dotenv/flutter_dotenv.dart';

String BASE_URL = dotenv.env["DB_URL"] ?? "";

String URL_TYPE = dotenv.env["URL_TYPE"] ?? "";

String FILE_BASE_URL = dotenv.env["BASE_FILE_URL"] ?? "";

String GOOGLE_API_KEY = dotenv.env["GOOGLE_API_KEY"] ?? "";

String ONE_SIGNAL_APP_ID = dotenv.env["ONE_SIGNAL_APP_ID"] ?? "";
