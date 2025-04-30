import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gaming_startup_ai_agent/features/auth/data/models/user_auth_information.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'storage_keys.dart';

late SharedPreferences prefs;

class Storage {
  Storage();

  /*
  //save and fetch user info
  void saveUserInfo(UserCredential user) =>
      prefs.setString(kUserKey, json.encode(user.toJson()));

  UserCredential? fetchUserInfo() => prefs.containsKey(kUserKey)
      ? UserCredential.fromStorage(json.decode(prefs.getString(kUserKey)!))
      : null;

  //save and fetch wallet balance
  void saveWalletBalance(AddressBalanceResModel balance) =>
      prefs.setString(kWalletBalanceKey, json.encode(balance.toJson()));

  AddressBalanceResModel? fetchWalletBalance() =>
      prefs.containsKey(kWalletBalanceKey)
          ? AddressBalanceResModel.fromJson(
              json.decode(prefs.getString(kWalletBalanceKey)!),
            )
          : null;

  //save and fetch selected token for dashboard
  void saveSelectedToken(Token token) =>
      prefs.setString(kSelectedTokenKey, json.encode(token.toJson()));

  Token? fetchSelectedToken() => prefs.containsKey(kSelectedTokenKey)
      ? Token.fromJson(json.decode(prefs.getString(kSelectedTokenKey)!))
      : null;

  //save and fetch userDefaultCurrency
  void saveUserDefaultCurrency(FiatCurrency currency) =>
      prefs.setString(kUserDefaultCurrencyKey, json.encode(currency.toJson()));

  FiatCurrency? fetchUserDefaultCurrency() =>
      prefs.containsKey(kUserDefaultCurrencyKey)
          ? FiatCurrency.fromJson(
              json.decode(prefs.getString(kUserDefaultCurrencyKey)!),
            )
          : null;*/
  //save and fetch user info
  void saveUserInfo(UserAuthInformation user) =>
      prefs.setString(kUserKey, json.encode(user.toJson()));

  UserAuthInformation? fetchUserInfo() =>
      prefs.containsKey(kUserKey)
          ? UserAuthInformation.fromMap(json.decode(prefs.getString(kUserKey)!))
          : null;

  //save and fetch themeMode
  void saveThemeMode(ThemeMode theme) => prefs.setInt(
    kThemeModeKey,
    theme == ThemeMode.light
        ? 0
        : theme == ThemeMode.dark
        ? 1
        : 2,
  );

  ThemeMode fetchThemeMode() =>
      prefs.containsKey(kThemeModeKey)
          ? (prefs.getInt(kThemeModeKey)! == 0
              ? ThemeMode.light
              : prefs.getInt(kThemeModeKey) == 1
              ? ThemeMode.dark
              : ThemeMode.system)
          : ThemeMode.system;

  //save and fetch hide balance option
  void saveHideBalance(bool value) => prefs.setBool(kHideBalanceKey, value);

  bool fetchHideBalance() =>
      prefs.containsKey(kHideBalanceKey)
          ? prefs.getBool(kHideBalanceKey)!
          : false;

  //save and fetch biometric authentication
  void saveBiometricAuth(bool value) => prefs.setBool(kBiometricKey, value);

  bool fetchBiometricAuth() =>
      prefs.containsKey(kBiometricKey) ? prefs.getBool(kBiometricKey)! : false;

  bool biometricAuthExists() => prefs.containsKey(kBiometricKey);

  //save and fetch selected avatar
  void saveSelectedAvatar(int value) => prefs.setInt(kSelectedAvatarKey, value);

  int fetchSelectedAvatar() =>
      prefs.containsKey(kSelectedAvatarKey)
          ? prefs.getInt(kSelectedAvatarKey)!
          : 0;

  //save and fetch onboarding info

  void saveOnBoardingInfo() => prefs.setBool(kOnBoardingKey, true);

  bool fetchOnBoardingInfo() => prefs.containsKey(kOnBoardingKey);

  void removeUser() => prefs.remove(kUserKey);

  void removeAll() => prefs.clear();
}
