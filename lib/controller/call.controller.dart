import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_chat/model/call.dart';
import 'package:my_chat/model/user.dart';
import 'package:my_chat/pages/call/audio.call.dart';
import 'package:my_chat/pages/call/video.call.dart';
import 'package:uuid/uuid.dart';

class CallController extends GetxController {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final uuid = Uuid().v6();

  @override
  void onInit() {
    super.onInit();
    getCallNotification().listen((List<CallModel> callList) {
      if (callList.isNotEmpty) {
        Get.snackbar("calling", "calling");
        var callData = callList[0];

        if (callData.type == "audio") {
          audioCallNotification(callData);
        } else if (callData.type == "video") {
          videoCallNotification(callData);
        }
      }
    });
  }

  Future<void> callAnyOne(
      UserModel receiver, UserModel caller, String type) async {
    DateTime timestamp = DateTime.now();
    String nowTime = DateFormat('hh:mm a').format(timestamp);

    var newCall = CallModel(
        id: uuid,
        callerName: caller.name,
        callerEmail: caller.email,
        callerPic: caller.userProfileUrl,
        callerUid: caller.id,
        receiverEmail: receiver.email,
        receiverName: receiver.name,
        receiverPic: receiver.userProfileUrl,
        receiverUid: receiver.id,
        status: "dialing",
        time: nowTime,
        timestamp: FieldValue.serverTimestamp().toString(),
        type: type);

    try {
      await db
          .collection("notification")
          .doc(receiver.id)
          .collection("calls")
          .doc(uuid)
          .set(newCall.toJson());
      await db
          .collection("users")
          .doc(receiver.id)
          .collection("calls")
          .doc(uuid)
          .set(newCall.toJson());
      await db
          .collection("users")
          .doc(caller.id)
          .collection("calls")
          .doc(uuid)
          .set(newCall.toJson());
      Future.delayed(Duration(seconds: 5), () {
        endCall(newCall);
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Stream<List<CallModel>> getCallNotification() {
    return db
        .collection("notification")
        .doc(auth.currentUser!.uid)
        .collection("calls")
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CallModel.fromJson(doc.data()))
            .toList());
  }

  Future<void> endCall(CallModel call) async {
    try {
      await db
          .collection("notification")
          .doc(call.receiverUid) // Use the receiver's UID from the call data
          .collection("calls")
          .doc(uuid)
          .delete();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> audioCallNotification(CallModel callData) async {
    Get.snackbar(
      icon: Icon(Icons.call),
      barBlur: 0,
      isDismissible: false,
      backgroundColor: Colors.grey,
      duration: Duration(days: 1),
      onTap: (snack) {
        Get.back();
        Get.to(AudioCallScreen(
            target: UserModel(
                id: callData.callerUid,
                name: callData.callerName,
                email: callData.callerEmail,
                userProfileUrl: callData.callerPic)));
      },
      callData.callerName!,
      "Incoming Call",
      mainButton: TextButton(
          onPressed: () {
            endCall(callData);
            Get.back();
          },
          child: Text("End Call")),
    );
  }

  Future<void> videoCallNotification(CallModel callData) async {
    Get.snackbar(
      icon: Icon(Icons.video_call),
      barBlur: 0,
      isDismissible: false,
      backgroundColor: Colors.grey,
      duration: Duration(days: 1),
      onTap: (snack) {
        Get.back();
        Get.to(VideoCallScreen(
            target: UserModel(
                id: callData.callerUid,
                name: callData.callerName,
                email: callData.callerEmail,
                userProfileUrl: callData.callerPic)));
      },
      callData.callerName!,
      "Incoming Call",
      mainButton: TextButton(
          onPressed: () {
            endCall(callData);
            Get.back();
          },
          child: Text("End Call")),
    );
  }
}
