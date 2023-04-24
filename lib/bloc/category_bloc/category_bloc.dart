import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repository/category_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryRepository _CategoryRepository;
  CategoryBloc(this._CategoryRepository) : super(CategoryLoading()) {
    on<CategoryEvent>((event, emit) async {
      emit(CategoryLoading());
      try{
        final data=await _CategoryRepository.FetchAllCategory();
        emit(CategoryLoadedState(data));
      }catch(e){
        emit(CategoryErrorState(e.toString()));
      }
    });
  }
}
