import 'package:common/bloc/device_bloc.dart';
import 'package:common/utils/network_utils.dart';
import 'package:common/utils/repeatable_sync.dart';
import 'package:common/model/image_model.dart';
import 'package:common/repository/common_repository.dart';

class FavoriteSyncBloc extends RepeatableSyncBloc<bool>  {
  final DeviceBloc deviceBloc;
  final CommonRepository _repository;

  FavoriteSyncBloc(this.deviceBloc, this._repository);

  var isActiveOptimistic = false;

  Future<void> sendFavorite(String url, String type, String id) {
    isActiveOptimistic = !isActiveOptimistic;

    return applyFetch(_sendFavorite(this, url, type, id));
  }
}

class _sendFavorite implements RepeatableSyncFetch<bool> {
  final FavoriteSyncBloc _this;
  final String url;
  final String type;
  final String id;

  _sendFavorite(this._this, this.url, this.type, this.id);

  @override
  Future<bool> performSync() {
    return gaDefaultNetworkCall2(_call);
  }

  Future<bool> _call() async {
    await _this._repository.favorite(url, type, id);

    return _this.state.data ?? _this.isActiveOptimistic;
  }
}

class ImageUploadBloc extends RepeatableSyncBloc<String>  {
  final DeviceBloc deviceBloc;
  final CommonRepository _repository;

  ImageUploadBloc(this.deviceBloc, this._repository);

  String? url;

  Future<void> upload(ImageModel image) {
    return applyFetch(_uploadFetch(this, image));
  }

  Future<void> publish() {
    return applyFetch(_publishFetch(this));
  }

  Future<void> publishById(String id) {
    return applyFetch(_publishByIdFetch(this, id));
  }

  Future<void> resolve() {
    return applyFetch(_resolveFetch(this));
  }

}

class _uploadFetch implements RepeatableSyncFetch<String> {
  final ImageUploadBloc _this;
  final ImageModel image;

  _uploadFetch(this._this, this.image);

  @override
  Future<String> performSync() {
    return gaDefaultNetworkCall2(_call);
  }

  Future<String> _call() async {
    final id = await _this._repository.uploadImage(image);

    return id;
  }
}

class _publishFetch implements RepeatableSyncFetch<String> {
  final ImageUploadBloc _this;

  _publishFetch(this._this);

  @override
  Future<String> performSync() {
    return gaDefaultNetworkCall2(_call);
  }

  Future<String> _call() async {
    final id = _this.state.data ?? '';
    await _this._repository.publishImage(id);

    return id;
  }
}

class _publishByIdFetch implements RepeatableSyncFetch<String> {
  final ImageUploadBloc _this;
  final String id;

  _publishByIdFetch(this._this, this.id);

  @override
  Future<String> performSync() {
    return gaDefaultNetworkCall2(_call);
  }

  Future<String> _call() async {
    await _this._repository.publishImage(id);

    return id;
  }
}

class _resolveFetch implements RepeatableSyncFetch<String> {
  final ImageUploadBloc _this;

  _resolveFetch(this._this);

  @override
  Future<String> performSync() {
    return gaDefaultNetworkCall2(_call);
  }

  Future<String> _call() async {
    final id = _this.state.data ?? '';
    final url = await _this._repository.resolveImage(id);
    _this.url = url;

    return id;
  }
}
