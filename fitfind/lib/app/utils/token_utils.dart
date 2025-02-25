// import 'package:growth/app/data/local/my_shared_pref.dart';
// import 'package:growth/app/model/user_model.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';

// class TokenUtil {
//   static Map<String, dynamic>? decodeToken(String? token) {
//     if (token == null) return null;
//     Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
//     return decodedToken;
//   }

//   static bool isTokenExpired(token) {
//     // DateTime expiryDate = JwtDecoder.getExpirationDate(token);
//     // print(expiryDate);
//     bool hasExpired = JwtDecoder.isExpired(token);
//     return hasExpired;
//   }

//   static UserModel? getUserDataFromToken() {
//     var token = MySharedPref.getToken();

//     if (token == null) return null;

//     var decodedData = decodeToken(token);
//     // var uniqueValue = decodedData['uniqueValue']
//     if (decodedData != null) {
//       // Logger().w(decodedData);
//       UserModel user = userModelFromJson(decodedData);
//       return user;
//     }
//     return null;
//   }

//   // static String? getUserIdFromToken() {
//   //   var token = MySharedPref.getToken();

//   //   if (token == null) return null;

//   //   var decodedData =
//   //       decodeToken(token); // Check the output to see the structure
//   //   // var uniqueValue = decodedData['uniqueValue'];
//   //   if (decodedData != null && decodedData['id'] != null) {
//   //     String userId = decodedData['id'];
//   //     return userId;
//   //   }

//   //   return null;
//   // }
//   static bool getUserIsCoach() {
//     var value = getUserDataFromToken()?.type =='coach' ? true : false;

//     if (value == null) return false;

//     if (value) {
//       return value;
//     }

//     return false;
//   }
// }
