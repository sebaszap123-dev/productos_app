import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyB3AfvWvJDVHTD4elXm97xJCBezj8tn3fo';
  final String _endpintURLCreate = '/v1/accounts:signUp';
  final String _endpintURLLogin = '/v1/accounts:signInWithPassword';

  final storage = FlutterSecureStorage();

  // Si retornamos null es correcto de lo contrario se regresa un error
  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    final url = Uri.https(_baseUrl, _endpintURLCreate, {'key': _firebaseToken});
    final response = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodeResponse = json.decode(response.body);
    if (decodeResponse.containsKey('idToken')) {
      // TODO: Guardarlo en un lugar seguro
      // await storage.write(key: 'token', value: decodeResponse['idToken']);
      return null;
    } else {
      return decodeResponse['error']['message'];
    }
  }

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    final url = Uri.https(_baseUrl, _endpintURLLogin, {'key': _firebaseToken});
    final response = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodeResponse = json.decode(response.body);
    if (decodeResponse.containsKey('idToken')) {
      // TODO: Guardarlo en un lugar seguro
      await storage.write(key: 'token', value: decodeResponse['idToken']);
      return null;
    } else {
      return decodeResponse['error']['message'];
    }
  }

  Future logOut() async {
    await storage.delete(key: 'token');
    return;
  }

  Future<String> isAuth() async {
    return await storage.read(key: 'token') ?? '';
  }
}
