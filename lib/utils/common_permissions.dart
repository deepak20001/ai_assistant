import 'dart:developer' as devtools show log;
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart' as permission;

/// Get Image or Video ::
Future<XFile?> pickerImage(ImageSource imageSrc) async {
  if (Platform.isAndroid) {
    int sdk = await getSdkVersion();
    debugPrint("SDK_Version :: $sdk");
    if (sdk >= 33) {
      bool photoValue = await photoPermission();
      bool videoValue = await videoPermission();

      if (photoValue && videoValue) {
        final ImagePicker imagePicker = ImagePicker();
        final pickedFile = await imagePicker.pickImage(
          source: imageSrc,
        );

        if (pickedFile != null) {
          return pickedFile;
        } else {
          debugPrint("PERMISSION DENIED");
        }
      }
    } else {
      bool storageValue = await storagePermission();
      bool cameraValue = await cameraPermission();
      if (cameraValue && storageValue) {
        final ImagePicker imagePicker = ImagePicker();
        final pickedFile = await imagePicker.pickImage(source: imageSrc);

        if (pickedFile != null) {
          return pickedFile;
        }
      } else {
        debugPrint("PERMISSION DENIED");
        await permission.openAppSettings();
      }
    }
  } else if (Platform.isIOS) {
    bool storageValue = await storagePermission();
    bool cameraValue = await cameraPermission();
    if (cameraValue && storageValue) {
      final ImagePicker imagePicker = ImagePicker();
      final pickedFile = await imagePicker.pickImage(source: imageSrc);

      if (pickedFile != null) {
        return pickedFile;
      }
    } else {
      debugPrint("PERMISSION DENIED");
      await permission.openAppSettings();
    }
  }
  return null;
}

Future<bool> photoPermission() async {
  var status = await permission.Permission.photos.status;
  debugPrint("PhotoStatus: $status");
  switch (status) {
    case permission.PermissionStatus.denied:
      {
        var requestValue = await permission.Permission.photos.request();
        return requestValue.isDenied ? false : true;
      }

    case permission.PermissionStatus.granted:
      return true;

    case permission.PermissionStatus.restricted:
      devtools.log("Please enable storage permission");

      return false;
    case permission.PermissionStatus.permanentlyDenied:
      devtools.log("Please enable storage permission");
      permission.openAppSettings();
      return false;

    case permission.PermissionStatus.limited:
      devtools.log("Please enable storage permission");
      return false;

    default:
      return false;
  }
}

Future<bool> videoPermission() async {
  var status = await permission.Permission.videos.status;
  debugPrint("VideoStatus: $status");

  switch (status) {
    case permission.PermissionStatus.denied:
      {
        var requestValue = await permission.Permission.videos.request();
        return requestValue.isDenied ? false : true;
      }

    case permission.PermissionStatus.granted:
      return true;

    case permission.PermissionStatus.restricted:
      devtools.log("Please enable storage permission");

      return false;
    case permission.PermissionStatus.permanentlyDenied:
      devtools.log("Please enable storage permission");
      permission.openAppSettings();
      return false;

    case permission.PermissionStatus.limited:
      devtools.log("Please enable storage permission");
      return false;

    default:
      return false;
  }
}

Future<bool> storagePermission() async {
  var status = await permission.Permission.storage.status;
  switch (status) {
    case permission.PermissionStatus.denied:
      {
        var requestValue = await permission.Permission.storage.request();
        return requestValue.isDenied ? false : true;
      }
    case permission.PermissionStatus.granted:
      return true;
    case permission.PermissionStatus.restricted:
      devtools.log("Please enable storage permission");
      return false;
    case permission.PermissionStatus.permanentlyDenied:
      devtools.log("Please enable storage permission");
      permission.openAppSettings();
      return false;
    case permission.PermissionStatus.limited:
      devtools.log("Please enable storage permission");
      return false;
    default:
      return false;
  }
}

Future<bool> cameraPermission() async {
  var status = await permission.Permission.camera.status;

  switch (status) {
    case permission.PermissionStatus.denied:
      {
        var requestValue = await permission.Permission.camera.request();
        return requestValue.isDenied ? false : true;
      }
    case permission.PermissionStatus.granted:
      return true;

    case permission.PermissionStatus.restricted:
      devtools.log("Please enable camera permission");
      return false;
    case permission.PermissionStatus.permanentlyDenied:
      devtools.log("Please enable camera permission");

      permission.openAppSettings();
      return false;

    case permission.PermissionStatus.limited:
      devtools.log("Please enable camera permission");

      return false;

    default:
      return false;
  }
}

Future<bool> audioPermission() async {
  final status = await permission.Permission.microphone.status;
  switch (status) {
    case permission.PermissionStatus.denied:
      var requestValue = await permission.Permission.microphone.request();
      return requestValue.isDenied ? false : true;
    case permission.PermissionStatus.granted:
      return true;
    case permission.PermissionStatus.limited:
      devtools.log("Please enable storage permission");
      return false;
    case permission.PermissionStatus.permanentlyDenied:
      devtools.log("Please enable storage permission");
      return false;
    case permission.PermissionStatus.restricted:
      devtools.log("Please enable storage permission");
      return false;
    case permission.PermissionStatus.provisional:
      devtools.log("Please enable storage permission");
      return false;
  }
}

// get sdk version
Future<int> getSdkVersion() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  debugPrint('Running on ${androidInfo.id}');
  return androidInfo.version.sdkInt;
}
