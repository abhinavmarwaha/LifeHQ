import 'package:http/http.dart' as http;
import 'dart:convert';

class NominatimService {
  Future<List<Map>> getAddressLatLng(String address) async {
    var url =
        "https://nominatim.openstreetmap.org/search?q=${address.replaceAll(RegExp(' '), '+')}&format=json&addressdetails=1";
    var response = await http.get(Uri.parse(url));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    List addresses = jsonDecode(response.body);
    List<Map> share = [];
    for (Map ad in addresses) {
      share.add({
        'lat': ad['lat'],
        'lng': ad['lon'],
        'description': ad['display_name'],
        'state': ad['address']['state'] == null ? "na" : ad['address']['state'],
        'city': ad['address']['city'] == null ? "na" : ad['address']['city'],
        'suburb':
            ad['address']['suburb'] == null ? "na" : ad['address']['suburb'],
        'neighbourhood': ad['address']['neighbourhood'] == null
            ? "na"
            : ad['address']['neighbourhood'],
        'road': ad['address']['road'] == null ? "na" : ad['address']['road'],
      });
    }

    return share;
  }
}
