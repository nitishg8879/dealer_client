abstract class Routes {
  //onboarding
  static const onboarding = _Paths.onboarding;
  static const splash = _Paths.splash;
  //home
  static const dashboard = _Paths.dashboard;
  static const home = _Paths.home;
  static const rating = _Paths.rating;
  static const contactDriverInbox = _Paths.contactDriverInbox;
  static const contactDriverCall = _Paths.contactDriverCall;
  static const cancelRide = _Paths.cancelRide;

  //auth
  static const signUp = _Paths.signUp;
  static const signIn = _Paths.signIn;
  static const signUpSuccess = _Paths.signUpSuccess;
  static const createPassword = _Paths.createPassword;
  static const forgotPassword = _Paths.forgotPassword;

  //? Wallet
  static const wallet = _Paths.wallet;
  static const walletHistory = _Paths.walletHistory;
  static const walletTopUp = _Paths.walletTopUp;
  static const walletScanner = _Paths.walletScanner;
  static const walletShowQR = _Paths.walletShowQR;
  static const walletTopUpConfirmation = _Paths.walletTopUpConfirmation;
  static const paymentSuccess = _Paths.paymentSuccess;

  //? Profile
  static const profile = _Paths.profile;
  static const editProfile = _Paths.editProfile;

  //? Setting
  static const settingHome = _Paths.settingHome;
  static const changePassword = _Paths.changePassword;
  static const changePin = _Paths.changePin;
  static const activity = _Paths.activity;
  static const notification = _Paths.notification;
  static const paymentMethod = _Paths.paymentMethod;
  static const helpAndSupport = _Paths.helpAndSupport;
  static const language = _Paths.language;
  static const privacyPolicy = _Paths.privacyPolicy;
  static const address = _Paths.address;
}

abstract class _Paths {
  //onboarding
  static const onboarding = '/onboarding';
  static const splash = '/splash';

  //auth

  static const signUp = '/signUp';
  static const signIn = '/signIn';
  static const signUpSuccess = "/signUpSuccess";
  static const createPassword = '/createPassword';
  static const forgotPassword = '/forgotPassword';

  //? Wallet
  static const wallet = '/wallet';
  static const walletHistory = 'walletHistory';
  static const walletTopUp = 'topUp';
  static const walletScanner = 'scanner';
  static const walletShowQR = 'showQR';
  static const walletTopUpConfirmation = 'walletTopUpconfirmation';
  static const paymentSuccess = 'paymentSuccess';

  //home
  static const dashboard = '/dashboard';
  static const home = '/home';
  static const rating = '/rating';
  static const contactDriverInbox = 'contact_driver_inbox';
  static const contactDriverCall = 'contact_driver_call';
  static const cancelRide = '/cancelRide';

  //? Profile
  static const profile = '/profile';
  static const editProfile = 'editProfile';

  //? Setting
  static const settingHome = 'settingHome';
  static const changePassword = 'changePassword';
  static const changePin = 'changePin';
  static const activity = 'activity';
  static const notification = 'notification';
  static const paymentMethod = 'paymentMethod';
  static const helpAndSupport = 'helpAndSupport';
  static const language = 'language';
  static const privacyPolicy = 'privacyPolicy';
  static const address = 'address';
}
