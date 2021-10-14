import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../../size_config.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  var cor;
  var addresses = '';
  var first;
  List<Placemark> placemarks;
  Future<List> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }
    cor = await Geolocator.getCurrentPosition();

    placemarks = await placemarkFromCoordinates(cor.latitude, cor.longitude);

    var t = 0;
    for (var item in placemarks) {
      print(item.street.toString());
      if (item.street.toString() != null &&
          item.street.toString().length > 0 &&
          t != 0) {
        addresses += item.street.toString() + ', ';
      }
      t++;
    }

    return [placemarks[0].street.toString(), addresses];
  }

  var loading = true;
  var add;
  @override
  void initState() {
    super.initState();
    _determinePosition().then((value) {
      setState(() {
        add = value;
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              children: [
                Icon(Icons.location_on_outlined),
                loading == false
                    ? Text(
                        add[0],
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      )
                    : Text(
                        'Locating...',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
              ],
            ),
          ),
          loading == false
              ? Container(
                  child: Text(
                    add[1].toString().length > 25
                        ? add[1].toString().substring(0, 25) + '...'
                        : add[1].toString(),
                    textAlign: TextAlign.start,
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
