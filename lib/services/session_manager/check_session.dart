
import 'package:flutter/cupertino.dart';
import 'package:youbloomdemo/config/routes/routes_name.dart';
import 'package:youbloomdemo/services/session_manager/session_controller.dart';

class CheckSession{

  void checkExistingSession(BuildContext context)async{
    SessionController().getUserFromPreference().then((value)async{
      if (SessionController.isLogin ?? false) {

      } else {

      }
    }).onError((error, stackTree){

    });

}


}