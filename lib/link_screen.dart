import 'package:card/colors.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:qr_flutter/qr_flutter.dart';

class RecordEditor {
  final TextEditingController mediaTypeController = TextEditingController();
  final TextEditingController payloadController = TextEditingController();
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: const Text(
          'Your QR-Code',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        bottom: PreferredSize(
            child: Container(
              color: const Color(0xffF4F4F4),
              height: 1.0,
            ),
            preferredSize: const Size.fromHeight(4.0)),
      ),
      body: QRCode(),
    );
  }
}

class QRCode extends StatefulWidget {
  const QRCode({Key? key}) : super(key: key);

  @override
  _QRCodeState createState() => _QRCodeState();
}

class _QRCodeState extends State<QRCode> {
  final controller = TextEditingController();
  Widget buildTextField(BuildContext context) => TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  top: 7.0,
                ),
                child: const Text('https:// '),
              ),
            ],
          ),
          suffix: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => setState(() {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('QR code changed')),
                  );
                }),
                child: Container(
                  child: const Icon(
                    Icons.check_box,
                    color: darkGreen,
                    size: 25.0,
                  ),
                ),
              ),
            ],
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none),
          fillColor: const Color(0xffF5F5F5),
          filled: true,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        QrImage(
          backgroundColor: Colors.white,
          data: controller.text,
          size: 150,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 20.0,
          ),
          child: buildTextField(context),
        ),
      ],
    );
  }
}
