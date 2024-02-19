import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thunderapp/shared/constants/app_text_constants.dart';
import 'package:dio/dio.dart';
import '../../shared/components/dialogs/add_animal_dialog.dart';
import '../../shared/constants/style_constants.dart';
import '../screens_index.dart';

class AddAnimalRepository with ChangeNotifier {
  late int userId;
  late String userToken;
  late int biometryId;
  late int animalId;

  Future<List<String>> getBreed(specie) async {
    Dio dio = Dio();
    int i;
    List<dynamic> all;
    List<String> breeds = [];
    final prefs = await SharedPreferences.getInstance();

    userId = prefs.getInt('id')!;
    userToken = prefs.getString('token')!;

    if (specie == 'dog') {
      var response = await dio.get('$kBaseUrl/users/breed/Cachorro',
          options: Options(
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
              "Authorization": "Bearer $userToken"
            },
          ));
      all = response.data['breeds'];
      notifyListeners();

      if (all.isNotEmpty) {
        for (i = 0; i < all.length; i++) {
          breeds.add(all[i]['name']);
        }
        notifyListeners();
        return breeds;
      }
    } else {
      var response = await dio.get('$kBaseUrl/users/breed/Gato',
          options: Options(
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
              "Authorization": "Bearer $userToken"
            },
          ));
      all = response.data['breeds'];
      notifyListeners();

      if (all.isNotEmpty) {
        for (i = 0; i < all.length; i++) {
          breeds.add(all[i]['name']);
        }
        notifyListeners();
        return breeds;
      }
    }
    notifyListeners();
    return ['Falha'];
  }

  int getActivity(activityLevel) {
    if (activityLevel == 'Sedentário') {
      return 1;
    } else if (activityLevel == 'Normal') {
      return 2;
    } else {
      return 3;
    }
  }

  void registerAnimal(name, specie, breed, sex, weight, height, isCastrated,
      activityLevel, imgPath, context) async {
    Dio dio = Dio();
    final prefs = await SharedPreferences.getInstance();

    userId = prefs.getInt('id')!;
    userToken = prefs.getString('token')!;

    if (name.toString().isEmpty) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Impossível cadastrar animal (NOME)'),
                content: MaterialButton(
                  onPressed: () => Navigator.of(context).pop(),
                  color: kDetailColor,
                  child: const Text(
                    'Ok!',
                    style: TextStyle(color: kBackgroundColor),
                  ),
                ),
              ));
    } else if (breed.toString().isEmpty) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Impossível cadastrar animal (RAÇA)'),
                content: MaterialButton(
                  onPressed: () => Navigator.of(context).pop(),
                  color: kDetailColor,
                  child: const Text(
                    'Ok!',
                    style: TextStyle(color: kBackgroundColor),
                  ),
                ),
              ));
    } else if (weight.toString().isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Impossível cadastrar animal (PESO)'),
          content: MaterialButton(
            onPressed: () => Navigator.of(context).pop(),
            color: kDetailColor,
            child: const Text(
              'Ok!',
              style: TextStyle(color: kBackgroundColor),
            ),
          ),
        ),
      );
    } else if (height.toString().isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Impossível cadastrar animal (ALTURA)'),
          content: MaterialButton(
            onPressed: () => Navigator.of(context).pop(),
            color: kDetailColor,
            child: const Text(
              'Ok!',
              style: TextStyle(color: kBackgroundColor),
            ),
          ),
        ),
      );
    } else if (activityLevel.toString().isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Impossível cadastrar animal (NIVEL DE ATIVIDADE)'),
          content: MaterialButton(
            onPressed: () => Navigator.of(context).pop(),
            color: kDetailColor,
            child: const Text(
              'Ok!',
              style: TextStyle(color: kBackgroundColor),
            ),
          ),
        ),
      );
    } else if (imgPath == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Impossível cadastrar animal (IMAGEM)'),
          content: MaterialButton(
            onPressed: () => Navigator.of(context).pop(),
            color: kDetailColor,
            child: const Text(
              'Ok!',
              style: TextStyle(color: kBackgroundColor),
            ),
          ),
        ),
      );
    } else {
      final body = FormData.fromMap({
        "name": name.toString(),
        "sex": sex.toString(),
        "is_castrated": isCastrated,
        "activity_level": getActivity(activityLevel),
        "weight": weight.toString(),
        "height": height.toString(),
        "breed": breed.toString(),
        "image": await MultipartFile.fromFile(imgPath.toString(),
            filename: "image.jpg"),
      });
      try {
        var response = await dio.post(
          '$kBaseUrl/users/$userId/animals/complete',
          options: Options(
            headers: {
              "Content-Type": "multipart/form-data",
              "Authorization": "Bearer $userToken"
            },
          ),
          data: body,
        );
        showDialog(
            context: context, builder: (context) => const DialogAddAnimal());
        notifyListeners();
        if (kDebugMode) {
          print(response.statusCode);
        }
      } catch (e) {
        var errorMessage;
        if (e is DioError) {
          final dioError = e;
          if (dioError.response != null) {
            errorMessage = dioError.response!.data['errors'];
            print('Erro: $errorMessage');
            print("Erro ${e.toString()}");
          }
        }
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(
                      'Impossível cadastrar animal $errorMessage, ${e.toString()}'),
                  content: MaterialButton(
                    onPressed: () => Navigator.of(context).pop(),
                    color: kDetailColor,
                    child: const Text(
                      'Ok!',
                      style: TextStyle(color: kBackgroundColor),
                    ),
                  ),
                ));
      }
    }
    notifyListeners();
  }

  Future<bool> deleteAnimal(context, idAnimal) async {
    Dio dio = Dio();
    final prefs = await SharedPreferences.getInstance();

    userId = prefs.getInt('id')!;
    userToken = prefs.getString('token')!;

    var response = await dio.delete(
      '$kBaseUrl/users/$userId/animals/$idAnimal',
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $userToken"
        },
      ),
    );
    if (kDebugMode) {
      print(response.statusCode);
    }
    notifyListeners();
    Navigator.popAndPushNamed(context, Screens.home);

    print(response.statusCode);
    return true;
  }
}
