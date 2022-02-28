import 'package:flutter/material.dart';

class LicensesScreen extends StatelessWidget {
  static const routeName = '/licenses-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Пользовательское соглашение',
        ),
      ),
      body: ListView(
        children: <Widget>[
          Image.asset('assets/images/oferta.png'),
          Image.asset('assets/images/oferta1.png'),
          Image.asset('assets/images/oferta2.png'),
          Image.asset('assets/images/conf-1.png'),
          Image.asset('assets/images/conf-2.png'),
          Image.asset('assets/images/conf-3.png'),
          Image.asset('assets/images/conf-4.png'),
          Image.asset('assets/images/conf-5.png'),
          Image.asset('assets/images/conf-6.png'),
          Image.asset('assets/images/conf-7.png'),
          Image.asset('assets/images/conf-8.png'),
          Image.asset('assets/images/conf-9.png'),
        ],
      ),
    );
  }
}
