import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_functions/cloud_functions.dart';

import 'auth/firebase_auth/firebase_user_provider.dart';
import 'auth/firebase_auth/auth_util.dart';

import 'backend/firebase/firebase_config.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'package:google_fonts/google_fonts.dart';
import 'flutter_flow/nav/nav.dart';
import 'index.dart';
import '/index.dart';

Future<void> initializePushNotificationsForCurrentUser() async {
  if (currentUserUid.isEmpty) {
    print('Push setup skipped: currentUserUid is empty.');
    return;
  }

  final messaging = FirebaseMessaging.instance;

  final settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  final permissionStatus =
      settings.authorizationStatus.toString().split('.').last;

  print('Push permission status: $permissionStatus');

  if (settings.authorizationStatus == AuthorizationStatus.denied) {
    print('Push setup stopped: notifications permission denied.');
    return;
  }

  String? apnsToken;

  for (int i = 0; i < 10; i++) {
    apnsToken = await messaging.getAPNSToken();

    if (apnsToken != null) {
      print('APNs token received.');
      break;
    }

    print('APNs token is not ready yet. Attempt ${i + 1}/10');
    await Future.delayed(const Duration(seconds: 1));
  }

  if (apnsToken == null) {
    print('APNs token is still null. FCM token will not be requested yet.');
    print(
      'Push setup status: apns_token_missing. This is expected without Apple Developer/APNs setup.',
    );
    return;
  }

  try {
    final fcmToken = await messaging.getToken();

    if (fcmToken == null) {
      print('FCM token is null.');
      return;
    }

    print('FCM token received: $fcmToken');

    final callable = FirebaseFunctions.instanceFor(region: 'us-central1')
        .httpsCallable('saveUserFcmToken');

    final result = await callable.call({
      'token': fcmToken,
      'platform': 'ios',
      'permissionStatus': permissionStatus,
    });

    print('saveUserFcmToken result: ${result.data}');

    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      print('FCM token refreshed: $newToken');

      try {
        final refreshCallable =
            FirebaseFunctions.instanceFor(region: 'us-central1')
                .httpsCallable('saveUserFcmToken');

        final refreshResult = await refreshCallable.call({
          'token': newToken,
          'platform': 'ios',
          'permissionStatus': permissionStatus,
        });

        print('saveUserFcmToken refresh result: ${refreshResult.data}');
      } catch (e) {
        print('Error saving refreshed FCM token: $e');
      }
    });
  } catch (e) {
    print('Error getting or saving FCM token: $e');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();

  await initFirebase();

  await FlutterFlowTheme.initialize();

  final appState = FFAppState(); // Initialize FFAppState
  await appState.initializePersistedState();

  runApp(ChangeNotifierProvider(
    create: (context) => appState,
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = FlutterFlowTheme.themeMode;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;

  String getRoute([RouteMatch? routeMatch]) {
    final RouteMatch lastMatch =
        routeMatch ?? _router.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : _router.routerDelegate.currentConfiguration;
    return matchList.uri.path;
  }

  List<String> getRouteStack() =>
      _router.routerDelegate.currentConfiguration.matches
          .map((e) => getRoute(e))
          .toList();

  late Stream<BaseAuthUser> userStream;
  bool _pushInitialized = false;

  @override
  void initState() {
    super.initState();

    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);

    userStream = simpleNoticeAppFirebaseUserStream()
      ..listen((user) {
        _appStateNotifier.update(user);

        if (user.loggedIn && !_pushInitialized) {
          _pushInitialized = true;
          initializePushNotificationsForCurrentUser();
        }
      });

    jwtTokenStream.listen((_) {});

    Future.delayed(
      Duration(milliseconds: 1000),
      () => _appStateNotifier.stopShowingSplashImage(),
    );
  }

  void setThemeMode(ThemeMode mode) => safeSetState(() {
        _themeMode = mode;
        FlutterFlowTheme.saveThemeMode(mode);
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'simple notice app',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: false,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: false,
      ),
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }
}

class NavBarPage extends StatefulWidget {
  NavBarPage({
    Key? key,
    this.initialPage,
    this.page,
    this.disableResizeToAvoidBottomInset = false,
  }) : super(key: key);

  final String? initialPage;
  final Widget? page;
  final bool disableResizeToAvoidBottomInset;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPageName = 'MainPage';
  late Widget? _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPageName = widget.initialPage ?? _currentPageName;
    _currentPage = widget.page;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'MainPage': MainPageWidget(),
      'CheckinPage': CheckinPageWidget(),
      'AnalyticsPage': AnalyticsPageWidget(),
      'ProfilePage': ProfilePageWidget(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPageName);

    return Scaffold(
      resizeToAvoidBottomInset: !widget.disableResizeToAvoidBottomInset,
      body: _currentPage ?? tabs[_currentPageName],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) => safeSetState(() {
          _currentPage = null;
          _currentPageName = tabs.keys.toList()[i];
        }),
        backgroundColor: Color(0xFF0B0F1A),
        selectedItemColor: Color(0xFFF0F1FB),
        unselectedItemColor: Color(0x58F0F1FB),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              size: 30.0,
            ),
            label: 'Home',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_border,
              size: 30.0,
            ),
            label: 'Checkin',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.analytics_outlined,
              size: 30.0,
            ),
            label: 'Analytics',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
              size: 30.0,
            ),
            label: 'Profile',
            tooltip: '',
          )
        ],
      ),
    );
  }
}