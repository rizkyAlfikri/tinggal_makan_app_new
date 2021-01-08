import 'package:bloc/bloc.dart';
import 'package:tinggal_makan_app/core/usecase/usecase.dart';
import 'package:tinggal_makan_app/feature/domain/restaurant.dart';
import 'package:tinggal_makan_app/feature/domain/usecase/restaurantusecase/get_restaurant_list.dart';
import 'package:tinggal_makan_app/feature/presentation/bloc/restaurantbloc/restaurant_state.dart';
import 'package:tinggal_makan_app/feature/presentation/utils/utils.dart';

class RestaurantListBloc extends Bloc<NoParams, RestaurantState> {
  final GetRestaurantList _getRestaurantList;

  RestaurantListBloc(this._getRestaurantList) : super(null);

  @override
  RestaurantState get initialState => Empty();

  @override
  Stream<RestaurantState> mapEventToState(NoParams event) async* {
    yield Loading();
    var result = await _getRestaurantList.execute(event);
    yield result.fold((failure) => Error(message: failure.mapFailureMessage()),
        (data) => HasData<List<Restaurant>>(data: data));
  }
}
