import 'package:flutter/material.dart';
import 'package:magdsoft_flutter_structure/data/local/local_data.dart';
import 'package:magdsoft_flutter_structure/presentation/styles/colors.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/defaut_button.dart';

import '../../../data/local/cache_helper.dart';
import '../../styles/style.dart';
import 'login_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserDataScreen extends StatelessWidget {
  static const String id = "UserDataScreen";

  const UserDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 16.0, left: 16.0, bottom: 25.0, top: 16.0),
          child: Column(


            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: AppColor.blue
                ),
                child: Center(child: Text(AppLocalizations.of(context)!.userData, style: TextStyle(color: AppColor.white, fontSize: 20.0),)),

              ),


              const Spacer(flex: 1,),


              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(AppLocalizations.of(context)!.name+ currentAccount!.name.toString(),
                      style: userDataStyle,),
                    const SizedBox(height: 16.0),
                    Text(AppLocalizations.of(context)!.emailData + currentAccount!.email.toString(), style: userDataStyle,),
                    const SizedBox(height: 16.0),
                    Text(AppLocalizations.of(context)!.phone + currentAccount!.phone.toString(), style: userDataStyle),
                  ],
                ),
              ),

              const Spacer(flex: 1,),



              DefaultButton(

                backgroundColor: AppColor.red,
              textColor: AppColor.white,
              onPressedCallback: () {
                CacheHelper.removeData(key: "currentAccount").then((value) {
                  if (value) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, LoginScreen.id, (route) => false);
                  }
                });
              },

                  text: AppLocalizations.of(context)!.logout),


            ],


          ),
        ),
      ),
    );
  }
}
