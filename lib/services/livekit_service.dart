import 'package:get/get.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:call_app/services/api_service.dart';

class LiveKitService extends GetxService {
  Room? _room;
  LocalParticipant? _localParticipant;
  final ApiService _apiService = Get.find<ApiService>();

  var isConnected = false.obs;
  var participants = <Participant>[].obs;

  Future<bool> connect(String roomName, String participantName) async {
    try {
      String? token = await _apiService.getLivekitToken(roomName, participantName);
      if (token == null) return false;

      _room = Room();

      _room!.addListener(_onRoomUpdate);

      await _room!.connect(
        'wss://your-livekit-server.com',
        token,
        roomOptions: RoomOptions(
          adaptiveStream: true,
          dynacast: true,
        ),
      );

      _localParticipant = _room!.localParticipant;
      isConnected.value = true;

      return true;
    } catch (e) {
      print('LiveKit connection error: $e');
      return false;
    }
  }

  void _onRoomUpdate() {
    participants.value = _room?.participants.values.toList() ?? [];
  }

  Future<void> enableCamera() async {
    await _localParticipant?.setCameraEnabled(true);
  }

  Future<void> disableCamera() async {
    await _localParticipant?.setCameraEnabled(false);
  }

  Future<void> enableMicrophone() async {
    await _localParticipant?.setMicrophoneEnabled(true);
  }

  Future<void> disableMicrophone() async {
    await _localParticipant?.setMicrophoneEnabled(false);
  }

  Future<void> disconnect() async {
    await _room?.disconnect();
    _room?.removeListener(_onRoomUpdate);
    _room = null;
    _localParticipant = null;
    isConnected.value = false;
    participants.clear();
  }

  @override
  void onClose() {
    disconnect();
    super.onClose();
  }
}