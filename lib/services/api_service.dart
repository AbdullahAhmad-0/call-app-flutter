import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService extends GetxService {
  static const String baseUrl = 'https://voiceai.kasookoo.com/api/v1/bot';

  Future<String?> getLivekitToken(String roomName, String participantIdentity) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/sdk/get-token'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'room_name': roomName,
          'participant_identity': participantIdentity,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['token'];
      }
    } catch (e) {
      print('Error getting Livekit token: $e');
    }
    return null;
  }

  Future<bool> makeWebRTCCall(String phoneNumber, String roomName, String participantName) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/sdk-sip/calls/make'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'phone_number': phoneNumber,
          'room_name': roomName,
          'participant_name': participantName,
        }),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error making WebRTC call: $e');
      return false;
    }
  }

  Future<bool> endWebRTCCall(String participantIdentity, String roomName) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/sdk-sip/calls/end'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'participant_identity': participantIdentity,
          'room_name': roomName,
        }),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error ending WebRTC call: $e');
      return false;
    }
  }
}
