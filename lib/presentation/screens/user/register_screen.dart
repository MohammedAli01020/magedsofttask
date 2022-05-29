import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_flutter_structure/business_logic/register_cubit/register_cubit.dart';
import 'package:magdsoft_flutter_structure/business_logic/register_cubit/register_states.dart';
import 'package:magdsoft_flutter_structure/presentation/styles/colors.dart';
import 'package:magdsoft_flutter_structure/presentation/view/loading_view.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/defaut_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/network/requests/register_request.dart';
import '../../widget/defaut_button.dart';
import '../../widget/toast.dart';
import '../../widget/toggle_lang_btn.dart';

class RegisterScreen extends StatelessWidget {
  static const String id = "RegisterScreen";

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    return BlocProvider(
      create: (context) {
        return RegisterCubit();
      },
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is ErrorRegisterState) {
            showToast(text: AppLocalizations.of(context)!.errorSignIn);
          }


          if (state is SuccessRegisterState) {
            showToast(text: AppLocalizations.of(context)!.creatingAccountOk);
          }
        },
        builder: (context, state) {
          final registerCubit = RegisterCubit.get(context);

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
                        child: state is LoadingRegisterState
                            ? const Center(child: LoadingView())
                            : SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    defaultTextFiled(
                                        controller: nameController,
                                        inputType: TextInputType.text,
                                        hint: AppLocalizations.of(context)!.fullName,
                                        context: context,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return AppLocalizations.of(context)!
                                                .required;
                                          }

                                          return null;
                                        }),
                                    const SizedBox(
                                      height: 16.0,
                                    ),
                                    defaultTextFiled(
                                        controller: emailController,
                                        inputType: TextInputType.emailAddress,
                                        hint:
                                            AppLocalizations.of(context)!.email,
                                        context: context,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return AppLocalizations.of(context)!
                                                .required;
                                          }

                                          return null;
                                        }),
                                    const SizedBox(
                                      height: 16.0,
                                    ),
                                    defaultTextFiled(
                                        controller: phoneController,
                                        inputType: TextInputType.text,
                                        hint:
                                            AppLocalizations.of(context)!.phoneNo,
                                        context: context,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return AppLocalizations.of(context)!
                                                .required;
                                          }

                                          return null;
                                        }),
                                    const SizedBox(
                                      height: 16.0,
                                    ),
                                    defaultTextFiled(
                                        controller: passwordController,
                                        hint: AppLocalizations.of(context)!
                                            .password,
                                        inputType: TextInputType.text,
                                        obSecure: registerCubit.isPassword,
                                        context: context,
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              registerCubit.toggleIsPassword();
                                            },
                                            icon: registerCubit.isPassword
                                                ? const Icon(
                                                    Icons.visibility_outlined)
                                                : const Icon(Icons
                                                    .visibility_off_outlined)),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return AppLocalizations.of(context)!
                                                .required;
                                          }

                                          return null;
                                        }),
                                    const SizedBox(
                                      height: 16.0,
                                    ),
                                    defaultTextFiled(
                                        controller: confirmPasswordController,
                                        hint: AppLocalizations.of(context)!.confirmPassword,
                                        inputType: TextInputType.text,
                                        obSecure: registerCubit.isPassword,
                                        context: context,
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              registerCubit.toggleIsPassword();
                                            },
                                            icon: registerCubit.isPassword
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
                                    DefaultButton(
                                      text: AppLocalizations.of(context)!.register,
                                      backgroundColor: AppColor.blue,
                                      onPressedCallback: () async {
                                        if (formKey.currentState!.validate()) {

                                          final result = await registerCubit.register(
                                              registerRequest: RegisterRequest(
                                                  name: nameController.text,
                                                  email: emailController.text,
                                                  password: passwordController.text,
                                                  phone: phoneController.text));



                                          if (result) {
                                            Navigator.pop(context);
                                          }


                                        }
                                      },
                                    ),
                                  ],
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
