
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_flutter_structure/business_logic/login_cubit/login_cubit.dart';
import 'package:magdsoft_flutter_structure/business_logic/login_cubit/login_states.dart';
import 'package:magdsoft_flutter_structure/data/network/requests/login_request.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/user/register_screen.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/user/user_data_screen.dart';
import 'package:magdsoft_flutter_structure/presentation/styles/colors.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/defaut_text_field.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/toast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../../view/loading_view.dart';
import '../../widget/defaut_button.dart';
import '../../widget/toggle_lang_btn.dart';

class LoginScreen extends StatelessWidget {
  static const String id = "LoginScreen";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return BlocProvider(
      create: (context) {
        return LoginCubit();
      },
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is ErrorLoginState) {
            showToast(text: AppLocalizations.of(context)!.errorSignIn);
          }

          if (state is SuccessLoginState) {
            showToast(text: "مبروك تم انشاء الحساب بنجاح يمكنك تسجيل الدخول الأن");
          }

        },
        builder: (context, state) {
          final loginCubit = LoginCubit.get(context);

          return Scaffold(
            backgroundColor: AppColor.blue,
            body: SafeArea(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const ToggleLangBtn(),
                    Expanded(
                        flex: 2,
                        child: Image.asset("assets/images/logo_flutter.png")),
                    Expanded(
                      flex: 7,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50.0, vertical: 16.0),
                        decoration: const BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25),
                              topLeft: Radius.circular(25),
                            )),
                        child: Center(
                          child: SingleChildScrollView(
                            child: state is LoadingLoginState ? const LoadingView()
                                : Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      defaultTextFiled(
                                          controller: emailController,
                                          inputType: TextInputType.emailAddress,
                                          hint: AppLocalizations.of(context)!.email,
                                          context: context,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return AppLocalizations.of(context)!.required;
                                            }

                                            return null;
                                          }),
                                      const SizedBox(
                                        height: 16.0,
                                      ),
                                      defaultTextFiled(
                                          controller: passwordController,
                                          hint: AppLocalizations.of(context)!.password,
                                          inputType: TextInputType.text,
                                          obSecure: loginCubit.isPassword,
                                          context: context,
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                loginCubit.toggleIsPassword();
                                              },
                                              icon: loginCubit.isPassword
                                                  ? const Icon(
                                                      Icons.visibility_outlined)
                                                  : const Icon(Icons
                                                      .visibility_off_outlined)),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return AppLocalizations.of(context)!.required;
                                            }

                                            return null;
                                          }),
                                      const SizedBox(
                                        height: 35.0,
                                      ),


                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: DefaultButton(
                                              text: AppLocalizations.of(context)!.login,
                                              backgroundColor: AppColor.blue,
                                              onPressedCallback: () async {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  final result = await loginCubit.login(
                                                      loginRequest: LoginRequest(
                                                          email: emailController
                                                              .text
                                                              .trim(),
                                                          password:
                                                              passwordController
                                                                  .text));

                                                  if (result) {
                                                    // navigate to next screen

                                                    Navigator.pushNamedAndRemoveUntil(context, UserDataScreen.id, (route) => false);
                                                  }
                                                }
                                              },
                                            ),
                                          ),
                                          const Spacer(flex: 1),
                                          Expanded(
                                              flex: 4,
                                              child: DefaultButton(
                                                  text: AppLocalizations.of(context)!.register,
                                                  onPressedCallback: () {
                                                    Navigator.pushNamed(context, RegisterScreen.id);

                                                  },
                                                  backgroundColor:
                                                      AppColor.blue)),
                                        ],
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
