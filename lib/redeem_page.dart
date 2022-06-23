import 'package:flutter/material.dart';
import 'package:voucher_mobile/common.dart';
import 'package:voucher_mobile/voucher.dart';

class RedeemPage extends StatefulWidget {
  const RedeemPage({Key? key, required this.voucherCode}) : super(key: key);

  final String voucherCode;

  @override
  State<RedeemPage> createState() => _RedeemPageState();
}

class _RedeemPageState extends State<RedeemPage> {
  late Future<Voucher> futureV;

  void _testDelay() {
    setState(() {
      futureV = Future.delayed(const Duration(seconds: 3), () {
        return const Voucher("KODE", "DESC", true);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _testDelay();
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
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 10.0),
                child: Column(
                  children: [
                    Common.createWhiteText(widget.voucherCode),
                    const SizedBox(height: 15),
                    FutureBuilder(
                        future: futureV,
                        builder: (context, AsyncSnapshot<Voucher> snapshot) {
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          } else {
                            Voucher data = snapshot.data!;
                            return Column(
                              children: [
                                Common.createWhiteText(
                                    "Code: ${data.code}"),
                                Common.createWhiteText(
                                    "Description: ${data.description}"),
                                Common.createWhiteText(
                                    "isUsed: ${data.status}"),
                              ],
                            );
                          }
                        }),
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
