import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/banner_model.dart';
import '../../repository/banner_repository.dart';

part 'banner_event.dart';
part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  BannerRepository _bannerRepository;

  BannerBloc(this._bannerRepository) : super(BannerLoading()) {
    on<BannerEvent>((event, emit) async {
      emit(BannerLoading());
      try{
        final data=await _bannerRepository.getBanner();
        print(data);
        emit(BannerLoadedState(data));
      }catch(e){
        emit(BannerErrorState(e.toString()));
      }
    });
  }
}
