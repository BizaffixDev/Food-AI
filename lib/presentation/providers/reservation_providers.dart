import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodai_mobile/data/data_sources/user_local_data_source.dart';
import 'package:foodai_mobile/data/respository/dine_in_respository.dart';
import 'package:foodai_mobile/data/respository/reservation_respository.dart';
import 'package:foodai_mobile/presentation/screens/dine_in/dine_in_states.dart';
import 'package:foodai_mobile/presentation/screens/iKnowWhatIWant/i_know_states.dart';
import 'package:foodai_mobile/presentation/screens/reservation/reservation_states.dart';
import 'package:get_it/get_it.dart';

final reservationNotifyProvider =
StateNotifierProvider.autoDispose<ReservationNotifier, ReservationStates>((ref) {
  return ReservationNotifier(
    reservationRepository: GetIt.I<ReservationRepository>(),
    userLocalDataSource: GetIt.I<UserLocalDataSource>(),
    ref: ref,
  );
});

class ReservationNotifier extends StateNotifier<ReservationStates> {
  ReservationNotifier({
    required this.ref,
    required this.reservationRepository,
    required this.userLocalDataSource,
  }) : super(ReservationInitialState());

  final Ref ref;

  final ReservationRepository reservationRepository;
  final UserLocalDataSource userLocalDataSource;






}


