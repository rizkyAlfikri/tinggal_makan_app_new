import 'package:bloc/bloc.dart';
import 'package:tinggal_makan_app/feature/domain/restaurant.dart';
import 'package:tinggal_makan_app/feature/domain/usecase/restaurantusecase/get_favorite_restaurant_by_id.dart';

class RestaurantFavoriteByIdBloc extends Bloc<String, Restaurant>{

  final GetFavoriteRestaurantById _getFavoriteRestaurantById;

  RestaurantFavoriteByIdBloc(this._getFavoriteRestaurantById);

  @override
  Restaurant get initialState => create();

  @override
  Stream<Restaurant> mapEventToState(String event) async* {
    final result = await _getFavoriteRestaurantById.execute(event);
    yield result.fold((failure) => create(),
            (data) => data);
  }
}

Restaurant create () => Restaurant(
id: "",
name: "",
description: "",
pictureId: "",
city: "",
rating: 0,
);
