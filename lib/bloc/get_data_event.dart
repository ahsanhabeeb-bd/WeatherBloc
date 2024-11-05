sealed class GetDataEvent {}

final class InitEvent extends GetDataEvent {
  final String city;

  InitEvent(this.city);
}
