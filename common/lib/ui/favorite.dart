import 'package:common/bloc/device_bloc.dart';
import 'package:common/bloc/common_bloc.dart';
import 'package:common/repository/common_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frock/flex/lifetimed_state.dart';
import 'package:frock/runtime/frock_runtime.dart';
import 'package:common/ui/favorite_ui.dart';

import 'package:flutter/material.dart';

class HFavoriteVm {
  final DeviceBloc deviceBloc;

  final FavoriteSyncBloc favoriteSyncBloc;

  HFavoriteVm._(
    Lifetime lifetime,
    this.deviceBloc,
    this.favoriteSyncBloc
  );

  factory HFavoriteVm(
      Lifetime lifetime,
      DeviceBloc deviceBloc,
      ) {
    final repository = CommonRepository(deviceBloc);
    final favoriteSyncBloc = FavoriteSyncBloc(deviceBloc, repository);

    lifetime.add(() {
      favoriteSyncBloc.close();
    });

    return HFavoriteVm._(lifetime, deviceBloc, favoriteSyncBloc);
  }

  void close() {
    favoriteSyncBloc.close();
  }
}

class HFavoriteWidget extends StatefulWidget {
  final bool isFavorite;
  final String id;
  final String url;
  final String type;

  final Color? color;

  final Color? activeColor;

  final EdgeInsetsGeometry? padding;

  final Function()? onTap;

  const HFavoriteWidget({
    Key? key,
    required this.isFavorite,
    required this.id,
    required this.url,
    required this.type,
    this.color,
    this.activeColor,
    this.padding,
    this.onTap,
  }) : super(key: key);

  @override
  _HFavoriteState createState() => _HFavoriteState();
}

class _HFavoriteState extends State<HFavoriteWidget>
    with LifetimedState<HFavoriteWidget> {

  late HFavoriteVm _vm;

  @override
  void observeWidget(Lifetime lifetime) {
    _vm = HFavoriteVm(
      lifetime,
      BlocProvider.of<DeviceBloc>(context),
    );

    _vm.favoriteSyncBloc.isActiveOptimistic = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _vm.favoriteSyncBloc,
      builder: (context, _) {
        return Padding(
          padding: _padding(),
          child: HFavorite(
            isActive: _vm.favoriteSyncBloc.isActiveOptimistic,
            onTap: _onTap,
            color: widget.color,
            activeColor: widget.activeColor,
          ),
        );
      },
    );
  }

  EdgeInsetsGeometry _padding() {
    if (widget.padding == null) {
      return EdgeInsets.only(left: 5.0, bottom: 5.0);
    }

    return widget.padding!;
  }

  void _onTap() {
    _vm.favoriteSyncBloc.sendFavorite(widget.url, widget.type, widget.id);

    if (widget.onTap != null) {
      widget.onTap!();
    }
  }
}
