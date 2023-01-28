import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motor_scheme/colors/colors.dart';
import 'package:motor_scheme/cubits/fav_cubit.dart';
import 'package:motor_scheme/models/vehicle_model.dart';
import 'parts-selection.dart';

class TypeSelection extends StatefulWidget {
  final String selectedBrand;

  const TypeSelection({
    required this.selectedBrand,
  });

  @override
  State<TypeSelection> createState() => _SelectionState();
}

class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments(this.title, this.message);
}

class _SelectionState extends State<TypeSelection> {
  List<String> years = [
    '1994',
    '1995',
    '1996',
    '1997',
    '1998',
    '1999',
    '2000',
    '2001',
    '2002',
    '2003',
    '2004',
    '2005',
    '2006',
    '2007',
    '2008',
    '2009',
    '2010',
    '2011',
    '2012',
    '2013',
    '2014',
    '2015',
    '2016',
    '2017',
    '2018',
    '2019',
    '2020',
    '2021',
    '2022',
    '2023',
  ];
  List<String> categorys = [
    'Enduro',
    'Cross',
    'Mini',
    'Adventure',
    'Naked',
  ];
  List<String> models = [
    '300 EXC',
    '250 EXC',
    '125 EXC',
    '350 EXCF',
    '450 EXCF',
  ];

  String? selectecdModel = '300 EXC';
  String? selectecdCategory = 'Enduro';
  String? selectecdYear = '2023';

  Map<String, Color> appBarColor = {
    'KTM': AppColors.ktmColor,
    'Suzuki': AppColors.suzukiColor,
    'Honda': AppColors.hondaColor,
    'Yamaha': AppColors.yamahaColor,
    'Kawasaki': AppColors.kawasakiColor
  };

  @override
  Widget build(BuildContext context) {
    final selectedBrand = widget.selectedBrand;
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
              // XD to jest piekne
              backgroundColor: appBarColor[selectedBrand],
              title: Text('WYBÓR MODELU MARKI: $selectedBrand'),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Center(
                  child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                          labelText: '01. WYBIERZ ROCZNIK:'),
                      value: selectecdYear,
                      items: years
                          .map((year) => DropdownMenuItem<String>(
                                value: year,
                                child: Text(
                                  year,
                                  style: const TextStyle(fontSize: 24),
                                ),
                              ))
                          .toList(),
                      onChanged: (item) => setState(
                            () => selectecdYear = item,
                          )),
                ),
                Center(
                  child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: '02. WYBIERZ TYP POJAZDU:',
                      ),
                      value: selectecdCategory,
                      items: categorys
                          .map((category) => DropdownMenuItem<String>(
                                value: category,
                                child: Text(
                                  category,
                                  style: const TextStyle(fontSize: 24),
                                ),
                              ))
                          .toList(),
                      onChanged: (category) => setState(
                            () => selectecdCategory = category,
                          )),
                ),
                Center(
                    child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: '03. WYBIERZ MODEL:',
                        ),
                        value: selectecdModel,
                        items: models
                            .map((model) => DropdownMenuItem<String>(
                                  value: model,
                                  child: Text(
                                    model,
                                    style: const TextStyle(fontSize: 24),
                                  ),
                                ))
                            .toList(),
                        onChanged: (model) => setState(
                              () => selectecdModel = model,
                            ))),
                const SizedBox(height: 21),
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    size: 70.0,
                    color: Colors.orange,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        settings: const RouteSettings(name: '/form'),
                        builder: (context) => PartsSelection(
                            selectedBrand: selectedBrand,
                            selectecdYear: selectecdYear!,
                            selectecdModel: selectecdModel!,
                            selectecdCategory: selectecdCategory!),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 31),
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.favorite,
                    size: 70.0,
                    color: Colors.orange,
                  ),
                  onPressed: () {
                    context.read<FavCubit>().addFavorites(VehicleModel(
                      brand: selectedBrand,
                        type: selectecdCategory!,
                        year: selectecdYear!,
                        model: selectecdModel!));
                  },
                ),
                const SizedBox(width: 21),
              ],
            )));
  }
}
