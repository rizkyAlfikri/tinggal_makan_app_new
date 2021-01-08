import 'package:bloc/bloc.dart';
import 'package:tinggal_makan_app/feature/domain/usecase/restaurantusecase/delete_favorite_restaurant.dart';
import 'package:tinggal_makan_app/feature/presentation/bloc/restaurantbloc/restaurant_state.dart';

class DeleteFavoriteRestaurantBloc extends Bloc<String, RestaurantState> {
  final DeleteFavoriteRestaurant _deleteFavoriteRestaurant;

  DeleteFavoriteRestaurantBloc(this._deleteFavoriteRestaurant);

  @override
  RestaurantState get initialState => Empty();

  @override
  Stream<RestaurantState> mapEventToState(String event) async* {
    await _deleteFavoriteRestaurant.execute(event);
  }
}
