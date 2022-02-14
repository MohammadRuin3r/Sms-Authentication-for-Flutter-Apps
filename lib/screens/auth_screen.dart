// ignore_for_file: must_be_immutable
import 'dart:math';
import 'package:auth_app/screens/home_screen.dart';
import 'package:auth_app/widgets/MyButton.dart';
import 'package:auth_app/widgets/MyTextField.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  //
  TextEditingController phoneController = TextEditingController();
  TextEditingController activeCodeController = TextEditingController();
  bool isVisibile = false;
  int code = 0;
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('احراز هویت'),
        centerTitle: true,
        leading: Icon(Icons.sms_outlined),
        backgroundColor: Colors.purple,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyTextField(
              controller: phoneController,
              errorText: '',
              hintText: 'شماره تلفن',
            ),
            SizedBox(height: 15),
            Visibility(
              visible: isVisibile,
              child: MyTextField(
                controller: activeCodeController,
                errorText: '',
                hintText: 'کد فعال سازی',
              ),
            ),
            SizedBox(height: 15),
            MyButton(
              color: Colors.purple,
              child: Text(isVisibile == false ? 'ارسال کد' : 'فعال سازی'),
              width: double.infinity,
              onPressed: () async {
                if (isVisibile == false) {
                  if (phoneController.text.isNotEmpty) {
                    setState(() {
                      isVisibile = true;
                      code = 10000 + Random().nextInt(89999);
                      Uri url = Uri.parse(
                          'https://api.kavenegar.com/v1/YOUR-TOKEN/verify/lookup.json?receptor=YOUR-PHONE-NUMBER&token=YOUR-CODE&template=YOUR-TEMPLATE');
                      http.post(url);
                    });
                  }
                } else {
                  if (activeCodeController.text == code.toString()) {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setBool('isActive', true);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
