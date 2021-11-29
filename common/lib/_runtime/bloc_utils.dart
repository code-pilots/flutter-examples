import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frock/runtime/frock_runtime.dart';

class ValueCubit<T> extends Cubit<T> {
  ValueCubit(T state) : super(state);

  ValueCubit.lifetimed(Lifetime lifetime, T state) : super(state) {
    lifetime.add(() {
      close();
    });
  }

  set state(T value) {
    emit(value);
  }
}
