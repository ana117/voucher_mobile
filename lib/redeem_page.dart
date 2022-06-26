import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:voucher_mobile/common.dart';
import 'package:http/http.dart';

class RedeemPage extends StatefulWidget {
  const RedeemPage({Key? key, required this.voucherCode}) : super(key: key);

  final String voucherCode;

  @override
  State<RedeemPage> createState() => _RedeemPageState();
}

class _RedeemPageState extends State<RedeemPage> {
  String result = "Processing...";
  String? error;

  @override
  void initState() {
    super.initState();
    _fetchVoucher();
  }

  Future<void> _fetchVoucher() async {
    String postURL = "${Common.herokuURL}/api/redeem";
    Response response = await post(
      Uri.parse(postURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'code': widget.voucherCode,
      }),
    );

    if (!mounted) return;

    if (response.statusCode == 200) {
      setState(() {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        error = jsonData['error'];
        if (error != null) {
          result = error!;
          bool isUsed = jsonData['voucher']['is_used'] ?? false;
          if (isUsed) {
            String dateTime = jsonData['voucher']['date_used'];
            DateTime dateUsed = DateTime.parse(dateTime).toLocal();
            result += " on ${dateUsed.toString().substring(0, 19)}";
            String description = jsonData['voucher']['description'];
            result += '\n\nVoucher for\n$description';
          }
        } else {
          result = 'Successfully redeemed!';
          String description = jsonData['voucher']['description'];
          result += '\n\nVoucher for\n$description';
        }
      });
    } else {
      setState(() {
        result = 'Error occurred';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Common.gray.withOpacity(0.4),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.3,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                color: Common.darkBlue,
              ),
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Common.createWhiteText(widget.voucherCode),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    Common.createWhiteText(result),
                    const Expanded(child: SizedBox()),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Common.white,
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: Common.createDarkBlueText("Back")),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
