import 'package:get/get.dart';
import 'package:m2online_recharge_app/screens/Scanner/scanner_screen.dart';
import 'package:m2online_recharge_app/screens/dashboard/dashboard_screen.dart';
import 'package:m2online_recharge_app/screens/first_time/first_main_screen.dart';
import 'package:m2online_recharge_app/screens/login/login_screen.dart';
import 'package:m2online_recharge_app/screens/login/login_select_screen.dart';
import 'package:m2online_recharge_app/screens/login/otp/otp_login_screen.dart';
import 'package:m2online_recharge_app/screens/login/password/password_login_screen.dart';
import 'package:m2online_recharge_app/screens/main/main_screen.dart';
import 'package:m2online_recharge_app/screens/profile/profile_details_screen.dart';
import 'package:m2online_recharge_app/screens/profile/profile_screen.dart';
import 'package:m2online_recharge_app/screens/quick_transfer/ToBank/To_bank_screen.dart';
import 'package:m2online_recharge_app/screens/quick_transfer/ToMobile/To_mobile_screen.dart';
import 'package:m2online_recharge_app/screens/quick_transfer/ToSelf/add_bank_screen.dart';
import 'package:m2online_recharge_app/screens/quick_transfer/qr/qr_screen.dart';
import 'package:m2online_recharge_app/screens/recharge_bills/electricity_bill/electric_bill_list_screen.dart';
import 'package:m2online_recharge_app/screens/recharge_bills/electricity_bill/electricty_bill_details_screen.dart';
import 'package:m2online_recharge_app/screens/recharge_bills/electricity_bill/eletricity_bill_entry_screen.dart';
import 'package:m2online_recharge_app/screens/recharge_bills/mobile_recharge/mobile_recharge_home.dart';
import 'package:m2online_recharge_app/screens/recharge_bills/mobile_recharge/payment_success_screen.dart';
import 'package:m2online_recharge_app/screens/recharge_bills/mobile_recharge/plan_selection_screen.dart';
import 'package:m2online_recharge_app/screens/quick_transfer/refer/refrel_earn_screen.dart';
import 'package:m2online_recharge_app/screens/recharge_bills/mobile_recharge/review_pay_screen.dart';
import 'package:m2online_recharge_app/screens/mycards/mycard_screen.dart';
import 'package:m2online_recharge_app/screens/register/register_screen.dart';
import 'package:m2online_recharge_app/screens/splash/splash_screen.dart';
import 'package:m2online_recharge_app/screens/wallet/wallet_screen.dart';

class AppRoutes {
  static const home = '/';
  static const first = '/first';
  static const loginselect = '/loginselect';
  static const otpLogin = '/otpLogin';
  static const passLogin = '/passLogin';
  static const login = '/login';
  static const register = '/register';
  static const main = '/main';
  static const dashboard = '/dashboard';
  static const mobilerecharge = '/mobileRecharge';
  static const planSelction = '/planSelction';
  static const reviewpay = '/reviewPay';
  static const paymentSuccess = '/paymentSuccess';
  static const scanner = '/scanner';
  static const wallet = '/wallet';
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
    GetPage(name: login, page: () => const LoginScreen()),
    GetPage(name: register, page: () => const RegisterScreen()),
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
