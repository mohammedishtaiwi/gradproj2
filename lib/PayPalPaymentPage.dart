import 'package:flutter/material.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  void initState() {
    super.initState();
    initiatePaypalCheckout();
  }

  void initiatePaypalCheckout() async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => PaypalCheckout(
        sandboxMode: true,
        clientId:
            "AadUlzccyyhSsnnnGLqAcURfiZtl_r2OHpTYchwgnjToGHf0wRt_oaj_-rEWLkI6KudgAT-ACyjjaqsR",
        secretKey:
            "EPU0Svg63XTV8-hMyU4Vqpc8QAk5s1ALrcyz2PZ2KF9qPhHFCXexgy3ZRhBmQBwc9HI1d1TE__06wzLg",
        returnURL: "success.snippetcoder.com",
        cancelURL: "cancel.snippetcoder.com",
        transactions: const [
          {
            "amount": {
              "total": '70',
              "currency": "USD",
              "details": {
                "subtotal": '70',
                "shipping": '0',
                "shipping_discount": 0
              }
            },
            "description": "The payment transaction description.",
            "item_list": {
              "items": [
                {
                  "name": "Apple",
                  "quantity": 4,
                  "price": '5',
                  "currency": "USD"
                },
                {
                  "name": "Pineapple",
                  "quantity": 5,
                  "price": '10',
                  "currency": "USD"
                }
              ],
            }
          }
        ],
        note: "Contact us for any questions on your order.",
        onSuccess: (Map params) async {
          print("onSuccess: $params");
        },
        onError: (error) {
          print("onError: $error");
          Navigator.pop(context);
        },
        onCancel: () {
          print('cancelled:');
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "PayPal Checkout",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: const Center(
        child: Text(
          'Processing PayPal Checkout...',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
