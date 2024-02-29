import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_counter/assets.dart';
import 'package:flutter_bloc_counter/bloc/counter_bloc.dart';
import 'package:flutter_bloc_counter/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  bool _plusBtnPressed = false;
  bool _minusBtnPressed = false;

  Color _getColorForButton(bool buttonState) {
    return buttonState ? primaryColor : Colors.transparent;
  }

  Color _getColorForButtonText(bool buttonState) {
    return buttonState ? Colors.white : primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider<CounterBloc>(
        create: (context) => CounterBloc(),
        child: BlocBuilder<CounterBloc, int>(
          builder: (context, state) {
            final counter_bloc = BlocProvider.of<CounterBloc>(context);

            return Scaffold(
              bottomNavigationBar: NavigationBar(
                backgroundColor: primaryColor,
                destinations: const [
                  NavigationDestination(icon: Icon(Icons.home), label: "Home"),
                  NavigationDestination(
                    icon: Icon(Icons.code_outlined),
                    label: "Source code",
                  )
                ],
                onDestinationSelected: (int index) {
                  if (index == 1) {
                    launchUrl(Uri.parse(
                        "https://github.com/FussuChalice/small_flutter_projects/tree/master/flutter_bloc_counter"));
                  }
                },
              ),
              body: Container(
                constraints: const BoxConstraints.expand(),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Assets.ASSETS_BACKGROUND_JPG),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                padding: const EdgeInsets.only(
                  left: 40,
                  right: 40,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "FLUTTER_BLOC COUNTER SAMPLE",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize:
                            Theme.of(context).textTheme.bodyLarge?.fontSize,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: primaryColor,
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      height: 232,
                      child: Center(
                        child: Text(
                          state.toString(),
                          style: const TextStyle(
                            color: primaryColor,
                            fontSize: 121,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              counter_bloc.add(CounterDecrimentEvent());
                            },
                            onTapDown: (details) {
                              setState(() {
                                _minusBtnPressed = true;
                              });
                            },
                            onTapUp: (details) {
                              setState(() {
                                _minusBtnPressed = false;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: primaryColor,
                                  width: 1,
                                ),
                                color: _getColorForButton(_minusBtnPressed),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              height: 62,
                              child: Center(
                                child: Text(
                                  "-1",
                                  style: TextStyle(
                                    color: _getColorForButtonText(
                                        _minusBtnPressed),
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              counter_bloc.add(CounterIncrementEvent());
                            },
                            onTapDown: (details) {
                              setState(() {
                                _plusBtnPressed = true;
                              });
                            },
                            onTapUp: (details) {
                              setState(() {
                                _plusBtnPressed = false;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: primaryColor,
                                  width: 1,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                color: _getColorForButton(_plusBtnPressed),
                              ),
                              height: 62,
                              child: Center(
                                child: Text(
                                  "+1",
                                  style: TextStyle(
                                    color:
                                        _getColorForButtonText(_plusBtnPressed),
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
