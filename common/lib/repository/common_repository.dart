import 'dart:async';
import 'package:http/http.dart';

import 'package:common/bloc/device_bloc.dart';
import 'package:common/service/http_service.dart';
import 'package:common/utils/network_utils.dart';
import 'package:common/model/image_model.dart';

class CommonRepository {
  final DeviceBloc _deviceBloc;

  CommonRepository(this._deviceBloc);

  Future<void> favorite(String url, String type, String id) async {
    return gaDefaultNetworkCall3(_deviceBloc, (device) async {
      await HttpService.makeRequest(
        deviceModel: device,
        uri: '$url/favorite',
        httpMethod: HttpMethod.post,
        params: <String, dynamic>{
          '$type': id,
        },
      );
      return;
    });
  }

  Future<String> uploadImage(ImageModel image) async {
    return gaDefaultNetworkCall3(_deviceBloc, (device) async {
      final file = await MultipartFile.fromPath('file', image.file.path);

      final dynamic rawResult = await HttpService.makeRequest(
        deviceModel: device,
        uri: 'file/upload',
        httpMethod: HttpMethod.multipart,
        params: <String, dynamic>{
          'glType': image.glType,
          'glId': image.glId,
          'code': image.code,
        },
        file: file
      );

      final response = rawResult['result'];

      return response['id'];
    });
  }

  Future<void> publishImage(String id) async {
    return gaDefaultNetworkCall3(_deviceBloc, (device) async {
      await HttpService.makeRequest(
        deviceModel: device,
        uri: 'image/publish',
        httpMethod: HttpMethod.get,
        params: <String, dynamic>{
          'image': id,
        },
      );

      return;
    });
  }

  Future<String> resolveImage(String id) async {
    return gaDefaultNetworkCall3(_deviceBloc, (device) async {
      final dynamic rawResult = await HttpService.makeRequest(
        deviceModel: device,
        uri: 'image/resolve',
        httpMethod: HttpMethod.get,
        params: <String, dynamic>{
          'image': id,
        },
      );

      final response = rawResult['image'];

      return response['thumbnail'];
    });
  }
}