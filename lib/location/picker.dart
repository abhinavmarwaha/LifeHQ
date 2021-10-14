import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gps/gps.dart';
import 'package:latlong2/latlong.dart';
import 'package:lifehq/location/map.dart';
import 'package:lifehq/location/nominatim.dart';

class NominatimLocationPicker extends StatefulWidget {
  NominatimLocationPicker({
    this.searchHint = 'Search',
    this.awaitingForLocation = "Awaiting for you current location",
    this.customMarkerIcon,
    this.customMapLayer,
  });

  final String searchHint;
  final String awaitingForLocation;
  
  final TileLayerOptions? customMapLayer;

  final Widget? customMarkerIcon;

  @override
  _NominatimLocationPickerState createState() =>
      _NominatimLocationPickerState();
}

class _NominatimLocationPickerState extends State<NominatimLocationPicker> {
  Map? retorno;

  List _addresses = [];
  Color _color = Colors.black;
  TextEditingController _ctrlSearch = TextEditingController();
  GpsLatlng? _currentPosition;
  String? _desc;
  bool _isSearching = false;
  double? _lat;
  double? _lng;
  MapController _mapController = MapController();

  List<Marker>? _markers;

  LatLng? _point;

  @override
  void dispose() {
    _ctrlSearch.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _markers = [
      Marker(
        width: 50.0,
        height: 50.0,
        point: LatLng(0.0, 0.0),
        builder: (ctx) => new Container(
            child: widget.customMarkerIcon == null
                ? Icon(
                    Icons.location_on,
                    size: 50.0,
                  )
                : widget.customMarkerIcon),
      )
    ];
  }

  void _changeAppBar() {
    setState(() {
      _isSearching = !_isSearching;
    });
  }

  _getCurrentLocation() {
    Gps.currentGps().then((GpsLatlng? latlng) {
      _currentPosition = latlng;
      _getCurrentLocationMarker();
      _getCurrentLocationDesc();
    }).catchError((e) {
      print(e);
    });
  }

  _getCurrentLocationMarker() {
    setState(() {
      _lat = double.parse(_currentPosition!.lat!);
      _lng = double.parse(_currentPosition!.lng!);
      _point = LatLng(_lat!, _lng!);
      _markers![0] = Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(_lat!, _lng!),
        builder: (ctx) => new Container(
            child: widget.customMarkerIcon == null
                ? Icon(
                    Icons.location_on,
                    size: 50.0,
                  )
                : widget.customMarkerIcon),
      );
    });
  }

  _getCurrentLocationDesc() async {
    dynamic res = await NominatimService()
        .getAddressLatLng("${_currentPosition!.lat} ${_currentPosition!.lng}");
    setState(() {
      _addresses = res;
      _lat = double.parse(_currentPosition!.lat!);
      _lng = double.parse(_currentPosition!.lng!);
      _point = LatLng(_lat!, _lng!);
      retorno = {
        'latlng': _point,
        'state': _addresses[0]['state'],
        'desc':
            "${_addresses[0]['state']}, ${_addresses[0]['city']}, ${_addresses[0]['suburb']}, ${_addresses[0]['neighbourhood']}, ${_addresses[0]['road']}"
      };
      _desc = _addresses[0]['description'];
    });
  }

  onWillpop() {
    setState(() {
      _isSearching = false;
    });
  }

  _buildAppbar(bool _isResult) {
    return new AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      primary: true,
      title: _buildTextField(_isResult),
      leading: IconButton(
        icon:
            Icon(_isResult ? Icons.close : Icons.arrow_back_ios, color: _color),
        onPressed: () {
          _isSearching
              ? setState(() {
                  _isSearching = false;
                })
              : Navigator.of(context).pop();
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
          setState(() {
            _isSearching = false;
          });
        },
      ),
    );
  }

  _buildTextField(bool _isResult) {
    return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                child: TextFormField(
                    controller: _ctrlSearch,
                    decoration: InputDecoration(
                        hintText: widget.searchHint,
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey))),
              ),
            ),
            IconButton(
              icon: Icon(Icons.search, color: _color),
              onPressed: () async {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
                _isResult == false
                    ? _changeAppBar()
                    : setState(() {
                        _isSearching = true;
                      });
                dynamic res =
                    await NominatimService().getAddressLatLng(_ctrlSearch.text);
                setState(() {
                  _addresses = res;
                });
              },
            ),
          ],
        ));
  }

  Widget mapContext(BuildContext context) {
    while (_currentPosition == null) {
      return new Center(
        child: CircularProgressIndicator(),
      );
    }

    return MapPage(
      lat: _lat,
      lng: _lng,
      mapController: _mapController,
      markers: _markers,
      customMapLayer: widget.customMapLayer,
    );
  }

  Widget _buildBody(BuildContext context) {
    return new Stack(
      children: <Widget>[
        mapContext(context),
        _isSearching ? Container() : _buildDescriptionCard(),
        _isSearching ? Container() : floatingActionButton(),
        _isSearching ? searchOptions() : Text(''),
      ],
    );
  }

  Widget _buildDescriptionCard() {
    return new Positioned(
      bottom: MediaQuery.of(context).size.width * 0.05,
      right: MediaQuery.of(context).size.width * 0.05,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.15,
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 4,
                child: Row(
                  children: <Widget>[
                    Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        padding: EdgeInsets.all(15),
                        child: Center(
                            child: Scrollbar(
                                child: new SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          reverse: false,
                          child: Text(
                            _desc == null ? widget.awaitingForLocation : _desc!,
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.start,
                          ),
                        )))),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  floatingActionButton() {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return new Positioned(
      bottom: -width * 0.025 + height * 0.075,
      right: width * 0.1,
      child: Container(
        height: width * 0.15,
        width: width * 0.15,
        child: FittedBox(
          child: FloatingActionButton(
              child: Icon(Icons.arrow_forward),
              onPressed: () {
                setState(() {
                  _point = LatLng(double.parse(_currentPosition!.lat!),
                      double.parse(_currentPosition!.lng!));
                });
                Navigator.pop(context, retorno);
              }),
        ),
      ),
    );
  }

  Widget searchOptions() {
    return WillPopScope(
      onWillPop: () async => onWillpop(), //Bloquear o retorno
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 20),
          color: Colors.transparent,
          child: ListView.builder(
            itemCount: _addresses.length,
            itemBuilder: (BuildContext ctx, int index) {
              return GestureDetector(
                child: _buildLocationCard(_addresses[index]['description']),
                onTap: () {
                  _mapController.move(
                      LatLng(double.parse(_addresses[index]['lat']),
                          double.parse(_addresses[index]['lng'])),
                      19);

                  setState(() {
                    _desc = _addresses[index][
                        'description']; /*"${_addresses[index]['country']}, ${_addresses[index]['state']}, ${_addresses[index]['city']}, ${_addresses[index]['city_district']}, ${_addresses[index]['suburb']}";*/
                    _isSearching = false;
                    _lat = double.parse(_addresses[index]['lat']);
                    _lng = double.parse(_addresses[index]['lng']);
                    retorno = {
                      'latlng': LatLng(_lat!, _lng!),
                      'state': _addresses[index]['state'],
                      'desc':
                          "${_addresses[index]['state']}, ${_addresses[index]['city']}, ${_addresses[index]['suburb']}, ${_addresses[index]['neighbourhood']}, ${_addresses[index]['road']}"
                    };
                    _markers![0] = Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(double.parse(_addresses[index]['lat']),
                          double.parse(_addresses[index]['lng'])),
                      builder: (ctx) => new Container(
                          child: widget.customMarkerIcon == null
                              ? Icon(
                                  Icons.location_on,
                                  size: 50.0,
                                )
                              : widget.customMarkerIcon),
                    );
                  });
                },
              );
            },
          ),
        ),
      ),
    );
  }

  _buildLocationCard(String text) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.15,
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              //color: Colors.white,
              elevation: 0,
              child: Container(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    text,
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ))),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppbar(_isSearching),
      body: _buildBody(context),
    );
  }
}
