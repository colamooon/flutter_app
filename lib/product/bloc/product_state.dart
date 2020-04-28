import 'package:flutterapp/model/product.dart';
import 'package:meta/meta.dart';

@immutable
class ProductState {
  final bool isLoaded;
  final bool isLoading;
  final List<Product> products;
  final bool hasReachedMax;
  final int pageIndex;

  bool get stateHasReachedMax => isLoaded && hasReachedMax;

  ProductState({
    @required this.isLoaded,
    @required this.isLoading,
    @required this.products,
    @required this.hasReachedMax,
    @required this.pageIndex,
  });

  factory ProductState.empty() {
    return ProductState(
      isLoaded: false,
      isLoading: false,
      products: null,
      hasReachedMax: false,
      pageIndex: 0,
    );
  }

  factory ProductState.failure() {
    return ProductState(
      isLoaded: false,
      isLoading: false,
      products: null,
      hasReachedMax: false,
      pageIndex: 0,
    );
  }

  ProductState updateLoading({
    bool isLoading,
  }) {
    return copyWith(
      isLoaded: false,
      isLoading: isLoading,
    );
  }

  ProductState loaedSuccess({
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

  ProductState copyWith({
    bool isLoaded,
    bool isLoading,
    List<Product> products,
    bool hasReachedMax,
    int pageIndex,
  }) {
    return ProductState(
      isLoaded: isLoaded ?? this.isLoaded,
      isLoading: isLoading ?? this.isLoading,
      products: products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      pageIndex: pageIndex ?? this.pageIndex,
    );
  }
}
