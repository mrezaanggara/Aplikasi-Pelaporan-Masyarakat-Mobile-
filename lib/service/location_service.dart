import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService{
  Future<String> getCoordinate() async {
    // memilih gps yang akurat
    Position position = await Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    var address = placemarks[0].street+", "+placemarks[0].subLocality+", "+placemarks[0].locality+", "+placemarks[0].subAdministrativeArea+", "+placemarks[0].administrativeArea+", "+placemarks[0].postalCode+", "+placemarks[0].country;
    return address.toString();
    //return placemarks.toString();
  }

  getLat() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final coordinate = position.latitude;
    var latitude = coordinate;
    return latitude;
  }

  getLong() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final coordinate = position.longitude;
    var longitude = coordinate;
    return longitude;
  }
}