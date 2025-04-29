abstract class FontFamily {
  static const poppins = 'Poppins';
  static const almarai = 'Almarai';
  static const righteous = 'Righteous';
}

const appName = 'CancApp';

abstract class CacheKeys {
  static const language = 'language';
  static const onBoarding = 'onBoarding';
  static const whoAreYou = 'who';
  static const isLoggedIn = 'isLoggedIn';
}

abstract class UsersKey {
  static const String patient = 'Patient',
      doctor = 'Doctor',
      pharmacist = 'Pharmacist',
      volunteer = 'Volunteer',
      psychiatrist = 'Psychiatrist',
      admin = 'Admin';
}
