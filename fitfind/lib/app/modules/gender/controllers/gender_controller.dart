import 'package:fitfind/app/constants/app_constants.dart';
import 'package:get/get.dart';

class GenderController extends GetxController {
bool?isCheck=false;
int? setIndex;
List genderList=[
  {
    "gender":'children',
    'isChecK':false,
    "image":ImagePaths.CHILD
  },
  {
    "gender":'female',
    'isChecK':false,
    "image":ImagePaths.FEMALE
  },
  {
    "gender":'male',
    'isChecK':false,
    "image":ImagePaths.MALE
  }
];
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}
