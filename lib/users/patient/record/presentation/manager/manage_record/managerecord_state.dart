part of 'managerecord_cubit.dart';

sealed class ManagerecordState {
  const ManagerecordState();
}

final class ManagerecordInitial extends ManagerecordState {}

final class SuccessRecordList extends ManagerecordState {}

final class EmptyRecords extends ManagerecordState {}
