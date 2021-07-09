import 'package:location/location.dart';

class LocationHelper {
  double latitude;
  double longitude;

  Future<void> getCurrentLocation() async {
    Location location = Location();

    bool enabledService;
    PermissionStatus permissionStatus;
    LocationData locationData;

    //Location servis kontrol
    enabledService = await location.serviceEnabled();
    if (!enabledService) enabledService = await location.requestService();

    if (!enabledService) return;

    // location izni verildimi
    permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();

      if (permissionStatus != PermissionStatus.granted) return;
    }

    //konumu al
    locationData = await location.getLocation();
    latitude = locationData.latitude;
    longitude = locationData.longitude;
  }
}
