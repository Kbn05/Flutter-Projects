import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:biometric_login_app/widgets/login.dart';
import 'package:biometric_login_app/views/homeView.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum _SupportState {
  unknown,
  supported,
  unsupported,
}
class ViewLogin extends StatefulWidget {
  const ViewLogin({Key? key}) : super(key: key);

  @override
  State<ViewLogin> createState() => _ViewLoginState();
}

class _ViewLoginState extends State<ViewLogin> {
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final LocalAuthentication auth = LocalAuthentication();
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  _SupportState _supportState = _SupportState.unknown;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  bool? _isAuthEnabled;

  @override
  void initState() {
    super.initState();
    auth.isDeviceSupported().then((isSupported) {
      setState(() {
        _supportState =
            isSupported ? _SupportState.supported : _SupportState.unsupported;
      });
      print('Supported: $_supportState');
    });
    _prefs.then((SharedPreferences prefs) {
      final String? token = prefs.getString('token');
      if (token != null) {
        Get.to(const HomeView());
      }
    });
    _checkAuthStatus();
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Authenticate to access your account',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
        // _authorized = authenticated ? 'Authorized' : 'Not Authorized';
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error: ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }
    setState(
        () => _authorized = authenticated ? 'Authorized' : 'Not Authorized');
    print('Authenticated: $authenticated');
    if (authenticated == true) {
      Get.to(const HomeView());
    }
  }

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Scan your fingerprint to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error: ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }
    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() => _authorized = message);
    if (authenticated == true) {
      final response = await http.post(
        Uri.parse('http://10.153.82.61:3000/login/validate'),
        body: {'token': await storage.read(key: 'token')},
      );
      print('Response: ${response.body}');
      if (response.statusCode == 200) {
        final SharedPreferences prefs = await _prefs;
        prefs.setString('token', response.body);
        Get.to(const HomeView());
      } else {
        print('Error: ${response.statusCode}');
      }
    }
  }

  Future<void> _cancelAuthentication() async {
    await auth.stopAuthentication();
    setState(() {
      _isAuthenticating = false;
      _authorized = 'Not Authorized';
    });
  }

  Future<void> _checkAuthStatus() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      _isAuthEnabled = prefs.getBool('enAuth') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LoginBar(
              usernameController: _controllerUsername,
              passwordController: _controllerPassword,
            ),
            ElevatedButton(
              onPressed: () async {
                print('Username: ${_controllerUsername.text}');
                print('Password: ${_controllerPassword.text}');
                final response = await http.post(
                  Uri.parse('http://10.153.82.61:3000/login'),
                  body: {
                    'username': _controllerUsername.text,
                    'password': _controllerPassword.text,
                  },
                );
                print('Response: ${response.body}');
                if (response.statusCode == 200) {
                  final SharedPreferences prefs = await _prefs;
                  prefs.setString('token', response.body);
                  Get.to(const HomeView());
                } else {
                  print('Error: ${response.statusCode}');
                }
              },
              child: const Text('Login'),
            ),
            _isAuthEnabled == true
                ? ElevatedButton(
                    onPressed: () {
                      if (_supportState == _SupportState.unknown) {
                        const CircularProgressIndicator();
                      } else if (_supportState == _SupportState.supported) {
                        print('Biometrics supported');
                      } else {
                        print('Biometrics not supported');
                      }
                      print('Authorized: $_authorized');
                      if (_isAuthenticating) {
                        ElevatedButton(
                          onPressed: _cancelAuthentication,
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text('Cancel Authentication'),
                              Icon(Icons.cancel),
                            ],
                          ),
                        );
                        print('Cancel authentication');
                      } else {
                        _authenticateWithBiometrics();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      textStyle: const TextStyle(color: Colors.white),
                    ),
                    child: const Text('Login with Biometrics'),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
