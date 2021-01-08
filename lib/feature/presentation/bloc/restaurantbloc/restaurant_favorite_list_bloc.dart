import 'package:bloc/bloc.dart';
import 'package:tinggal_makan_app/core/usecase/usecase.dart';
import 'package:tinggal_makan_app/feature/domain/restaurant.dart';
import 'package:tinggal_makan_app/feature/domain/usecase/restaurantusecase/get_favorite_restaurant_list.dart';
import 'package:tinggal_makan_app/feature/presentation/bloc/restaurantbloc/restaurant_state.dart';
import 'package:tinggal_makan_app/feature/presentation/utils/utils.dart';

class RestaurantFavoriteListBloc extends Bloc<NoParams, RestaurantState> {

  final GetFavoriteRestaurantList _getFavoriteRestaurantList;

  RestaurantFavoriteListBloc(this._getFavoriteRestaurantList);

  @override
  RestaurantState get initialState => Empty();

  @override
  Stream<RestaurantState> mapEventToState(NoParams event) async* {
    yield Loading();
    final result = await _getFavoriteRestaurantList.execute(event);
    yield result.fold((failure) => Error(message: failure.mapFailureMessage()),
            (data) =>
        (data.length < 1) ? Empty() : HasData<List<Restaurant>>(data: data));
  }
}
