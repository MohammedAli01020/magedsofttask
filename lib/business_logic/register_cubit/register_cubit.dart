
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_flutter_structure/business_logic/login_cubit/login_states.dart';
import 'package:magdsoft_flutter_structure/business_logic/register_cubit/register_states.dart';
import 'package:magdsoft_flutter_structure/constants/end_points.dart';
import 'package:magdsoft_flutter_structure/data/network/requests/register_request.dart';
import 'package:magdsoft_flutter_structure/data/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {


  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);




  Future<bool> register({required RegisterRequest registerRequest}) async {


    emit(LoadingRegisterState());


    try {

      final result = await DioHelper.postData(url: registerURl, body: {

        "name" : registerRequest.name,
        "email" : registerRequest.email,
        "password" : registerRequest.password,
        "phone" : registerRequest.phone
      });


      if (result.statusCode == 200 && result.data['status'] == 200) {
        emit(SuccessRegisterState());

        return true;
      } else {
        emit(ErrorRegisterState());

        return false;
      }


    } catch (e) {

      print(e);

      emit(ErrorRegisterState());
      return false;

    }




  }



  bool isPassword = true;


  void toggleIsPassword() {
    isPassword = !isPassword;
    emit(TogglePasswordRegisterState());
  }

}