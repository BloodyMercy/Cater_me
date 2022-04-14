import 'package:CaterMe/Payment/applepay/flutter_pay.dart';
import 'package:flutter/material.dart';
class ApplePaycaterme extends StatefulWidget {
  @override
  _ApplePaycatermeState createState() => _ApplePaycatermeState();
}

class _ApplePaycatermeState extends State<ApplePaycaterme> {
  FlutterPay flutterPay = FlutterPay();

  String result = "Result will be shown here";

  @override
  void initState() {
    super.initState();
  }

  void makePayment() async {
    List<PaymentItem> items = [PaymentItem(name: "T-Shirt", price: 2.98)];

    flutterPay.setEnvironment(environment: PaymentEnvironment.Test);

    flutterPay.requestPayment(
      googleParameters: GoogleParameters(
        gatewayName: "example",
        gatewayMerchantId: "01234567890123456789",
      ),
      appleParameters: AppleParameters(
        merchantIdentifier: "merchant.caterme.tiaragroup.com",
        merchantCapabilities: [
          MerchantCapability.threeDS,
          MerchantCapability.credit,
          MerchantCapability.debit
        ],
      ),
      currencyCode: "USD",
      countryCode: "US",
      paymentItems: items,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Container(
          padding: EdgeInsets.all(12.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  this.result,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                FlatButton(
                  child: Text("Can make payments?"),
                  onPressed: () async {
                    try {
                      bool result = await flutterPay.canMakePayments();
                      setState(() {
                        this.result = "Can make payments: $result";
                      });
                    } catch (e) {
                      setState(() {
                        this.result = "$e";
                      });
                    }
                  },
                ),
                FlatButton(
                  child: Text("Can make payments with verified card: $result"),
                  onPressed: () async {
                    try {
                      bool result =
                      await flutterPay.canMakePaymentsWithActiveCard(
                        allowedPaymentNetworks: [
                          PaymentNetwork.visa,
                          PaymentNetwork.masterCard,
                        ],
                      );
                      setState(() {
                        this.result = "$result";
                      });
                    } catch (e) {
                      setState(() {
                        this.result = "Error: $e";
                      });
                    }
                  },
                ),

                // ApplePayButton(
                //   paymentConfigurationAsset: 'default_payment_profile_apple_pay.json',
                //   paymentItems: _paymentItems,
                //   style: ApplePayButtonStyle.black,
                //   type: ApplePayButtonType.buy,
                //   margin: const EdgeInsets.only(top: 15.0),
                //   onPaymentResult: onApplePayResult,
                //   loadingIndicator: const Center(
                //     child: CircularProgressIndicator(),
                //   ),
                // ),

                FlatButton(
                    child: Text("Try to pay?"),
                    onPressed: () {
                      makePayment();
                    })
              ]),
        ),
      ),
    );
  }
}