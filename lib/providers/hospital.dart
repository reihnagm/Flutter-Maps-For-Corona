import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/hospital.dart';

class Hospital extends ChangeNotifier {
  Future<List<HospitalModel>> getHospitals() async {
    http.Response response = await http.get('http://connexist.id/map/data/data_rs.php', headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    });
    List responseJson = json.decode(response.body);
    notifyListeners();
    return responseJson.map((m) => HospitalModel.fromJson(m)).toList();
  }
}