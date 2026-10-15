import 'package:equatable/equatable.dart';

abstract class CompleteProfileEvent extends Equatable{
  const CompleteProfileEvent();

  @override
  List<Object?> get props => [];
}

class CompleteProfileSubmitted extends CompleteProfileEvent{
  final String username;
  final String displayName;
  final DateTime birthDate;

  const CompleteProfileSubmitted({
    required this.username,
    required this.displayName,
    required this.birthDate,
  });

  @override
  List<Object?> get props => [
    username, 
    displayName, 
    birthDate
  ];
}

