import 'package:bloc/bloc.dart';
import 'package:tinggal_makan_app/feature/data/source/entities/restaurant_detail_entity.dart';
import 'package:tinggal_makan_app/feature/domain/usecase/restaurantusecase/get_restaurant_detail.dart';
import 'package:tinggal_makan_app/feature/presentation/bloc/restaurantbloc/restaurant_state.dart';
import 'package:tinggal_makan_app/feature/presentation/utils/utils.dart';

class RestaurantDetailBloc extends Bloc<String, RestaurantState> {
  final GetRestaurantDetail _getRestaurantDetail;

  RestaurantDetailBloc(this._getRestaurantDetail);

  @override
  RestaurantState get initialState => Empty();

  @override
  Stream<RestaurantState> mapEventToState(String event) async* {
    yield Loading();

    final result =
        await _getRestaurantDetail.execute(event);

    yield result.fold((failure) => Error(message: failure.mapFailureMessage()),
        (data) => HasData<RestaurantDetailEntity>(data: data));
  }
}
