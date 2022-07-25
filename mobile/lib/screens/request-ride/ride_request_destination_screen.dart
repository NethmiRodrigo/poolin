import 'dart:async';

import 'package:akar_icons_flutter/akar_icons_flutter.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile/blocs/application_bloc.dart';
import 'package:mobile/colors.dart';

import 'package:mobile/utils/widget_functions.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:provider/provider.dart';

import '../offer-ride/ride_offer_destination_screen.dart';

class RideRequestDestinationScreen extends StatefulWidget {
  const RideRequestDestinationScreen({super.key});

  @override
  RideRequestDestinationScreenState createState() {
    return RideRequestDestinationScreenState();
  }
}

class RideRequestDestinationScreenState
    extends State<RideRequestDestinationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  late StreamSubscription locationSubscription;
  final _storage = const FlutterSecureStorage();
  bool positive = false;
  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    _confirmPass.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);

    //Listen for selected location
    locationSubscription =
        applicationBloc.selectedLocation.stream.listen((place) {
      if (place != null) {
        _pass.text = place.name!;
      } else {
        _pass.text = "";
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);

    final Size size = MediaQuery.of(context).size;
    const double padding = 16;
    const sidePadding = EdgeInsets.symmetric(horizontal: padding);

    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: sidePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpace(44),
              const Align(
                  alignment: Alignment.topLeft,
                  child: Icon(
                    EvaIcons.arrowBackOutline,
                    color: Colors.black,
                  )),
              Align(
                alignment: Alignment.topRight,
                child: AnimatedToggleSwitch<bool>.dual(
                  current: positive,
                  first: false,
                  second: true,
                  dif: 5.0,
                  borderColor: Colors.black,
                  borderWidth: 1,
                  height: 35,
                  onChanged: (b) => [
                    setState(() => positive = b), //   Navigator.push(
                    Timer(Duration(milliseconds: 200), () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => RideOfferDestinationScreen()));
                    })
                  ],
                  colorBuilder: (b) => b ? Colors.black : Colors.black,
                  iconBuilder: (value) => value
                      ? const Icon(Icons.drive_eta_rounded, color: Colors.white)
                      : const Icon(Icons.airline_seat_recline_extra_rounded,
                          color: Colors.white),
                  textBuilder: (value) => value
                      ? Center(
                          child: Text(
                          'Driver',
                          style: Theme.of(context).textTheme.labelMedium,
                        ))
                      : Center(
                          child: Text(
                          'Rider',
                          style: Theme.of(context).textTheme.labelMedium,
                        )),
                ),
              ),
              Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/rider.png',
                    height: 150,
                  )),
              addVerticalSpace(24),
              Text(
                'Where are you going?',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              addVerticalSpace(8),
              Text(
                "Let's find you a ride!",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              addVerticalSpace(20),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        style: Theme.of(context).textTheme.labelLarge,
                        textAlignVertical: TextAlignVertical.center,
                        key: const Key('destination-field'),
                        controller: _pass,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(AkarIcons.search),
                          border: InputBorder.none,
                          hintText: "Where do you want to go?",
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            applicationBloc.searchPlaces(value);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              addVerticalSpace(16),
              if (applicationBloc.results != null &&
                  applicationBloc.results.isNotEmpty)
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: applicationBloc.results.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      hoverColor:
                                          Theme.of(context).backgroundColor,
                                      title: Text(
                                        applicationBloc
                                                .results[index].description ??
                                            "description",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium,
                                      ),
                                      onTap: () {
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        applicationBloc.setSelectedLocation(
                                            applicationBloc
                                                    .results[index].placeId ??
                                                "");
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
