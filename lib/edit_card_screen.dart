import 'package:card/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
// ignore: implementation_imports
import 'package:ndialog/src/dialogExtension.dart';

class EditCardScreen extends StatefulWidget {
  const EditCardScreen({Key? key}) : super(key: key);

  @override
  _EditCardScreenState createState() => _EditCardScreenState();
}

class _EditCardScreenState extends State<EditCardScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: const Text(
          'Edit your card',
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
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 30.0),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 220,
                          child: Stack(
                            children: [
                              Center(
                                child: LottieBuilder.network(
                                    'https://assets2.lottiefiles.com/packages/lf20_lqldefv4.json'),
                              ),
                              Center(
                                child: Container(
                                  child: const Icon(Icons.rss_feed,
                                      color: Colors.white),
                                  width: 140.0,
                                  height: 90.0,
                                  decoration: BoxDecoration(
                                      color: cardColor,
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0, bottom: 5),
                          child: Text(
                            'Card title:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextFormField(
                          cursorColor: darkGreen,
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your card title';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none),
                            fillColor: const Color(0xffF5F5F5),
                            filled: true,
                            hintText: 'Type  your card name',
                            hintStyle: const TextStyle(fontSize: 14.0),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0, bottom: 5),
                          child: Text(
                            'Link: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextFormField(
                          cursorColor: darkGreen,
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your card title';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(
                                left: 15.0,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text('https://'),
                                ],
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none),
                            fillColor: const Color(0xffF5F5F5),
                            filled: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 35.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Verify your card'),
                        ),
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(8.0))),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          backgroundColor: MaterialStateProperty.all(darkGreen),
                        ),
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              backgroundColor: Colors.white,
                              content: SizedBox(
                                height: 230,
                                child: Stack(
                                  children: [
                                    Center(
                                      child: Column(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 5.0, top: 15.0),
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: Text(
                                                'Verify your card!',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          LottieBuilder.network(
                                              'https://assets1.lottiefiles.com/packages/lf20_0akluyjw.json'),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop();
                                            },
                                            child:
                                                const Icon(Icons.clear_rounded),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ).show(context);
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                          }
                        },
                      ),
                    ),

                    // Add TextFormFields and ElevatedButton here.
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
