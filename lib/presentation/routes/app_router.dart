import 'package:sky_pet/presentation/home/home_page.dart';
import 'package:sky_pet/presentation/sign_in/sign_in_page.dart';
import 'package:auto_route/annotations.dart';
import 'package:sky_pet/presentation/sign_up/sign_up_page.dart';
import 'package:sky_pet/presentation/splash/splash_page.dart';
import 'package:sky_pet/presentation/welcome/welcome_page.dart';

@MaterialAutoRouter(replaceInRouteName: 'Page,Route', routes: <AutoRoute>[
  AutoRoute(page: SplashPage, initial: true),
  AutoRoute(page: WelcomePage),
  AutoRoute(page: SignInPage),
  AutoRoute(page: SignUpPage),
  AutoRoute(page: HomePage),
])
class $AppRouter {}
