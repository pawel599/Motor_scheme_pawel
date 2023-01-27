import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motor_scheme/cubits/fav_cubit.dart';
import 'package:motor_scheme/selections/parts-selection.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavCubit, FavInitial>(
      builder: (context, state) {
        if (state.vehicleData!.isEmpty) {
          return const Center(
            child: Text('EMPTY FAV'),
          );
        }
        print(state.vehicleData);
        return ListView.builder(
            itemCount: state.vehicleData!.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Text("ROCZNIK : ${state.vehicleData![index].year}"),
                  Text("TYP POJAZDU : ${state.vehicleData![index].type}"),
                  Text("MODEL : ${state.vehicleData![index].model}"),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            settings: const RouteSettings(name: '/form'),
                            builder: (context) => PartsSelection(
                                selectedBrand: state.vehicleData![index].brand,
                                selectecdYear: state.vehicleData![index].year,
                                selectecdModel: state.vehicleData![index].model,
                                selectecdCategory: state.vehicleData![index].type),
                          ),
                        );
                      },
                      child: const Icon(Icons.arrow_circle_right_outlined,size: 50,))
                ],
              );
            });
      },
    );
  }
}
