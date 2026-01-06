import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationDetailsScreen extends StatelessWidget {
  const LocationDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Upper Town',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(
                '10 000 Zagreb',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10),
              Text('Rating:3/5'),
              SizedBox(height: 20),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam feugiat eget mi ac tincidunt. '
                'Donec finibus sapien sit amet neque maximus feugiat. '
                'Pellentesque a dictum ligula. Proin vel enim nec justo sagittis hendrerit. '
                'In at leo ante. Sed id lorem molestie, pharetra urna eu, ullamcorper sem. '
                'Aliquam tincidunt dignissim ullamcorper. In hac habitasse platea dictumst. '
                'Donec sit amet dictum arcu. Sed et lorem eget sem volutpat aliquet in vel mi. '
                'Nullam efficitur sed tortor a accumsan. Nulla convallis justo sagittis lacus',
                textAlign: TextAlign.justify,
              ),
              Spacer(),
              SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                    onPressed: () => openInMaps(45.815996, 15.973510, "Upper Town"),
                    child: Text('Show on Maps')
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void openInMaps(double latitude, double longitude, String label) async{
    try {
      Uri url = Platform.isIOS
        ? Uri.parse('maps:$latitude,$longitude?q=$latitude,$longitude')
        : Uri.parse('geo:$latitude,$longitude?q=$latitude,$longitude($label)');
      await launchUrl(url);
    }catch(e){
      print("Error happened: $e");
    }
  }
}
