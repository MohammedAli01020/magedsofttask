
import 'package:flutter/material.dart';

import '../../data/local/cache_helper.dart';
import '../../data/local/local_data.dart';
import '../../main.dart';
import '../styles/colors.dart';

class ToggleLangBtn extends StatefulWidget {
  const ToggleLangBtn({Key? key}) : super(key: key);

  @override
  State<ToggleLangBtn> createState() => _ToggleLangBtnState();
}

class _ToggleLangBtnState extends State<ToggleLangBtn> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, right: 16.0),
        child: ElevatedButton(
          child:  Text(
            lang == "ar" ? "english" : "عربي",
            style: const TextStyle(color: AppColor.blue),
          ),
          onPressed: () {
            if (lang == "ar") {
              lang = "en";
              CacheHelper.saveDataSharedPreference(key: 'lang', value: "en");
              MyHomePageApp.setLocale(context, const Locale.fromSubtags(languageCode: 'en'));
            } else {
              lang = "ar";
              CacheHelper.saveDataSharedPreference(key: 'lang', value: "ar");
              MyHomePageApp.setLocale(context, const Locale.fromSubtags(languageCode: 'ar'));
            }


            setState(() {

            });

          },
          style: ButtonStyle(
            backgroundColor:
            MaterialStateProperty.all(AppColor.white),
          ),
        ),
      ),
    );
  }
}
