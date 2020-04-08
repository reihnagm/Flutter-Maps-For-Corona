import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/pin_pill_info.dart';
import '../models/hospital.dart';
import '../providers/hospital.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  List<Marker> _allMarkers = [];
  String _currentAddressTitle;
  String _currentAddressSnippet;
  double _latitude = 38.685516;
  double _longitude = -101.073324;
  PinInformation currentlySelectedPin = PinInformation(
    name: '', 
    address: '', 
    telephone: '', 
    latitude: 0, 
    longitude: 0
  );
  PinInformation sourcePinInfo;
  
  void _getCurrentLocation() async {
    try {
      final position = await Location().getLocation();
      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
      });
      _getAddressFromLatLng();
    } catch (error) {
      print(error); // in-development
    }
  }
  void _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(_latitude, _longitude);
      Placemark place = p[0];
      setState(() {
        _currentAddressTitle = "${place.subLocality}, ${place.locality}";
        _currentAddressSnippet = "Kode Pos ${place.postalCode}, ${place.country}";
      });
    } catch (error) {
      print(error); // in-development
    }
  }
  void _onAddMarkerButtonPressed() {
    setState(() {
      _allMarkers.add(Marker(
        markerId: MarkerId(_currentAddressTitle),
        position: LatLng(_latitude, _longitude),
        infoWindow: InfoWindow(
          title: _currentAddressTitle,
          snippet: _currentAddressSnippet
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(200),
      ));
    });
  }

  void _showModalBottom(String title, String address, String telephone, String latitude, String longitude) {
    showModalBottomSheet(
      context: context, 
      builder: (context) {
        return Container(
          color: Color(0xFF737373),
          height: 150,
          child: Container(
          padding: const EdgeInsets.all(20),
          child: _buildBottomNavigationMenu(title, address, telephone, latitude, longitude),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(30),
              topRight: const Radius.circular(30), 
            ),
          ),
        ),
      );
    }
  );
}

  _buildBottomNavigationMenu(String title, String address, String telephone, String latitude, String longitude) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: TextStyle(
              fontWeight: FontWeight.bold
          )),
          SizedBox(height: 4),
          Row(children: <Widget>[
            Text('Alamat: ', style: TextStyle(
              fontWeight: FontWeight.bold
            )),
            Text(address)
            ]
          ),
          SizedBox(height: 4),
          Row(children: <Widget>[
            Text('Telepon:', style: TextStyle(
              fontWeight: FontWeight.bold
            )),
            Text(telephone)
            ]
          ),
          SizedBox(height: 4),
          Row(children: <Widget>[
            Text('Latitude: ', style: TextStyle(
              fontWeight: FontWeight.bold
            )),
            Text(latitude)
            ]
          ),
          SizedBox(height: 4),
          Row(
            children: <Widget>[
              Text('Longitude: ', style: TextStyle(
                fontWeight: FontWeight.bold
              )),
              Text(longitude)
            ],
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  } 
  Widget button(Function function, IconData icon, String text) {
    return FloatingActionButton.extended(
            onPressed: function,
            materialTapTargetSize: MaterialTapTargetSize.padded,
            backgroundColor: Colors.lightGreen,
            label: Container(
              width: 200.0,
              child: Column(
                children: <Widget>[
                  Text(text, 
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    )
                  )
                ],
              ),
            ),
          );
  }
  @override
  Widget build(BuildContext context) {
    Completer<GoogleMapController> _controller = Completer(); 
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Container(
          child: Text('Peta Lokasi Rumah Sakit Rujukan', 
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0
            )
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
            child: Theme(
              data: Theme.of(context).copyWith(accentColor: Colors.white),
              child: Container(
                height: 48.0,
                child: Container(
                  width: 200.0,
                  height: 100.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.redAccent
                  ),
                  child: Container(
                    child: GestureDetector(
                      onTap: () {
                        launch("tel://119");
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('HOTLINE 119 Ext. 9', 
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ),
              ),
            ),
          ),
        ),
      body: FutureBuilder(
        future: Provider.of<Hospital>(context, listen: false).getHospitals(),
        builder: (context, snapshot)  {
          List<HospitalModel> hospitals = snapshot.data;   
          if(snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator() 
            );
          if(snapshot.hasError)
            return Center(
              child: Text('Oops something went wrong.')
            );
          if(snapshot.hasData)
            hospitals.map((hospital) {
              _allMarkers.add(Marker(
                markerId: MarkerId(hospital.id),
                onTap: () => _showModalBottom(hospital.namaRsu, hospital.alamat , hospital.telepon, hospital.latitude, hospital.longitude), 
                draggable: false,
                position: LatLng(
                  double.parse(hospital.latitude), 
                  double.parse(hospital.longitude)
                ),
              ));
            }).toList();

            if(_currentAddressTitle != null) {
              _allMarkers.add(Marker(
                markerId: MarkerId(_currentAddressTitle),
                position: LatLng(_latitude, _longitude),
                infoWindow: InfoWindow(
                  title: _currentAddressTitle,
                  snippet: _currentAddressSnippet
                ),
                icon: BitmapDescriptor.defaultMarkerWithHue(200),
              ));           
            }
  
            void _onMapCreated(GoogleMapController controller) { 
              _controller.complete(controller);
            }
            CameraPosition _initialLocation = CameraPosition(
              zoom: 10.0,
              target: LatLng(_latitude, _longitude)
            );
              
            return Stack( 
              children: <Widget>[
                GoogleMap(
                  initialCameraPosition: _initialLocation,
                  markers: Set.from(_allMarkers),
                  onMapCreated: _onMapCreated
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 75, right: 20),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      heroTag: "btn1",
                      backgroundColor: Colors.white,
                      child: Icon(Icons.gps_fixed),
                      onPressed: _onAddMarkerButtonPressed
                    ),
                  ),
                ),
              ],
            );
          },
        )
      );
    }
  }

