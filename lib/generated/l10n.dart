// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Select Language`
  String get selectLanguage {
    return Intl.message(
      'Select Language',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arabic {
    return Intl.message('Arabic', name: 'arabic', desc: '', args: []);
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Skip`
  String get skip {
    return Intl.message('Skip', name: 'skip', desc: '', args: []);
  }

  /// `Back`
  String get back {
    return Intl.message('Back', name: 'back', desc: '', args: []);
  }

  /// `Connect with support`
  String get onboarding_title1 {
    return Intl.message(
      'Connect with support',
      name: 'onboarding_title1',
      desc: '',
      args: [],
    );
  }

  /// `Chat with doctors, psychiatrists, pharmacists, and volunteers anytime`
  String get onboarding_description1 {
    return Intl.message(
      'Chat with doctors, psychiatrists, pharmacists, and volunteers anytime',
      name: 'onboarding_description1',
      desc: '',
      args: [],
    );
  }

  /// `Join the community`
  String get onboarding_title2 {
    return Intl.message(
      'Join the community',
      name: 'onboarding_title2',
      desc: '',
      args: [],
    );
  }

  /// `Connect with patients and doctors and share your experiences, and get support just like on social media`
  String get onboarding_description2 {
    return Intl.message(
      'Connect with patients and doctors and share your experiences, and get support just like on social media',
      name: 'onboarding_description2',
      desc: '',
      args: [],
    );
  }

  /// `Keep your records Handy`
  String get onboarding_title3 {
    return Intl.message(
      'Keep your records Handy',
      name: 'onboarding_title3',
      desc: '',
      args: [],
    );
  }

  /// `Easily upload lab results, prescriptions scans and medical documents in one place`
  String get onboarding_description3 {
    return Intl.message(
      'Easily upload lab results, prescriptions scans and medical documents in one place',
      name: 'onboarding_description3',
      desc: '',
      args: [],
    );
  }

  /// `Never miss a remainder`
  String get onboarding_title4 {
    return Intl.message(
      'Never miss a remainder',
      name: 'onboarding_title4',
      desc: '',
      args: [],
    );
  }

  /// `Get notified about your medication and doctor appointments`
  String get onboarding_description4 {
    return Intl.message(
      'Get notified about your medication and doctor appointments',
      name: 'onboarding_description4',
      desc: '',
      args: [],
    );
  }

  /// `Select who are you`
  String get selectWhoAreYou {
    return Intl.message(
      'Select who are you',
      name: 'selectWhoAreYou',
      desc: '',
      args: [],
    );
  }

  /// `Doctor`
  String get doctor {
    return Intl.message('Doctor', name: 'doctor', desc: '', args: []);
  }

  /// `Pharmacist`
  String get pharmacist {
    return Intl.message('Pharmacist', name: 'pharmacist', desc: '', args: []);
  }

  /// `Volunteer`
  String get volunteer {
    return Intl.message('Volunteer', name: 'volunteer', desc: '', args: []);
  }

  /// `Psychiatrist`
  String get psychiatrist {
    return Intl.message(
      'Psychiatrist',
      name: 'psychiatrist',
      desc: '',
      args: [],
    );
  }

  /// `Patient`
  String get patient {
    return Intl.message('Patient', name: 'patient', desc: '', args: []);
  }

  /// `CancApp`
  String get cancApp {
    return Intl.message('CancApp', name: 'cancApp', desc: '', args: []);
  }

  /// `Welcome back`
  String get welcomeBack {
    return Intl.message(
      'Welcome back',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPasswordIntr {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPasswordIntr',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email address and we will send you a code to reset your password`
  String get resetPasswordInstructions {
    return Intl.message(
      'Enter your email address and we will send you a code to reset your password',
      name: 'resetPasswordInstructions',
      desc: '',
      args: [],
    );
  }

  /// `Send Code`
  String get sendCode {
    return Intl.message('Send Code', name: 'sendCode', desc: '', args: []);
  }

  /// `Verification Code`
  String get verificationCode {
    return Intl.message(
      'Verification Code',
      name: 'verificationCode',
      desc: '',
      args: [],
    );
  }

  /// `Enter the verification code we just sent to your email address`
  String get enterVerificationCode {
    return Intl.message(
      'Enter the verification code we just sent to your email address',
      name: 'enterVerificationCode',
      desc: '',
      args: [],
    );
  }

  /// `Send again`
  String get sendAgain {
    return Intl.message('Send again', name: 'sendAgain', desc: '', args: []);
  }

  /// `I didn't receive the code,`
  String get didNotReceiveCode {
    return Intl.message(
      'I didn\'t receive the code,',
      name: 'didNotReceiveCode',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message('Verify', name: 'verify', desc: '', args: []);
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message('Sign Up', name: 'signUp', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get notHaveAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'notHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Create your Account`
  String get createYourAccount {
    return Intl.message(
      'Create your Account',
      name: 'createYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message('Full Name', name: 'fullName', desc: '', args: []);
  }

  /// `Address`
  String get address {
    return Intl.message('Address', name: 'address', desc: '', args: []);
  }

  /// `Confirm password is required`
  String get confirmPasswordIsRequired {
    return Intl.message(
      'Confirm password is required',
      name: 'confirmPasswordIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordsDonotMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordsDonotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Password is required`
  String get passwordIsRequired {
    return Intl.message(
      'Password is required',
      name: 'passwordIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a strong password`
  String get pleaseEnteraStrongPassword {
    return Intl.message(
      'Please enter a strong password',
      name: 'pleaseEnteraStrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `At least 1 lowercase letter`
  String get lowercaseValidation {
    return Intl.message(
      'At least 1 lowercase letter',
      name: 'lowercaseValidation',
      desc: '',
      args: [],
    );
  }

  /// `At least 1 uppercase letter`
  String get uppercaseValidation {
    return Intl.message(
      'At least 1 uppercase letter',
      name: 'uppercaseValidation',
      desc: '',
      args: [],
    );
  }

  /// `At least 1 special character`
  String get specialCharacterValidation {
    return Intl.message(
      'At least 1 special character',
      name: 'specialCharacterValidation',
      desc: '',
      args: [],
    );
  }

  /// `At least 1 number`
  String get numberValidation {
    return Intl.message(
      'At least 1 number',
      name: 'numberValidation',
      desc: '',
      args: [],
    );
  }

  /// `At least 8 characters long`
  String get minLengthValidation {
    return Intl.message(
      'At least 8 characters long',
      name: 'minLengthValidation',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Chats`
  String get chats {
    return Intl.message('Chats', name: 'chats', desc: '', args: []);
  }

  /// `Community`
  String get community {
    return Intl.message('Community', name: 'community', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Hello, Welcome`
  String get helloWelcome {
    return Intl.message(
      'Hello, Welcome',
      name: 'helloWelcome',
      desc: '',
      args: [],
    );
  }

  /// `Available to chat`
  String get chatCategories {
    return Intl.message(
      'Available to chat',
      name: 'chatCategories',
      desc: '',
      args: [],
    );
  }

  /// `Doctors`
  String get doctors {
    return Intl.message('Doctors', name: 'doctors', desc: '', args: []);
  }

  /// `Pharmacists`
  String get pharmacists {
    return Intl.message('Pharmacists', name: 'pharmacists', desc: '', args: []);
  }

  /// `Psychiatrists`
  String get psychiatrists {
    return Intl.message(
      'Psychiatrists',
      name: 'psychiatrists',
      desc: '',
      args: [],
    );
  }

  /// `Volunteers`
  String get volunteers {
    return Intl.message('Volunteers', name: 'volunteers', desc: '', args: []);
  }

  /// `Patients`
  String get patients {
    return Intl.message('Patients', name: 'patients', desc: '', args: []);
  }

  /// `See All`
  String get seeAll {
    return Intl.message('See All', name: 'seeAll', desc: '', args: []);
  }

  /// `Nearest Pharmacy`
  String get nearestPharmacy {
    return Intl.message(
      'Nearest Pharmacy',
      name: 'nearestPharmacy',
      desc: '',
      args: [],
    );
  }

  /// `Quick actions`
  String get quickActions {
    return Intl.message(
      'Quick actions',
      name: 'quickActions',
      desc: '',
      args: [],
    );
  }

  /// `Reminder`
  String get reminder {
    return Intl.message('Reminder', name: 'reminder', desc: '', args: []);
  }

  /// `Record`
  String get record {
    return Intl.message('Record', name: 'record', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
