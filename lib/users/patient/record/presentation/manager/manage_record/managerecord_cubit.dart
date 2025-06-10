import 'package:canc_app/users/patient/record/data/models/recotd_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'managerecord_state.dart';

class ManagerecordCubit extends Cubit<ManagerecordState> {
  ManagerecordCubit() : super(ManagerecordInitial());
  final List<RecordModel> list1 = [];
  final List<RecordModel> list2 = [];
  final List<RecordModel> list3 = [];
  final List<RecordModel> list4 = [];
  void addRecord(RecordModel record, String type) {
    if (type == 'Scan') {
      list1.add(record);
    } else if (type == 'Lab Result') {
      list2.add(record);
    } else if (type == 'Prescription') {
      list3.add(record);
    } else {
      list4.add(record);
    }
    emit(SuccessRecordList());
  }

  void deleteRecord(String id, String type) {
    List<RecordModel> lists;
    if (type == 'Scan') {
      list1.removeWhere((record) => record.id == id);
      lists = list1;
    } else if (type == 'Lab Result') {
      list2.removeWhere((record) => record.id == id);
      lists = list2;
    } else if (type == 'Prescription') {
      list3.removeWhere((record) => record.id == id);
      lists = list3;
    } else {
      list4.removeWhere((record) => record.id == id);
      lists = list4;
    }
    if (lists.isEmpty) {
      emit(EmptyRecords());
    } else {
      emit(SuccessRecordList());
    }
  }

  void updateRecord(RecordModel record, String type) {
    if (type == 'Scan') {
      final index = list1.indexWhere((r) => r.id == record.id);
      list1[index] = record;
    } else if (type == 'Lab Result') {
      final index = list2.indexWhere((r) => r.id == record.id);
      list2[index] = record;
    } else if (type == 'Prescription') {
      final index = list3.indexWhere((r) => r.id == record.id);
      list3[index] = record;
    } else {
      final index = list4.indexWhere((r) => r.id == record.id);
      list4[index] = record;
    }
    emit(SuccessRecordList());
  }

  void initstate(String type) {
    List<RecordModel> lists;
    if (type == 'Scan') {
      lists = list1;
    } else if (type == 'Lab Result') {
      lists = list2;
    } else if (type == 'Prescription') {
      lists = list3;
    } else {
      lists = list4;
    }
    if (lists.isEmpty) {
      emit(EmptyRecords());
    } else {
      emit(SuccessRecordList());
    }
  }
}
