import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class FillingStation {
  //Difining the Filling Station model attributes
  String stationName;
  String address;
  String description; //type of filling station is mentioned here (Refering from google maps)
  String image; //Retriving the google map default image
  LatLng locationCodes; //Getting the lattitude and longitude values of particular location

  FillingStation(
      {required this.stationName,
      required this.address,
      required this.description,
      required this.image,
      required this.locationCodes});
}

// Assingning the list of filling station details in the model
final List<FillingStation> fillingStations = [
// 2 Filling stations were added to the list
  FillingStation(
      stationName: 'TotalEnergies Relais de Tanger',
      address: 'P4QX+X46 Tangier',
      description: 'Gas station',
      image:
          'https://lh3.googleusercontent.com/p/AF1QipORhhFfeAhP-_t069JNG60T0WakJ1-Z8nMw5ABA=s1360-w1360-h1020',
      locationCodes: LatLng(35.74004, -5.85188)),

  FillingStation(
      stationName: 'Station Service Shell Tangier',
      address: 'Q5GV+XVP Tangier',
      description: 'Fuel supplier',
      image:
          'https://lh5.googleusercontent.com/p/AF1QipM2Ye5dH0UB_l3GhXbhigtbJGSsTc0L8FJM7eue=w426-h240-k-no',
      locationCodes: LatLng(35.7774455563617, -5.805320728930108)),



];
