

import 'package:flutter/material.dart';

@immutable
abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}



class LoadingRegisterState extends RegisterStates {}

class SuccessRegisterState extends RegisterStates {}

class ErrorRegisterState extends RegisterStates {}

class ExistsRegisterState extends RegisterStates {}


class TogglePasswordRegisterState extends RegisterStates {}