import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:login_bio_app/widgets/login.dart';
import 'dart:convert' as convert;
import 'package:login_bio_app/widgets/productList.dart';
import 'package:login_bio_app/widgets/ratingWidget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController controllerUsername = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final LocalAuthentication auth = LocalAuthentication();
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  bool? _isAuthEnabled;
  bool? _prodCategory;

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
    _viewCategory();
  }

  Future<void> _checkAuthStatus() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      _isAuthEnabled = prefs.getBool('enAuth') ?? false;
    });
  }

  Future<void> _viewCategory() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      _prodCategory = prefs.getBool('off') ?? false;
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
                      Uri.parse('http://10.153.82.75:3000/login/longToken'),
                      headers: {
                        'Authorization': 'Bearer $token',
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
  }

  Future<List> fetchOffers() async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');
    final response = await http
        .get(Uri.parse('http://10.153.82.75:3000/products/prod'), headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);

      final filteredData =
          jsonResponse.where((articulo) => articulo['discount'] != 0).toList();
      return filteredData;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List> fetchProducts() async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');
    final response = await http
        .get(Uri.parse('http://10.153.82.75:3000/products/prod'), headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse;
    } else {
      throw Exception('Failed to load data');
    }
  }

  double calculateRatingPercentage(int rate) {
    return (rate / 50) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            IconButton(
              icon: const Icon(Icons.fingerprint),
              color: _isAuthEnabled == true ? Colors.green : Colors.grey,
              onPressed: () async {
                await _authenticateWithBiometrics();
              },
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                final SharedPreferences prefs = await _prefs;
                await prefs.remove('token');
                Get.offAllNamed('/');
              },
            ),
          ],
        ),
        body: FutureBuilder<List>(
          future: _prodCategory == true ? fetchOffers() : fetchProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final rate = int.parse(snapshot.data![index]['rate']);
                      final ratingPercentage = calculateRatingPercentage(rate);
                      final numberOfStars =
                          (ratingPercentage / 100 * 5).toInt();
                      return ProdList(
                        image: snapshot.data![index]['image'],
                        name: snapshot.data![index]['name'],
                        discount: snapshot.data![index]['discount'] > 0
                            ? '${snapshot.data![index]['discount']}% OFF'
                            : '0',
                        price: snapshot.data![index]['discount'] > 0
                            ? ((int.parse(snapshot.data![index]['price']) -
                                    (int.parse(snapshot.data![index]['price']) *
                                            snapshot.data![index]['discount']) /
                                        100))
                                .round()
                                .toString()
                            : snapshot.data![index]['price'],
                        priceBefore: snapshot.data![index]['price'],
                        rate: (double.parse(snapshot.data![index]['rate']) / 10)
                            .toString(),
                        score: snapshot.data![index]['score'],
                        rating: RatingWidget(numberOfStars: numberOfStars),
                      );
                    },
                  ),
                );
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.production_quantity_limits),
              label: 'Products',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_offer_rounded),
              label: 'Offers',
            ),
          ],
          currentIndex: _prodCategory == true ? 1 : 0,
          onTap: (index) {
            setState(() {
              _prodCategory = index == 1 ? true : false;
            });
          },
        ));
  }
}
