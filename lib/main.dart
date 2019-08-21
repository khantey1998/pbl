//import 'package:flutter/material.dart';
//import 'package:pbl/pages/startup.dart';
//import 'pages/orders.dart';
//
//import 'blocs/provider.dart';
//
//import 'package:bloc/bloc.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:pbl/utils/user_repository.dart';
//
//import 'package:pbl/authentication/authentication.dart';
//import 'package:pbl/splash/splash.dart';
//import 'package:pbl/login/login.dart';
//import 'package:pbl/pages/home.dart';
//import 'package:pbl/common/common.dart';
////void main() => runApp(MyApp());
//
//class SimpleBlocDelegate extends BlocDelegate {
//  @override
//  void onTransition(Transition transition) {
//    print(transition.toString());
//  }
//}
//
//void main() {
//  BlocSupervisor().delegate = SimpleBlocDelegate();
//  runApp(MyApp(userRepository: UserRepository()));
//}
//
//class MyApp extends StatefulWidget {
//  final UserRepository userRepository;
//
//  MyApp({Key key, @required this.userRepository}) : super(key: key);
//
//  @override
//  State<MyApp> createState() => _AppState();
//}
//
//class _AppState extends State<MyApp> {
//  AuthenticationBloc authenticationBloc;
//  UserRepository get userRepository => widget.userRepository;
//
//  @override
//  void initState() {
//    authenticationBloc = AuthenticationBloc(userRepository: userRepository);
//    authenticationBloc.dispatch(AppStarted());
//    super.initState();
//  }
//
//  @override
//  void dispose() {
//    authenticationBloc.dispose();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return BlocProvider<AuthenticationBloc>(
//      bloc: authenticationBloc,
//      child: MaterialApp(
//        home: BlocBuilder<AuthenticationEvent, AuthenticationState>(
//          bloc: authenticationBloc,
//          builder: (BuildContext context, AuthenticationState state) {
//            if (state is AuthenticationUninitialized) {
//              return SplashPage();
//            }
//            if (state is AuthenticationAuthenticated) {
//              return HomePage();
//            }
//            if (state is AuthenticationUnauthenticated) {
//              return LoginPage(userRepository: userRepository,);
//            }
//            if (state is AuthenticationLoading) {
//              return LoadingIndicator();
//            }
//          },
//        ),
//      ),
//    );
//  }
//}
import 'package:flutter/material.dart';
import 'package:pbl/pages/startup.dart';
import 'pages/orders.dart';
import 'pages/home.dart';
import 'pages/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PBLCNT',
      theme: ThemeData(
        primaryColor: Color(0xffa78066),
        primarySwatch: Colors.brown,
      ),
      home: Greeting(),
//      routes: { //route setting
//        //'/': (context) => HomePage(),
//        '/home': (context) => HomePage(), //you should have something like this.
//      },
      routes: {
        HomePage.routeName: (BuildContext context) => new HomePage()
      },
    );
  }
}
