part of 'banner_bloc.dart';

abstract class BannerState extends Equatable {
  const BannerState();
}

class BannerLoading extends BannerState {
  @override
  List<Object> get props => [];
}

class BannerLoadedState extends BannerState {
  final List<BannerModel> banner;

  const BannerLoadedState(this.banner);

  @override
  List<Object> get props => [banner];
}

class BannerErrorState extends BannerState {
  final String error;

  const BannerErrorState(this.error);

  @override
  List<Object> get props => [error];
}
