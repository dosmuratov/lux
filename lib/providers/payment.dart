//import 'dart:collection';
import 'dart:convert';
//import 'dart:html';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:xml2json/xml2json.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'dart:io';

class Payment {
  final String pg_order_id;
  final String pg_merchant_id = '541946';
  final num pg_amount;
  final String pg_description = 'Lux.shop.kg';
  final String pg_salt = 'payment';
  String pg_sig = 'init_payment.php;';
  String secr_key = 'qMw1UWgDlWTxilNt';

  Payment(
    this.pg_order_id,
    this.pg_amount,
  );

  String pg_currency = 'USD';
  // String pg_check_url;
  // String pg_result_url;
  // String pg_request_method;
  // String pg_success_url;
  // String pg_failure_url;
  // String pg_success_url_method;
  // String pg_failure_url_method;
  // String pg_state_url;
  // String pg_state_url_method;
  // String pg_site_url;
  // String pg_payment_system;
  // int pg_lifetime = 777;
  // String pg_user_phone = '+9967777777777';
  // String pg_user_contact_email = 'admin@lux.shop.kg';
  // String pg_user_ip;
  // int pg_postpone_payment;
  // String pg_language;
  // int pg_testing_mode = 1;
  // int pg_user_id;
  // int pg_recurring_start = 0;
  // int pg_recurring_lifetime;
  // int count;
  // var pg_receipt_positions = {
  //   'count': 1,
  //   'name': 'Testing payment from postman',
  //   'tax_type': 0,
  //   'price': 100,
  // };
  // String name;
  // int tax_type;
  // int price;
  // String pg_param1;
  // String pg_param2;
  // String pg_param3;
  // int pg_auto_clearing;
  // int pg_payment_method;

  Future<void> payment_init() async {
    const urlPay = 'https://us-central1-lux-shop-kg.cloudfunctions.net/myfunc';
    var pmtquery = {
      'pg_order_id': pg_order_id,
      'pg_merchant_id': pg_merchant_id,
      'pg_amount': pg_amount,
      'pg_description': pg_description,
      'pg_salt': pg_salt,
      'pg_currency': pg_currency,
    };

    var signArray = pmtquery.entries.toList();
    signArray.sort((a, b) => a.key.compareTo(b.key));
    signArray.forEach((item) {
      pg_sig += item.value.toString() + ';';
    });
    pg_sig += secr_key;

    String generateMd5(String input) {
      return md5.convert(utf8.encode(input)).toString();
    }

    var query = {
      'pg_order_id': pg_order_id.toString(),
      'pg_merchant_id': pg_merchant_id,
      'pg_amount': pg_amount.toString(),
      'pg_description': pg_description,
      'pg_salt': pg_salt,
      'pg_sig': generateMd5(pg_sig),
      'pg_currency': pg_currency,
    };

    try {
      var data = json.encode(query);

      final response = await http.post(
        urlPay,
        headers: {
          'Content-Type': 'application/json',
          //'Origin': '*',
        },
        body: data,
      );
      var responseJson = json.decode(response.body);
      var responseData = responseJson["response"];

      if (responseData != null) {
        var redirectUrl = responseData["pg_redirect_url"][0];
        if (redirectUrl != null) {
          launchURL() async {
            if (await canLaunch(redirectUrl)) {
              await launch(redirectUrl);
            } else {
              throw 'Could not launch $redirectUrl';
            }
          }

          launchURL();
        }
      } else {
        return AlertDialog(
          title: Text('There is no data to send...'),
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
