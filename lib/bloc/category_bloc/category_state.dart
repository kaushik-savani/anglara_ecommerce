part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();
}

class CategoryLoading extends CategoryState {
  @override
  List<Object> get props => [];
}

class CategoryLoadedState extends CategoryState {
  final List category;

  const CategoryLoadedState(this.category);

  @override
  List<Object> get props => [category];
}

class CategoryErrorState extends CategoryState {
  final String error;

  const CategoryErrorState(this.error);

  @override
  List<Object> get props => [error];
}
