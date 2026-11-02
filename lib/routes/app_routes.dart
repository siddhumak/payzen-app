import 'package:get/get.dart';
import 'package:payzen_app/screens/Scanner/scanner_screen.dart';
import 'package:payzen_app/screens/dashboard/dashboard_screen.dart';
import 'package:payzen_app/screens/first_time/first_main_screen.dart';
import 'package:payzen_app/screens/login/login_screen.dart';
import 'package:payzen_app/screens/login/login_select_screen.dart';
import 'package:payzen_app/screens/login/otp/otp_login_screen.dart';
import 'package:payzen_app/screens/login/password/password_login_screen.dart';
import 'package:payzen_app/screens/main/main_screen.dart';
import 'package:payzen_app/screens/profile/profile_details_screen.dart';
import 'package:payzen_app/screens/profile/profile_screen.dart';
import 'package:payzen_app/screens/quick_transfer/ToBank/To_bank_screen.dart';
import 'package:payzen_app/screens/quick_transfer/ToMobile/To_mobile_screen.dart';
import 'package:payzen_app/screens/quick_transfer/ToSelf/add_bank_screen.dart';
import 'package:payzen_app/screens/quick_transfer/qr/qr_screen.dart';
import 'package:payzen_app/screens/recharge_bills/electricity_bill/electric_bill_list_screen.dart';
import 'package:payzen_app/screens/recharge_bills/electricity_bill/electricty_bill_details_screen.dart';
import 'package:payzen_app/screens/recharge_bills/electricity_bill/eletricity_bill_entry_screen.dart';
import 'package:payzen_app/screens/recharge_bills/mobile_recharge/mobile_recharge_home.dart';
import 'package:payzen_app/screens/recharge_bills/mobile_recharge/payment_success_screen.dart';
import 'package:payzen_app/screens/recharge_bills/mobile_recharge/plan_selection_screen.dart';
import 'package:payzen_app/screens/quick_transfer/refer/refrel_earn_screen.dart';
import 'package:payzen_app/screens/recharge_bills/mobile_recharge/review_pay_screen.dart';
import 'package:payzen_app/screens/mycards/mycard_screen.dart';
import 'package:payzen_app/screens/register/register_screen.dart';
import 'package:payzen_app/screens/register/signup_progress_screen.dart';
import 'package:payzen_app/screens/register/signup_success_screen.dart';
import 'package:payzen_app/screens/splash/splash_screen.dart';
import 'package:payzen_app/screens/wallet/wallet_screen.dart';
import 'package:payzen_app/screens/wallet/wallet_add_money_screen.dart';
import 'package:payzen_app/screens/wallet/wallet_activation_screen.dart';
import 'package:payzen_app/screens/wallet/pan_verification_screen.dart';
import 'package:payzen_app/screens/wallet/aadhaar_verification_screen.dart';
import 'package:payzen_app/screens/wallet/wallet_details_screen.dart';
import 'package:payzen_app/screens/wallet/wallet_activation_complete_screen.dart';
import 'package:payzen_app/screens/wallet/wallet_address_screen.dart';
import 'package:payzen_app/screens/wallet/wallet_video_kyc_screen.dart';

class AppRoutes {
  static const home = '/';
  static const first = '/first';
  static const loginselect = '/loginselect';
  static const otpLogin = '/otpLogin';
  static const passLogin = '/passLogin';
  static const login = '/login';
  static const register = '/register';
  static const signupProgress = '/signupProgress';
  static const signupSuccess = '/signupSuccess';
  static const main = '/main';
  static const dashboard = '/dashboard';
  static const mobilerecharge = '/mobileRecharge';
  static const planSelction = '/planSelction';
  static const reviewpay = '/reviewPay';
  static const paymentSuccess = '/paymentSuccess';
  static const scanner = '/scanner';
  static const wallet = '/wallet';
  static const walletAddMoney = '/walletAddMoney';
  static const walletActivation = '/walletActivation';
  static const walletPanVerification = '/walletPanVerification';
  static const walletAadhaarVerification = '/walletAadhaarVerification';
  static const walletDetails = '/walletDetails';
  static const walletAddress = '/walletAddress';
  static const walletVideoKyc = '/walletVideoKyc';
  static const walletActivationComplete = '/walletActivationComplete';
  static const mycards = '/mycards';
  static const toMobile = '/toMobile';
  static const toBank = '/toBank';
  static const referEarn = '/referEarn';
  static const addbank = '/addBank';
  static const qr = '/qr';
  static const billlist = '/billList';
  static const billentry = '/billEntry';
  static const billdetails = '/billDetails';
  static const profile = '/profile';
  static const profiledetails = '/profiledetails';

  static final routes = [
    GetPage(name: home, page: () => const SplashScreen()),
    GetPage(name: first, page: () => FirstTimeMainScreen()),
    GetPage(name: loginselect, page: () => LoginSelectionScreen()),
    GetPage(name: otpLogin, page: () => const OtpLoginScreen()),
    GetPage(name: passLogin, page: () => const PasswordLoginScreen()),
    GetPage(name: login, page: () => const LoginSelectionScreen()),
    GetPage(name: register, page: () => const RegisterScreen()),
    GetPage(name: signupProgress, page: () => const SignupProgressScreen()),
    GetPage(name: signupSuccess, page: () => const SignupSuccessScreen()),
    GetPage(name: main, page: () => const MainScreen()),
    GetPage(name: dashboard, page: () => const DashboardScreen()),
    GetPage(name: mobilerecharge, page: () => const MobileRechargeHomeScreen()),
    GetPage(
      name: planSelction,
      page:
          () => const PlanSelectionScreen(
            mobileNumber: '',
            operator: '',
            circle: '',
          ),
    ),

    GetPage(name: reviewpay, page: () => ReviewPayScreen()),
    GetPage(
      name: paymentSuccess,
      page:
          () => PaymentSuccessScreen(
            mobileNumber: '1234567890',
            operator: 'Jio',
            selectedPlan: {
              'planName': '1000',
              'planAmount': '100',
              'planValidity': '1 year',
            },
            transactionId: 'TXN001',
            paymentMethod: 'Debit Card',
          ),
    ),

    GetPage(name: scanner, page: () => const ScannerScreen()),
    GetPage(name: wallet, page: () => const WalletScreen()),
    GetPage(name: walletAddMoney, page: () => const WalletAddMoneyScreen()),
    GetPage(name: walletActivation, page: () => const WalletActivationScreen()),
    GetPage(
      name: walletPanVerification,
      page: () => const PanVerificationScreen(),
    ),
    GetPage(
      name: walletAadhaarVerification,
      page: () => const AadhaarVerificationScreen(),
    ),
    GetPage(name: walletDetails, page: () => const WalletDetailsScreen()),
    GetPage(name: walletAddress, page: () => const WalletAddressScreen()),
    GetPage(name: walletVideoKyc, page: () => const WalletVideoKycScreen()),
    GetPage(
      name: walletActivationComplete,
      page: () => const WalletActivationCompleteScreen(),
    ),

    GetPage(name: mycards, page: () => const MycardsScreen()),
    GetPage(name: toMobile, page: () => const ToMobileScreen()),
    GetPage(name: toBank, page: () => ToBankScreen()),
    GetPage(name: referEarn, page: () => ReferEarnScreen()),
    GetPage(name: addbank, page: () => AddBankAccountScreen()),
    GetPage(name: qr, page: () => QrScreen()),
    GetPage(name: billlist, page: () => ElectricityBillListScreen()),
    GetPage(name: billentry, page: () => ElectricityBillEntryScreen()),
    GetPage(name: billdetails, page: () => ElectricityBillDetailsScreen()),
    GetPage(name: profile, page: () => const ProfileScreen()),
    GetPage(name: profiledetails, page: () => const ProfileDetailsScreen()),
  ];
}
