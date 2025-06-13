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

  /// `Pharmacy`
  String get pharmacy {
    return Intl.message('Pharmacy', name: 'pharmacy', desc: '', args: []);
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

  /// `Chat`
  String get chat {
    return Intl.message('Chat', name: 'chat', desc: '', args: []);
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

  /// `Access requests`
  String get accessRequests {
    return Intl.message(
      'Access requests',
      name: 'accessRequests',
      desc: '',
      args: [],
    );
  }

  /// `Access request allowed successfully`
  String get accessRequestAllowed {
    return Intl.message(
      'Access request allowed successfully',
      name: 'accessRequestAllowed',
      desc: '',
      args: [],
    );
  }

  /// `Access request denied`
  String get accessRequestDenied {
    return Intl.message(
      'Access request denied',
      name: 'accessRequestDenied',
      desc: '',
      args: [],
    );
  }

  /// `Allow`
  String get allow {
    return Intl.message('Allow', name: 'allow', desc: '', args: []);
  }

  /// `Deny`
  String get deny {
    return Intl.message('Deny', name: 'deny', desc: '', args: []);
  }

  /// `No pending requests`
  String get noPendingRequests {
    return Intl.message(
      'No pending requests',
      name: 'noPendingRequests',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Message`
  String get message {
    return Intl.message('Message', name: 'message', desc: '', args: []);
  }

  /// `Take a photo`
  String get takePhoto {
    return Intl.message('Take a photo', name: 'takePhoto', desc: '', args: []);
  }

  /// `Choose from gallery`
  String get chooseFromGallery {
    return Intl.message(
      'Choose from gallery',
      name: 'chooseFromGallery',
      desc: '',
      args: [],
    );
  }

  /// `Medication Name`
  String get medicationName {
    return Intl.message(
      'Medication Name',
      name: 'medicationName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter medication name`
  String get pleaseEnterMedicationName {
    return Intl.message(
      'Please enter medication name',
      name: 'pleaseEnterMedicationName',
      desc: '',
      args: [],
    );
  }

  /// `Medication Type`
  String get medicationType {
    return Intl.message(
      'Medication Type',
      name: 'medicationType',
      desc: '',
      args: [],
    );
  }

  /// `Frequency`
  String get frequency {
    return Intl.message('Frequency', name: 'frequency', desc: '', args: []);
  }

  /// `Alarm Times`
  String get alarmTimes {
    return Intl.message('Alarm Times', name: 'alarmTimes', desc: '', args: []);
  }

  /// `Please add at least one alarm time`
  String get pleaseAddAtLeastOneAlarmTime {
    return Intl.message(
      'Please add at least one alarm time',
      name: 'pleaseAddAtLeastOneAlarmTime',
      desc: '',
      args: [],
    );
  }

  /// `Every Day`
  String get everyDay {
    return Intl.message('Every Day', name: 'everyDay', desc: '', args: []);
  }

  /// `Specific Days`
  String get specificDays {
    return Intl.message(
      'Specific Days',
      name: 'specificDays',
      desc: '',
      args: [],
    );
  }

  /// `Every X Days`
  String get everyXDays {
    return Intl.message('Every X Days', name: 'everyXDays', desc: '', args: []);
  }

  /// `Every`
  String get every {
    return Intl.message('Every', name: 'every', desc: '', args: []);
  }

  /// `days`
  String get days {
    return Intl.message('days', name: 'days', desc: '', args: []);
  }

  /// `Days Interval`
  String get daysInterval {
    return Intl.message(
      'Days Interval',
      name: 'daysInterval',
      desc: '',
      args: [],
    );
  }

  /// `Days of Week`
  String get daysOfWeek {
    return Intl.message('Days of Week', name: 'daysOfWeek', desc: '', args: []);
  }

  /// `Pill`
  String get pill {
    return Intl.message('Pill', name: 'pill', desc: '', args: []);
  }

  /// `Injection`
  String get injection {
    return Intl.message('Injection', name: 'injection', desc: '', args: []);
  }

  /// `Liquid`
  String get liquid {
    return Intl.message('Liquid', name: 'liquid', desc: '', args: []);
  }

  /// `Radiation`
  String get radiation {
    return Intl.message('Radiation', name: 'radiation', desc: '', args: []);
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Medications`
  String get medications {
    return Intl.message('Medications', name: 'medications', desc: '', args: []);
  }

  /// `Visits`
  String get visits {
    return Intl.message('Visits', name: 'visits', desc: '', args: []);
  }

  /// `No medications reminders`
  String get noMedications {
    return Intl.message(
      'No medications reminders',
      name: 'noMedications',
      desc: '',
      args: [],
    );
  }

  /// `No medications for this date`
  String get noMedicationsForDate {
    return Intl.message(
      'No medications for this date',
      name: 'noMedicationsForDate',
      desc: '',
      args: [],
    );
  }

  /// `No visit reminders`
  String get noVisits {
    return Intl.message(
      'No visit reminders',
      name: 'noVisits',
      desc: '',
      args: [],
    );
  }

  /// `No visits for this date`
  String get noVisitsForDate {
    return Intl.message(
      'No visits for this date',
      name: 'noVisitsForDate',
      desc: '',
      args: [],
    );
  }

  /// `Add Medication`
  String get addMedication {
    return Intl.message(
      'Add Medication',
      name: 'addMedication',
      desc: '',
      args: [],
    );
  }

  /// `Add Visit`
  String get addVisit {
    return Intl.message('Add Visit', name: 'addVisit', desc: '', args: []);
  }

  /// `Edit Medication`
  String get editMedication {
    return Intl.message(
      'Edit Medication',
      name: 'editMedication',
      desc: '',
      args: [],
    );
  }

  /// `Edit Visit`
  String get editVisit {
    return Intl.message('Edit Visit', name: 'editVisit', desc: '', args: []);
  }

  /// `Are you sure you want to delete this medication reminder?`
  String get deleteMedication {
    return Intl.message(
      'Are you sure you want to delete this medication reminder?',
      name: 'deleteMedication',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this visit reminder?`
  String get deleteVisit {
    return Intl.message(
      'Are you sure you want to delete this visit reminder?',
      name: 'deleteVisit',
      desc: '',
      args: [],
    );
  }

  /// `Doctor Name`
  String get doctorName {
    return Intl.message('Doctor Name', name: 'doctorName', desc: '', args: []);
  }

  /// `Examination Type`
  String get examinationType {
    return Intl.message(
      'Examination Type',
      name: 'examinationType',
      desc: '',
      args: [],
    );
  }

  /// `Visit Date`
  String get visitDate {
    return Intl.message('Visit Date', name: 'visitDate', desc: '', args: []);
  }

  /// `Visit Time`
  String get visitTime {
    return Intl.message('Visit Time', name: 'visitTime', desc: '', args: []);
  }

  /// `Please enter doctor name`
  String get pleaseEnterDoctorName {
    return Intl.message(
      'Please enter doctor name',
      name: 'pleaseEnterDoctorName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter examination type`
  String get pleaseEnterExaminationType {
    return Intl.message(
      'Please enter examination type',
      name: 'pleaseEnterExaminationType',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message('Date', name: 'date', desc: '', args: []);
  }

  /// `Alarm Time`
  String get alarmTime {
    return Intl.message('Alarm Time', name: 'alarmTime', desc: '', args: []);
  }

  /// `Meds Reminder`
  String get medicationReminder {
    return Intl.message(
      'Meds Reminder',
      name: 'medicationReminder',
      desc: '',
      args: [],
    );
  }

  /// `Visit Reminder`
  String get visitReminder {
    return Intl.message(
      'Visit Reminder',
      name: 'visitReminder',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message('Today', name: 'today', desc: '', args: []);
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Select days of week`
  String get selectDaysOfWeek {
    return Intl.message(
      'Select days of week',
      name: 'selectDaysOfWeek',
      desc: '',
      args: [],
    );
  }

  /// `Day of the Week`
  String get dayOfTheWeek {
    return Intl.message(
      'Day of the Week',
      name: 'dayOfTheWeek',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message('Close', name: 'close', desc: '', args: []);
  }

  /// `Add`
  String get add {
    return Intl.message('Add', name: 'add', desc: '', args: []);
  }

  /// `This time is already added.`
  String get thisTimeIsAlreadyAdded {
    return Intl.message(
      'This time is already added.',
      name: 'thisTimeIsAlreadyAdded',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Please select days of week`
  String get pleaseSelectDaysOfWeek {
    return Intl.message(
      'Please select days of week',
      name: 'pleaseSelectDaysOfWeek',
      desc: '',
      args: [],
    );
  }

  /// `No pharmacies found matching the selected filter.`
  String get noPharmaciesFound {
    return Intl.message(
      'No pharmacies found matching the selected filter.',
      name: 'noPharmaciesFound',
      desc: '',
      args: [],
    );
  }

  /// `Navigate`
  String get navigate {
    return Intl.message('Navigate', name: 'navigate', desc: '', args: []);
  }

  /// `Closed`
  String get closed {
    return Intl.message('Closed', name: 'closed', desc: '', args: []);
  }

  /// `Login successfully`
  String get loginSuccessfully {
    return Intl.message(
      'Login successfully',
      name: 'loginSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message('Welcome', name: 'welcome', desc: '', args: []);
  }

  /// `Sign up successfully`
  String get signUpSuccessfully {
    return Intl.message(
      'Sign up successfully',
      name: 'signUpSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Please verify your email`
  String get pleaseVerifyYourEmail {
    return Intl.message(
      'Please verify your email',
      name: 'pleaseVerifyYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Email verified successfully`
  String get emailVerifiedSuccessfully {
    return Intl.message(
      'Email verified successfully',
      name: 'emailVerifiedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Sent code successfully`
  String get sentCodeSuccessfully {
    return Intl.message(
      'Sent code successfully',
      name: 'sentCodeSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Old Password`
  String get oldPassword {
    return Intl.message(
      'Old Password',
      name: 'oldPassword',
      desc: '',
      args: [],
    );
  }

  /// `Old Password is required`
  String get oldPasswordRequired {
    return Intl.message(
      'Old Password is required',
      name: 'oldPasswordRequired',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password is required`
  String get newPasswordRequired {
    return Intl.message(
      'New Password is required',
      name: 'newPasswordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Confirm New Password`
  String get confirmNewPassword {
    return Intl.message(
      'Confirm New Password',
      name: 'confirmNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm New Password is required`
  String get confirmPasswordRequired {
    return Intl.message(
      'Confirm New Password is required',
      name: 'confirmPasswordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Password changed successfully`
  String get changePasswordSuccessfully {
    return Intl.message(
      'Password changed successfully',
      name: 'changePasswordSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Document Verification`
  String get documentVerification {
    return Intl.message(
      'Document Verification',
      name: 'documentVerification',
      desc: '',
      args: [],
    );
  }

  /// `Please provide clear photos of your medical license and government ID to complete the verification process.`
  String get documentVerificationDescription {
    return Intl.message(
      'Please provide clear photos of your medical license and government ID to complete the verification process.',
      name: 'documentVerificationDescription',
      desc: '',
      args: [],
    );
  }

  /// `Government ID`
  String get governmentId {
    return Intl.message(
      'Government ID',
      name: 'governmentId',
      desc: '',
      args: [],
    );
  }

  /// `Tap to take a photo of your ID`
  String get tapToTakePhotoOfId {
    return Intl.message(
      'Tap to take a photo of your ID',
      name: 'tapToTakePhotoOfId',
      desc: '',
      args: [],
    );
  }

  /// `Make sure all text is clearly visible`
  String get makeSureTextVisible {
    return Intl.message(
      'Make sure all text is clearly visible',
      name: 'makeSureTextVisible',
      desc: '',
      args: [],
    );
  }

  /// `Medical Syndicate License`
  String get medicalSyndicateLicense {
    return Intl.message(
      'Medical Syndicate License',
      name: 'medicalSyndicateLicense',
      desc: '',
      args: [],
    );
  }

  /// `Tap to take a photo of your license`
  String get tapToTakePhotoOfLicense {
    return Intl.message(
      'Tap to take a photo of your license',
      name: 'tapToTakePhotoOfLicense',
      desc: '',
      args: [],
    );
  }

  /// `Upload`
  String get upload {
    return Intl.message('Upload', name: 'upload', desc: '', args: []);
  }

  /// `Tap to take a photo of your ID`
  String get tapToTakePhotoOfYourId {
    return Intl.message(
      'Tap to take a photo of your ID',
      name: 'tapToTakePhotoOfYourId',
      desc: '',
      args: [],
    );
  }

  /// `Make sure all text is clearly visible`
  String get makeSureAllTextVisible {
    return Intl.message(
      'Make sure all text is clearly visible',
      name: 'makeSureAllTextVisible',
      desc: '',
      args: [],
    );
  }

  /// `ID must be valid and not expired`
  String get idMustBeValidAndNotExpired {
    return Intl.message(
      'ID must be valid and not expired',
      name: 'idMustBeValidAndNotExpired',
      desc: '',
      args: [],
    );
  }

  /// `Both front and back sides are required`
  String get bothFrontAndBackSidesRequired {
    return Intl.message(
      'Both front and back sides are required',
      name: 'bothFrontAndBackSidesRequired',
      desc: '',
      args: [],
    );
  }

  /// `All personal information must be visible`
  String get allPersonalInfoMustBeVisible {
    return Intl.message(
      'All personal information must be visible',
      name: 'allPersonalInfoMustBeVisible',
      desc: '',
      args: [],
    );
  }

  /// `No fingers covering any part of the ID`
  String get noFingersCoveringId {
    return Intl.message(
      'No fingers covering any part of the ID',
      name: 'noFingersCoveringId',
      desc: '',
      args: [],
    );
  }

  /// `Tap to take a photo of your license`
  String get tapToTakePhotoOfYourLicense {
    return Intl.message(
      'Tap to take a photo of your license',
      name: 'tapToTakePhotoOfYourLicense',
      desc: '',
      args: [],
    );
  }

  /// `The license must be issued by the official\n   Medical Syndicate authority`
  String get licenseMustBeIssuedByAuthority {
    return Intl.message(
      'The license must be issued by the official\n   Medical Syndicate authority',
      name: 'licenseMustBeIssuedByAuthority',
      desc: '',
      args: [],
    );
  }

  /// `The license must be valid and not expired`
  String get licenseMustBeValidAndNotExpired {
    return Intl.message(
      'The license must be valid and not expired',
      name: 'licenseMustBeValidAndNotExpired',
      desc: '',
      args: [],
    );
  }

  /// `All personal details must be clearly visible`
  String get allPersonalDetailsMustBeVisible {
    return Intl.message(
      'All personal details must be clearly visible',
      name: 'allPersonalDetailsMustBeVisible',
      desc: '',
      args: [],
    );
  }

  /// `Photo requirements:`
  String get photoRequirements {
    return Intl.message(
      'Photo requirements:',
      name: 'photoRequirements',
      desc: '',
      args: [],
    );
  }

  /// `OTP verified successfully, please reset your password`
  String get resetPasswordOtpVerifiedSuccessfully {
    return Intl.message(
      'OTP verified successfully, please reset your password',
      name: 'resetPasswordOtpVerifiedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Your password has been successfully reset`
  String get resetPasswordSuccessfully {
    return Intl.message(
      'Your password has been successfully reset',
      name: 'resetPasswordSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Pharmacy Details`
  String get pharmacyDetailsTitle {
    return Intl.message(
      'Pharmacy Details',
      name: 'pharmacyDetailsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please provide the required information to complete your pharmacy registration.`
  String get pharmacyDetailsDescription {
    return Intl.message(
      'Please provide the required information to complete your pharmacy registration.',
      name: 'pharmacyDetailsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Pharmacy License`
  String get pharmacyLicenseTitle {
    return Intl.message(
      'Pharmacy License',
      name: 'pharmacyLicenseTitle',
      desc: '',
      args: [],
    );
  }

  /// `Daily Working Hours`
  String get dailyWorkingHoursLabel {
    return Intl.message(
      'Daily Working Hours',
      name: 'dailyWorkingHoursLabel',
      desc: '',
      args: [],
    );
  }

  /// `Please enter Daily working hours`
  String get workingHoursValidationError {
    return Intl.message(
      'Please enter Daily working hours',
      name: 'workingHoursValidationError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid number`
  String get validNumberValidationError {
    return Intl.message(
      'Please enter a valid number',
      name: 'validNumberValidationError',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Service`
  String get deliveryServiceTitle {
    return Intl.message(
      'Delivery Service',
      name: 'deliveryServiceTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enable Delivery Service`
  String get enableDeliveryService {
    return Intl.message(
      'Enable Delivery Service',
      name: 'enableDeliveryService',
      desc: '',
      args: [],
    );
  }

  /// `Allow customers to request medicine delivery`
  String get allowMedicineDelivery {
    return Intl.message(
      'Allow customers to request medicine delivery',
      name: 'allowMedicineDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Select Location on Map`
  String get selectLocationLabel {
    return Intl.message(
      'Select Location on Map',
      name: 'selectLocationLabel',
      desc: '',
      args: [],
    );
  }

  /// `Please select your pharmacy location`
  String get selectLocationError {
    return Intl.message(
      'Please select your pharmacy location',
      name: 'selectLocationError',
      desc: '',
      args: [],
    );
  }

  /// `Select This Location`
  String get selectThisLocation {
    return Intl.message(
      'Select This Location',
      name: 'selectThisLocation',
      desc: '',
      args: [],
    );
  }

  /// `Pick Pharmacy Location`
  String get pickPharmacyLocation {
    return Intl.message(
      'Pick Pharmacy Location',
      name: 'pickPharmacyLocation',
      desc: '',
      args: [],
    );
  }

  /// `Location permission or service is not available. Please enable location services and grant permission in your device settings to proceed.`
  String get locationPermissionError {
    return Intl.message(
      'Location permission or service is not available. Please enable location services and grant permission in your device settings to proceed.',
      name: 'locationPermissionError',
      desc: '',
      args: [],
    );
  }

  /// `Report`
  String get report {
    return Intl.message('Report', name: 'report', desc: '', args: []);
  }

  /// `Show Original`
  String get showOriginal {
    return Intl.message(
      'Show Original',
      name: 'showOriginal',
      desc: '',
      args: [],
    );
  }

  /// `Show Translation`
  String get showTranslation {
    return Intl.message(
      'Show Translation',
      name: 'showTranslation',
      desc: '',
      args: [],
    );
  }

  /// `See More`
  String get seeMore {
    return Intl.message('See More', name: 'seeMore', desc: '', args: []);
  }

  /// `See Less`
  String get seeLess {
    return Intl.message('See Less', name: 'seeLess', desc: '', args: []);
  }

  /// `Thanks for signing up! We're verifying your identity. This may take up to 48 hours. You'll be notified by email once approved.`
  String get accountReviewMessage {
    return Intl.message(
      'Thanks for signing up! We\'re verifying your identity. This may take up to 48 hours. You\'ll be notified by email once approved.',
      name: 'accountReviewMessage',
      desc: '',
      args: [],
    );
  }

  /// `My Profile`
  String get myProfile {
    return Intl.message('My Profile', name: 'myProfile', desc: '', args: []);
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Switch to Arabic`
  String get switchToArabic {
    return Intl.message(
      'Switch to Arabic',
      name: 'switchToArabic',
      desc: '',
      args: [],
    );
  }

  /// `Switch to English`
  String get switchToEnglish {
    return Intl.message(
      'Switch to English',
      name: 'switchToEnglish',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get logout {
    return Intl.message('Log out', name: 'logout', desc: '', args: []);
  }

  /// `Are you sure you want to logout?`
  String get logout_confirm {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'logout_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Yes`
  String get yes {
    return Intl.message('Yes', name: 'yes', desc: '', args: []);
  }

  /// `Manage Your Records`
  String get manageYourRecords {
    return Intl.message(
      'Manage Your Records',
      name: 'manageYourRecords',
      desc: '',
      args: [],
    );
  }

  /// `New Record`
  String get newRecord {
    return Intl.message('New Record', name: 'newRecord', desc: '', args: []);
  }

  /// `Edit Record`
  String get editRecord {
    return Intl.message('Edit Record', name: 'editRecord', desc: '', args: []);
  }

  /// `Are you sure you want to report this post?`
  String get areYouSureYouWantToReportThisPost {
    return Intl.message(
      'Are you sure you want to report this post?',
      name: 'areYouSureYouWantToReportThisPost',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to edit this post?`
  String get areYouSureYouWantToEditThisPost {
    return Intl.message(
      'Are you sure you want to edit this post?',
      name: 'areYouSureYouWantToEditThisPost',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this comment?`
  String get areYouSureYouWantToDeleteThisComment {
    return Intl.message(
      'Are you sure you want to delete this comment?',
      name: 'areYouSureYouWantToDeleteThisComment',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to report this comment?`
  String get areYouSureYouWantToReportThisComment {
    return Intl.message(
      'Are you sure you want to report this comment?',
      name: 'areYouSureYouWantToReportThisComment',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to edit this comment?`
  String get areYouSureYouWantToEditThisComment {
    return Intl.message(
      'Are you sure you want to edit this comment?',
      name: 'areYouSureYouWantToEditThisComment',
      desc: '',
      args: [],
    );
  }

  /// `Create Post`
  String get createPost {
    return Intl.message('Create Post', name: 'createPost', desc: '', args: []);
  }

  /// `Edit Post`
  String get editPost {
    return Intl.message('Edit Post', name: 'editPost', desc: '', args: []);
  }

  /// `No comments yet`
  String get noComments {
    return Intl.message(
      'No comments yet',
      name: 'noComments',
      desc: '',
      args: [],
    );
  }

  /// `Add a comment...`
  String get addComment {
    return Intl.message(
      'Add a comment...',
      name: 'addComment',
      desc: '',
      args: [],
    );
  }

  /// `What's on your mind?`
  String get postContent {
    return Intl.message(
      'What\'s on your mind?',
      name: 'postContent',
      desc: '',
      args: [],
    );
  }

  /// `Add Image`
  String get postImage {
    return Intl.message('Add Image', name: 'postImage', desc: '', args: []);
  }

  /// `Image removed`
  String get postImageRemoved {
    return Intl.message(
      'Image removed',
      name: 'postImageRemoved',
      desc: '',
      args: [],
    );
  }

  /// `Error loading image`
  String get postImageError {
    return Intl.message(
      'Error loading image',
      name: 'postImageError',
      desc: '',
      args: [],
    );
  }

  /// `Post created successfully`
  String get postCreatedSuccessfully {
    return Intl.message(
      'Post created successfully',
      name: 'postCreatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Comment added successfully`
  String get commentAddedSuccessfully {
    return Intl.message(
      'Comment added successfully',
      name: 'commentAddedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Comment updated successfully`
  String get commentUpdatedSuccessfully {
    return Intl.message(
      'Comment updated successfully',
      name: 'commentUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Comment deleted successfully`
  String get commentDeletedSuccessfully {
    return Intl.message(
      'Comment deleted successfully',
      name: 'commentDeletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Loading comments...`
  String get loadingComments {
    return Intl.message(
      'Loading comments...',
      name: 'loadingComments',
      desc: '',
      args: [],
    );
  }

  /// `Error loading comments`
  String get errorLoadingComments {
    return Intl.message(
      'Error loading comments',
      name: 'errorLoadingComments',
      desc: '',
      args: [],
    );
  }

  /// `Error loading posts`
  String get errorLoadingPosts {
    return Intl.message(
      'Error loading posts',
      name: 'errorLoadingPosts',
      desc: '',
      args: [],
    );
  }

  /// `Error creating post`
  String get errorCreatingPost {
    return Intl.message(
      'Error creating post',
      name: 'errorCreatingPost',
      desc: '',
      args: [],
    );
  }

  /// `Error updating post`
  String get errorUpdatingPost {
    return Intl.message(
      'Error updating post',
      name: 'errorUpdatingPost',
      desc: '',
      args: [],
    );
  }

  /// `Error deleting post`
  String get errorDeletingPost {
    return Intl.message(
      'Error deleting post',
      name: 'errorDeletingPost',
      desc: '',
      args: [],
    );
  }

  /// `Error reporting post`
  String get errorReportingPost {
    return Intl.message(
      'Error reporting post',
      name: 'errorReportingPost',
      desc: '',
      args: [],
    );
  }

  /// `Error adding comment`
  String get errorAddingComment {
    return Intl.message(
      'Error adding comment',
      name: 'errorAddingComment',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message('Update', name: 'update', desc: '', args: []);
  }

  /// `Post`
  String get post {
    return Intl.message('Post', name: 'post', desc: '', args: []);
  }

  /// `Anything on your mind?\nLet it out here.`
  String get postHint {
    return Intl.message(
      'Anything on your mind?\nLet it out here.',
      name: 'postHint',
      desc: '',
      args: [],
    );
  }

  /// `Add Image`
  String get addImage {
    return Intl.message('Add Image', name: 'addImage', desc: '', args: []);
  }

  /// `Remove Image`
  String get removeImage {
    return Intl.message(
      'Remove Image',
      name: 'removeImage',
      desc: '',
      args: [],
    );
  }

  /// `Comments`
  String get comments {
    return Intl.message('Comments', name: 'comments', desc: '', args: []);
  }

  /// `Error updating comment`
  String get errorUpdatingComment {
    return Intl.message(
      'Error updating comment',
      name: 'errorUpdatingComment',
      desc: '',
      args: [],
    );
  }

  /// `Error deleting comment`
  String get errorDeletingComment {
    return Intl.message(
      'Error deleting comment',
      name: 'errorDeletingComment',
      desc: '',
      args: [],
    );
  }

  /// `Error reporting comment`
  String get errorReportingComment {
    return Intl.message(
      'Error reporting comment',
      name: 'errorReportingComment',
      desc: '',
      args: [],
    );
  }

  /// `Edit Comment`
  String get editComment {
    return Intl.message(
      'Edit Comment',
      name: 'editComment',
      desc: '',
      args: [],
    );
  }

  /// `Edit your comment`
  String get editCommentHint {
    return Intl.message(
      'Edit your comment',
      name: 'editCommentHint',
      desc: '',
      args: [],
    );
  }

  /// `Comment cannot be empty`
  String get commentCannotBeEmpty {
    return Intl.message(
      'Comment cannot be empty',
      name: 'commentCannotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Comment reported successfully`
  String get commentReportedSuccessfully {
    return Intl.message(
      'Comment reported successfully',
      name: 'commentReportedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Post deleted successfully`
  String get postDeletedSuccessfully {
    return Intl.message(
      'Post deleted successfully',
      name: 'postDeletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Post updated successfully`
  String get postUpdatedSuccessfully {
    return Intl.message(
      'Post updated successfully',
      name: 'postUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Post reported successfully`
  String get postReportedSuccessfully {
    return Intl.message(
      'Post reported successfully',
      name: 'postReportedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this post?`
  String get areYouSureYouWantToDeleteThisPost {
    return Intl.message(
      'Are you sure you want to delete this post?',
      name: 'areYouSureYouWantToDeleteThisPost',
      desc: '',
      args: [],
    );
  }

  /// `Write a comment...`
  String get writeAComment {
    return Intl.message(
      'Write a comment...',
      name: 'writeAComment',
      desc: '',
      args: [],
    );
  }

  /// `Post cannot be empty`
  String get postCannotBeEmpty {
    return Intl.message(
      'Post cannot be empty',
      name: 'postCannotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Opening Hour`
  String get openHourLabel {
    return Intl.message(
      'Opening Hour',
      name: 'openHourLabel',
      desc: '',
      args: [],
    );
  }

  /// `Please select opening hour`
  String get openHourValidationError {
    return Intl.message(
      'Please select opening hour',
      name: 'openHourValidationError',
      desc: '',
      args: [],
    );
  }

  /// `Closing Hour`
  String get closeHourLabel {
    return Intl.message(
      'Closing Hour',
      name: 'closeHourLabel',
      desc: '',
      args: [],
    );
  }

  /// `Please select closing hour`
  String get closeHourValidationError {
    return Intl.message(
      'Please select closing hour',
      name: 'closeHourValidationError',
      desc: '',
      args: [],
    );
  }

  /// `Updated successfully`
  String get updatedSuccessfully {
    return Intl.message(
      'Updated successfully',
      name: 'updatedSuccessfully',
      desc: '',
      args: [],
    );
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
