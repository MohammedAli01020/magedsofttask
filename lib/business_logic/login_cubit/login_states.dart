

import 'package:flutter/material.dart';

@immutable
abstract class LoginStates {}

class LoginInitialState extends LoginStates {}


class LoadingLoginState extends LoginStates {}

class SuccessLoginState extends LoginStates {}

class ErrorLoginState extends LoginStates {}

class ExistsLoginState extends LoginStates {}

class TogglePasswordState extends LoginStates {}