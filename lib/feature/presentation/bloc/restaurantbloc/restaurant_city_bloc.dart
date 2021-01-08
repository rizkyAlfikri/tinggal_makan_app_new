import 'package:bloc/bloc.dart';
import 'package:tinggal_makan_app/core/usecase/usecase.dart';
import 'package:tinggal_makan_app/feature/domain/restaurant_city.dart';
import 'package:tinggal_makan_app/feature/domain/usecase/restaurantusecase/get_restaurant_city.dart';
import 'package:tinggal_makan_app/feature/presentation/bloc/restaurantbloc/restaurant_state.dart';
import 'package:tinggal_makan_app/feature/presentation/utils/utils.dart';

class RestaurantCityBloc extends Bloc<NoParams, RestaurantState> {
  final GetRestaurantCity _getRestaurantCity;

  RestaurantCityBloc(this._getRestaurantCity);

  @override
  RestaurantState get initialState => Empty();

  @override
  Stream<RestaurantState> mapEventToState(NoParams event) async* {
    yield Loading();

    final result = await _getRestaurantCity.execute(NoParams());

    yield result.fold((failure) => Error(message: failure.mapFailureMessage()),
        (data) => HasData<List<RestaurantCity>>(data: data));
  }
}
