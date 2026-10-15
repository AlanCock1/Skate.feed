import 'package:bloc/bloc.dart';
import 'package:skate_feed/features/auth/presentation/blocs/complete_profile/complete_profile_state.dart';

import '../complete_profile/complete_profile_event.dart';
import '../../../domain/usecases/complete_profile_usecase.dart';

class CompleteProfileBloc extends Bloc<CompleteProfileEvent, CompleteProfileState>{
  final CompleteProfileUseCase completeProfileUseCase;

  CompleteProfileBloc(this.completeProfileUseCase)
  : super(const CompleteProfileInitial()) {

    on<CompleteProfileSubmitted>((event, emit) async {
      emit(const CompleteProfileLoading());
      try {
        final user = await completeProfileUseCase(
          username: event.username,
          displayName: event.displayName,
          birthDate: event.birthDate,
        );
        emit(CompleteProfileSuccess(user));
        
      }catch (error) {
        emit(CompleteProfileFailure(error.toString()));
      }
    });
  }
}