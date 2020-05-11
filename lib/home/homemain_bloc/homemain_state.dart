import 'package:flutterapp/model/product.dart';
import 'package:meta/meta.dart';

import '../../model/product.dart';

@immutable
class HomeMainState {
  final bool isLoaded;
  final bool isLoading;
  final List<Product> products;
  final bool hasReachedMax;
  final int pageIndex;

  bool get stateHasReachedMax => isLoaded && hasReachedMax;

  HomeMainState({
    @required this.isLoaded,
    @required this.isLoading,
    @required this.products,
    @required this.hasReachedMax,
    @required this.pageIndex,
  });

  factory HomeMainState.empty() {
    return HomeMainState(
      isLoaded: false,
      isLoading: false,
      products: null,
      hasReachedMax: false,
      pageIndex: 0,
    );
  }

  factory HomeMainState.failure() {
    return HomeMainState(
      isLoaded: false,
      isLoading: false,
      products: null,
      hasReachedMax: false,
      pageIndex: 0,
    );
  }

  HomeMainState updateLoading({
    bool isLoading,
  }) {
    return copyWith(
      isLoaded: false,
      isLoading: isLoading,
    );
  }

  HomeMainState loaedSuccess({
    List<Product> products,
    bool hasReachedMax,
    int pageIndex,
    String search,
  }) {
    return copyWith(
      isLoaded: true,
      isLoading: false,
      products: products,
      hasReachedMax: hasReachedMax,
      pageIndex: pageIndex,
    );
  }

  HomeMainState copyWith({
    bool isLoaded,
    bool isLoading,
    List<Product> products,
    bool hasReachedMax,
    int pageIndex,
  }) {
    return HomeMainState(
      isLoaded: isLoaded ?? this.isLoaded,
      isLoading: isLoading ?? this.isLoading,
      products: products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      pageIndex: pageIndex ?? this.pageIndex,
    );
  }
}
