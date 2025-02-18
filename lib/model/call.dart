class CallModel {
  final String? id;
  final String? callerName;
  final String? callerPic;
  final String? callerUid;
  final String? callerEmail;
  final String? receiverName;
  final String? receiverPic;
  final String? receiverUid;
  final String? receiverEmail;

  final String? type;
  final String?
      status; // Status of the call (e.g., "initiated", "ongoing", "ended")

  final String? time;
  final String? timestamp;

  CallModel(
      {this.id,
      this.callerName,
      this.callerPic,
      this.callerUid,
      this.callerEmail,
      this.receiverName,
      this.receiverPic,
      this.receiverUid,
      this.receiverEmail,
      this.status,
      this.type,
      this.time,
      this.timestamp});

  // Convert the model to a Map (useful for Firebase or other databases)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'callerName': callerName,
      'callerPic': callerPic,
      'callerUid': callerUid,
      'callerEmail': callerEmail,
      'receiverName': receiverName,
      'receiverPic': receiverPic,
      'receiverUid': receiverUid,
      'receiverEmail': receiverEmail,
      'status': status,
      'type': type,
      'time': time,
      'timestamp': timestamp
    };
  }

  // Convert the model to JSON format
  Map<String, dynamic> toJson() {
    return toMap();
  }

  // Factory method to create an instance from a Map
  factory CallModel.fromMap(Map<String, dynamic> map) {
    return CallModel(
        id: map['id'],
        callerName: map['callerName'],
        callerPic: map['callerPic'],
        callerUid: map['callerUid'],
        callerEmail: map['callerEmail'],
        receiverName: map['receiverName'],
        receiverPic: map['receiverPic'],
        receiverUid: map['receiverUid'],
        receiverEmail: map['receiverEmail'],
        status: map['status'],
        time: map['time'],
        timestamp: map['timestamp'],
        type: map['type']);
  }
  // Factory method to create an instance from JSON
  factory CallModel.fromJson(Map<String, dynamic> json) {
    return CallModel(
        id: json['id'],
        callerName: json['callerName'],
        callerPic: json['callerPic'],
        callerUid: json['callerUid'],
        callerEmail: json['callerEmail'],
        receiverName: json['receiverName'],
        receiverPic: json['receiverPic'],
        receiverUid: json['receiverUid'],
        receiverEmail: json['receiverEmail'],
        status: json['status'],
        time: json['time'],
        timestamp: json['timestamp'],
        type: json['type']);
  }
}
