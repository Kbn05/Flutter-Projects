import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login_mfa_app/views/viewLogin.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _isAuthEnabled == false
                ? ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _enableAuth();
                      });
                    },
                    child: const Text('Enable MFA'),
                  )
                : const SizedBox(height: 0),
            const SizedBox(height: 20),
            const Text('Home View'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final SharedPreferences prefs = await _prefs;
                await prefs.remove('token');
                Get.offAllNamed('/login');
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
