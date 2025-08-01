class CallHistory {
  final String id;
  final String callerName;
  final String callType;
  final DateTime timestamp;
  final String duration;
  final bool isIncoming;

  CallHistory({
    required this.id,
    required this.callerName,
    required this.callType,
    required this.timestamp,
    required this.duration,
    this.isIncoming = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'callerName': callerName,
      'callType': callType,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'duration': duration,
      'isIncoming': isIncoming,
    };
  }

  factory CallHistory.fromJson(Map<String, dynamic> json) {
    return CallHistory(
      id: json['id'],
      callerName: json['callerName'],
      callType: json['callType'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(json['timestamp']),
      duration: json['duration'],
      isIncoming: json['isIncoming'] ?? false,
    );
  }
}