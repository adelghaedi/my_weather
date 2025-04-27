import '../../../../core/resources/data_state.dart';
import '../../domain/entities/city_entity.dart';
import '../../domain/repositories/city_repository.dart';
import '../data_source/local/city_dao.dart';

class CityRepositoryImpl extends CityRepository {
  final CityDao cityDao;

  CityRepositoryImpl({required this.cityDao});

  @override
  Future<DataState<City>> saveCityToDB(String cityName) async {
    try {
      final City? checkCity = await cityDao.findCityByName(cityName);
      if (checkCity != null) {
        return DataError("$cityName has already exist.");
      }
      final City city = City(name: cityName);
      await cityDao.insertCity(city);
      return DataSuccess(city);
    } catch (e) {
      return DataError(e.toString());
    }
  }

  @override
  Future<DataState<List<City>>> getAllCityFromDB() async {
    try {
      final List<City> cities = await cityDao.getAllCity();
      return DataSuccess(cities);
    } catch (e) {
      return DataError(e.toString());
    }
  }

  @override
  Future<DataState<City>> findCityByName(String cityName) async {
    try {
      final City? city = await cityDao.findCityByName(cityName);
      return DataSuccess(city);
    } catch (e) {
      return DataError(e.toString());
    }
  }

  @override
  Future<DataState<String>> deleteCityByName(String cityName) async {
    try {
      await cityDao.deleteCityByName(cityName);
      return DataSuccess(cityName);
    } catch (e) {
      return DataError(e.toString());
    }
  }
}
