sealed class GetDataState {}

final class GetDataInitial extends GetDataState {}

final class DataLoaded extends GetDataState {
  Map<String, dynamic> weatherdata;

  List? citys;
  String city;

  DataLoaded(this.weatherdata, this.city, {this.citys});
}
