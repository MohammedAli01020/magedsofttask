
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_flutter_structure/business_logic/login_cubit/login_states.dart';
import 'package:magdsoft_flutter_structure/data/network/responses/login_response.dart';

import '../../constants/end_points.dart';
import '../../data/local/cache_helper.dart';
import '../../data/local/local_data.dart';
import '../../data/models/account_model.dart';
import '../../data/network/requests/login_request.dart';
import '../../data/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {

  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);


  Future<bool> login({required LoginRequest loginRequest}) async {


    emit(LoadingLoginState());
    try {

      final result = await DioHelper.postData(url: loginURl, body: {
        "email" : loginRequest.email,
        "password" : loginRequest.password,

      });


      print(result.data['status'].toString() + " code is ");
      if (result.statusCode == 200 && result.data['status'] == 200) {

        LoginResponse response = LoginResponse.fromJson(result.data);

        currentAccount = Account.fromJson(response.account[0].toJson());
        CacheHelper.saveDataSharedPreference(key: 'currentAccount', value: jsonEncode(currentAccount));

        emit(SuccessLoginState());

        return true;

      } else {

        emit(ErrorLoginState());
        return false;
      }


    } catch (e) {

      print(e);

      emit(ErrorLoginState());
      return false;

    }




  }



  bool isPassword = true;


  void toggleIsPassword() {
    isPassword = !isPassword;
    emit(TogglePasswordState());
  }


}