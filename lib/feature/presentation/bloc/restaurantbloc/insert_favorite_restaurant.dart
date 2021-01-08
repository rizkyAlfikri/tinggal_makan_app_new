import 'package:bloc/bloc.dart';
import 'package:tinggal_makan_app/feature/domain/restaurant.dart';
import 'package:tinggal_makan_app/feature/domain/usecase/restaurantusecase/insert_favorite_restaurant.dart';
import 'package:tinggal_makan_app/feature/presentation/bloc/restaurantbloc/restaurant_state.dart';

class InsertFavoriteRestaurantBloc extends Bloc<Restaurant, RestaurantState> {
  final InsertFavoriteRestaurant _insertFavoriteRestaurant;

  InsertFavoriteRestaurantBloc(this._insertFavoriteRestaurant);

  @override
  RestaurantState get initialState => Empty();

  @override
  Stream<RestaurantState> mapEventToState(Restaurant event) async* {
    _insertFavoriteRestaurant.execute(event);
  }
}
