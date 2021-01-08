import 'package:bloc/bloc.dart';
import 'package:tinggal_makan_app/feature/domain/restaurant.dart';
import 'package:tinggal_makan_app/feature/domain/usecase/restaurantusecase/get_restaurant_search.dart';
import 'package:tinggal_makan_app/feature/presentation/bloc/restaurantbloc/restaurant_state.dart';
import 'package:tinggal_makan_app/feature/presentation/utils/utils.dart';

class RestaurantSearchBloc extends Bloc<String, RestaurantState> {
  final GetRestaurantSearch _getRestaurantSearch;

  RestaurantSearchBloc(this._getRestaurantSearch);

  @override
  RestaurantState get initialState => Empty();

  @override
  Stream<RestaurantState> mapEventToState(String event) async* {
    yield Loading();

    var result = await _getRestaurantSearch.execute(event);

    yield result.fold((failure) => Error(message: failure.mapFailureMessage()),
        (data) => HasData<List<Restaurant>>(data: data));
  }
}
