import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/feature/color/domain/entity/color_entity.dart';
import 'package:flutter_app/feature/color/domain/usecase/get_color_use_case.dart';
import 'package:flutter_app/feature/color/domain/usecase/select_color_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'color_state.dart';

class ColorCubit extends Cubit<ColorState>
{
  ColorCubit(this._selectColorUseCase, this._getColorUseCase)
    :super(const ColorCurrentState(
      color: Colors.transparent, isLoading: true))
      {
        getColor();
      }

  final SelectColorUseCase _selectColorUseCase;
  final GetColorUseCase _getColorUseCase;

  void getColor() async
  {
    emit(ColorCurrentState(color: state.color,isLoading: true));

    final result = await _getColorUseCase();

    result.fold((failure)=>emit(ColorCurrentState(
                    color: state.color, isLoading: false, 
                    error: failure.getLocalizedString())), 
                (entity)=>emit(ColorCurrentState(
                      isLoading: false,
                      color: Color(int.tryParse(entity.color)?? 0xC0C0C0,
                ))));
  }

  void setColor(Color color) async
  {
    emit(ColorCurrentState(color: state.color,isLoading: true));

    final result = await _selectColorUseCase(ColorEntity(color: color.value.toString()));

    result.fold((failure)=>emit(ColorCurrentState(
                    color: state.color,isLoading: false, 
                    error: failure.getLocalizedString())), 
                (entity)=>emit(ColorCurrentState(
                      isLoading:false,
                      color: Color(int.tryParse(entity.color)?? 0xC0C0C0,
                ))));
  }
}