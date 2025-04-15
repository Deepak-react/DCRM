import 'package:flutter/material.dart';

class hrmam extends StatefulWidget {
  const hrmam({super.key});

  @override
  State<hrmam> createState() => _hrmamState();
}

class _hrmamState extends State<hrmam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[600],
        ),
        body: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(60.0),
                child: Container(
                  color: Colors.lightGreen[900],
                  height: 300,
                  width: 300,
                  child: Center(
                      child: Container(
                    color: Colors.white,
                    width: 200,
                    height: 200,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                  color: Colors.lightGreen,
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                  color: Colors.limeAccent,
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                            )
                          ],
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.black,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  color: Colors.cyanAccent,
                                  width: 50,
                                  height: 50,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
                )),
          ],
        ));
  }
}
