import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:biometric_login_app/widgets/login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController controllerUsername = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final LocalAuthentication auth = LocalAuthentication();
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  bool? _isAuthEnabled;

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      _isAuthEnabled = prefs.getBool('enAuth') ?? false;
    });
  }

  Future<void> _enableAuth() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool('enAuth', true);
    setState(() {
      _isAuthEnabled = true;
    });
  }

  Future<void> _authenticateWithBiometrics() async {
    final SharedPreferences prefs = await _prefs;
    final _isEnabled = prefs.getBool('enAuth') ?? false;
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
    if (_authorized == 'Authorized' && _isEnabled == false) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 500,
            child: Column(
              children: <Widget>[
                const Text('Confirm biometric authentication'),
                const SizedBox(height: 20),
                LoginBar(
                  usernameController: controllerUsername,
                  passwordController: controllerPassword,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final String? token = prefs.getString('token');
                    print('Username: ${controllerUsername.text}');
                    print('Password: ${controllerPassword.text}');
                    final response = await http.post(
                      Uri.parse('http://10.153.82.61:3000/login/longToken'),
                      headers: {
                        'Content-Type': 'application/json',
                        'Authorization': 'Bearer $token',
                        'Accept': 'application/json',
                      },
                      body: {
                        'username': controllerUsername.text,
                        'password': controllerPassword.text,
                      },
                    );
                    print('Response: ${response.body}');
                    if (response.statusCode == 200) {
                      print('Token: ${response.body}');
                      await storage.write(key: 'token', value: response.body);
                      setState(() {
                        _enableAuth();
                      });
                      Get.back();
                    } else {
                      print('Error: ${response.statusCode}');
                    }
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          );
        },
      );
    } else if (_authorized == 'Authorized' && _isEnabled == true) {
      await storage.delete(key: 'token');
      final SharedPreferences prefs = await _prefs;
      prefs.setBool('enAuth', false);
      setState(() {
        _isAuthEnabled = false;
      });
    }
    // if (authenticated == true) {
    //   final response = await http.post(
    //     Uri.parse('http://10.153.82.61:3000/login/validate'),
    //     body: {'token': await storage.read(key: 'token')},
    //   );
    //   print('Response: ${response.body}');
    //   if (response.statusCode == 200) {
    //     final SharedPreferences prefs = await _prefs;
    //     prefs.setString('token', response.body);
    //     Get.to(const HomeView());
    //   } else {
    //     print('Error: ${response.statusCode}');
    //   }
    // }
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           _isAuthEnabled == false
  //               ? Column(
  //                   children: <Widget>[
  //                     const Text('Enable Biometric Authentication'),
  //                     ElevatedButton(
  //                       onPressed: () {
  //                         showModalBottomSheet(
  //                           context: context,
  //                           builder: (BuildContext context) {
  //                             return Container(
  //                               height: 500,
  //                               child: Column(
  //                                 children: <Widget>[
  //                                   const Text(
  //                                       'Confirm biometric authentication'),
  //                                   const SizedBox(height: 20),
  //                                   LoginBar(
  //                                     usernameController: controllerUsername,
  //                                     passwordController: controllerPassword,
  //                                   ),
  //                                   ElevatedButton(
  //                                     onPressed: () async {
  //                                       print(
  //                                           'Username: ${controllerUsername.text}');
  //                                       print(
  //                                           'Password: ${controllerPassword.text}');
  //                                       final response = await http.post(
  //                                         Uri.parse(
  //                                             'http://10.153.82.61:3000/login/longToken'),
  //                                         body: {
  //                                           'username': controllerUsername.text,
  //                                           'password': controllerPassword.text,
  //                                         },
  //                                       );
  //                                       print('Response: ${response.body}');
  //                                       if (response.statusCode == 200) {
  //                                         print('Token: ${response.body}');
  //                                         await storage.write(
  //                                             key: 'token',
  //                                             value: response.body);
  //                                         setState(() {
  //                                           _enableAuth();
  //                                         });
  //                                         Get.back();
  //                                       } else {
  //                                         print(
  //                                             'Error: ${response.statusCode}');
  //                                       }
  //                                     },
  //                                     child: const Text('Login'),
  //                                   ),
  //                                 ],
  //                               ),
  //                             );
  //                           },
  //                         );
  //                       },
  //                       child: const Text('Enable'),
  //                     ),
  //                   ],
  //                 )
  //               : Column(
  //                   children: <Widget>[
  //                     const Text('Disable Biometric Authentication'),
  //                     ElevatedButton(
  //                       onPressed: () async {
  //                         await storage.delete(key: 'token');
  //                         final SharedPreferences prefs = await _prefs;
  //                         prefs.setBool('enAuth', false);
  //                         setState(() {
  //                           _isAuthEnabled = false;
  //                         });
  //                       },
  //                       child: const Text('Disable'),
  //                     ),
  //                   ],
  //                 ),
  //           const SizedBox(height: 20),
  //           const Text('Home View'),
  //           const SizedBox(height: 20),
  //           ElevatedButton(
  //             onPressed: () async {
  //               final SharedPreferences prefs = await _prefs;
  //               await prefs.remove('token');
  //               Get.offAllNamed('/');
  //             },
  //             child: const Text('Logout'),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _isAuthEnabled == false
                ? Column(
                    children: <Widget>[
                      const Text('Enable Biometric Authentication',
                          style: TextStyle(color: Colors.green)),
                      ElevatedButton(
                        onPressed: () async {
                          await _authenticateWithBiometrics();
                          print('Authorized: $_authorized');
                          // if (_authorized == 'Authorized') {
                          //   showModalBottomSheet(
                          //     context: context,
                          //     builder: (BuildContext context) {
                          //       return Container(
                          //         height: 500,
                          //         child: Column(
                          //           children: <Widget>[
                          //             const Text(
                          //                 'Confirm biometric authentication'),
                          //             const SizedBox(height: 20),
                          //             LoginBar(
                          //               usernameController: controllerUsername,
                          //               passwordController: controllerPassword,
                          //             ),
                          //             ElevatedButton(
                          //               onPressed: () async {
                          //                 print(
                          //                     'Username: ${controllerUsername.text}');
                          //                 print(
                          //                     'Password: ${controllerPassword.text}');
                          //                 final response = await http.post(
                          //                   Uri.parse(
                          //                       'http://10.153.82.61:3000/login/longToken'),
                          //                   body: {
                          //                     'username':
                          //                         controllerUsername.text,
                          //                     'password':
                          //                         controllerPassword.text,
                          //                   },
                          //                 );
                          //                 print('Response: ${response.body}');
                          //                 if (response.statusCode == 200) {
                          //                   print('Token: ${response.body}');
                          //                   await storage.write(
                          //                       key: 'token',
                          //                       value: response.body);
                          //                   setState(() {
                          //                     _enableAuth();
                          //                   });
                          //                   Get.back();
                          //                 } else {
                          //                   print(
                          //                       'Error: ${response.statusCode}');
                          //                 }
                          //               },
                          //               child: const Text('Login'),
                          //             ),
                          //           ],
                          //         ),
                          //       );
                          //     },
                          //   );
                          // }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          textStyle: const TextStyle(color: Colors.white),
                        ),
                        child: const Text('Enable'),
                      ),
                    ],
                  )
                : Column(
                    children: <Widget>[
                      const Text('Disable Biometric Authentication',
                          style: TextStyle(color: Colors.red)),
                      ElevatedButton(
                        onPressed: () async {
                          await _authenticateWithBiometrics();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          textStyle: const TextStyle(color: Colors.white),
                        ),
                        child: const Text('Disable'),
                      ),
                    ],
                  ),
            const SizedBox(height: 20),
            const Text('Home View'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final SharedPreferences prefs = await _prefs;
                await prefs.remove('token');
                Get.offAllNamed('/');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                textStyle: const TextStyle(color: Colors.white),
              ),
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
