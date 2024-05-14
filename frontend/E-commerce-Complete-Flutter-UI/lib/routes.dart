import 'package:get/get.dart';
import 'package:shop_app/screens/address/address_screen.dart';
import 'package:shop_app/screens/address/select_address_screen.dart';
import 'package:shop_app/screens/favorite/favorite_screen.dart';
import 'package:shop_app/screens/my_account/my_account_screen.dart';
import 'package:shop_app/screens/order_confirmation/order_confirmation_page.dart';
import 'package:shop_app/screens/order_splash_screen.dart';
import 'package:shop_app/screens/products/products_screen.dart';
import 'package:shop_app/screens/razorpay/razor_pay_page.dart';
import 'screens/cart/cart_screen.dart';
import 'screens/complete_profile/complete_profile_screen.dart';
import 'screens/details/details_screen.dart';
import 'screens/forgot_password/forgot_password_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/init_screen.dart';
import 'screens/login_success/login_success_screen.dart';
import 'screens/otp/otp_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/sign_in/sign_in_screen.dart';
import 'screens/sign_up/sign_up_screen.dart';
import 'screens/splash/splash_screen.dart';

 class AppRoutes {
   static const String initScreen = '/init_screen';
   static const String splashScreen = '/splash_screen';
   static const String signInScreen = '/sign_in_screen';
   static const String forgotPasswordScreen = '/forgot_password_screen';
   static const String loginSuccessScreen = '/login_success_screen';
   static const String signUpScreen = '/sign_up_screen';
   static const String completeProfileScreen = '/complete_profile_screen';
   static const String otpScreen = '/otp_screen';
   static const String homeScreen = '/home_screen';
   static const String productsScreen = '/products_screen';
   static const String detailsScreen = '/details_screen';
   static const String cartScreen = '/cart_screen';
   static const String profileScreen = '/profile_screen';
   static const String myAccountScreen = '/my_account_screen';
   static const String favouriteScreen = '/favourite_screen';
   static const String orderConfirmationScreen = '/order_confirmation_screen';
   static const String addressScreen = '/address_screen';
   static const String selectAddressScreen = '/select_address_screen';
   static const String razorPayScreen = '/razor_pay_screen';
   static const String orderSplashScreen = '/order_splash_screen';

   static List<GetPage> pages = [
     GetPage(
       name: initScreen,
       page: () => InitScreen(),
     ),
     GetPage(
       name: splashScreen,
       page: () => SplashScreen(),
     ),
     GetPage(
       name: signInScreen,
       page: () => SignInScreen(),
     ),
     GetPage(
       name: forgotPasswordScreen,
       page: () => ForgotPasswordScreen(),
     ),
     GetPage(
       name: loginSuccessScreen,
       page: () => LoginSuccessScreen(),
     ),
     GetPage(
       name: signUpScreen,
       page: () => SignUpScreen(),
     ),
     GetPage(
       name: completeProfileScreen,
       page: () => CompleteProfileScreen(),
     ),
     GetPage(
       name: myAccountScreen,
       page: () => MyAccountScreen(),
     ),
     GetPage(
       name: otpScreen,
       page: () => OtpScreen(),
     ),
     GetPage(
       name: homeScreen,
       page: () => HomeScreen(),
     ),
     GetPage(
       name: productsScreen,
       page: () => ProductsScreen(),
     ),
     GetPage(
       name: detailsScreen,
       page: () => DetailsScreen(),
     ),
     GetPage(
       name: cartScreen,
       page: () => CartScreen(),
     ),
     GetPage(
       name: profileScreen,
       page: () => ProfileScreen(),
     ),
     GetPage(
       name: favouriteScreen,
       page: () => FavoriteScreen(),
     ),
     GetPage(
         name: orderConfirmationScreen,
         page: () => OrderConfirmationPage()
     ),
     GetPage(
         name: addressScreen,
         page: () => AddressScreen()
     ),
     GetPage(
         name: selectAddressScreen,
         page: () => SelectAddressScreen()
     ),
     GetPage(
         name: razorPayScreen,
         page: () => RazorPayScreen()
     ),
     GetPage(
         name: orderSplashScreen,
         page: () => OrderSplashScreen()
     )
   ];

 }
