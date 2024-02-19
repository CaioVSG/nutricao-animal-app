import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thunderapp/screens/edit_animal/edit_animal_controller.dart';
import 'package:thunderapp/screens/screens_index.dart';
import 'package:thunderapp/shared/constants/app_number_constants.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';
import 'package:thunderapp/shared/core/models/animal_model.dart';

import '../../components/forms/text_field_custom.dart';
import '../../components/utils/vertical_spacer_box.dart';
import '../../shared/components/dialogs/delete_animal_dialog.dart';
import '../../shared/constants/app_enums.dart';
import '../../shared/core/models/user_model.dart';
import '../add_animal/add_animal_repository.dart';
import '../sign_in/sign_in_controller.dart';

class EditAnimalScreen extends StatefulWidget {
  final AnimalModel animal;
  const EditAnimalScreen(this.animal, {Key? key}) : super(key: key);

  static ButtonStyle styleSalvar = ElevatedButton.styleFrom(
    backgroundColor: kSecondaryColor,
  );
  static ButtonStyle styleRemover = ElevatedButton.styleFrom(
    backgroundColor: Colors.redAccent,
  );

  @override
  State<EditAnimalScreen> createState() => _EditAnimalScreenState();
}

class _EditAnimalScreenState extends State<EditAnimalScreen> {
  final SignInController signInController = SignInController();
  final UserModel user = UserModel();
  final AddAnimalRepository repository = AddAnimalRepository();

  late String userName;
  late Future<List<String>> breeds;

  int activityLevel = 1;
  int? age;
  String specie = 'Cachorro';
  String breed = 'Sem Raça Definida';
  String sex = 'male';
  bool? isCastrated;
  EditAnimalController controller = EditAnimalController();
  TextEditingController nameController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.animal.name;
    breed = widget.animal.breed;
    isCastrated = widget.animal.isCastrated;
    weightController.text = widget.animal.weight;
    heightController.text = widget.animal.height;
    specie = widget.animal.specie;
    sex = widget.animal.sex;
    breeds = repository.getBreed(specie);
    signInController.getInstance(user);
  }

  @override
  void didChangeDependencies() {
    controller = context.watch<EditAnimalController>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height;
    final widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(actions: [
        IconButton(
          icon: const Icon(Icons.account_circle_rounded),
          onPressed: () => Navigator.pushNamed(context, Screens.editProfile),
        ),
      ]),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25.0, left: 15.0),
              child: Text(
                'Editar Pet',
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  fontSize: heightScreen * kLargeSize,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            TextFieldCustom('Nome', nameController, ''),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 8),
              child: Text(
                'Espécie',
                style: TextStyle(
                    color: kSecondaryColor,
                    fontSize: heightScreen * kMediumSize),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    activeColor: kDetailColor,
                    title: Text('Cachorro',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: heightScreen * kMediumLargeSize)),
                    value: 'dog',
                    groupValue: specie,
                    onChanged: (value) {
                      setState(
                        () {
                          specie = value.toString();
                          breed = 'Sem raça definida';
                          breeds = repository.getBreed(specie);
                        },
                      );
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    activeColor: kDetailColor,
                    title: Text('Gato',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: heightScreen * kMediumLargeSize)),
                    value: 'cat',
                    groupValue: specie,
                    onChanged: (value) {
                      setState(
                        () {
                          specie = value.toString();
                          breed = 'Sem raça definida';
                          breeds = repository.getBreed(specie);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 8),
              child: Text(
                'Raça',
                style: TextStyle(
                    color: kSecondaryColor,
                    fontSize: heightScreen * kMediumSize),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
              child: DropdownSearch<String>(
                selectedItem: breed,
                popupProps: const PopupProps.dialog(
                  showSearchBox: true,
                ),
                dropdownButtonProps: const DropdownButtonProps(
                  icon: Icon(
                    Icons.arrow_circle_down_outlined,
                    color: kDetailColor,
                    size: 35,
                  ),
                ),
                asyncItems: (String specie) => breeds,
                onChanged: (data) {
                  setState(
                    () {
                      breed = data.toString();
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 8),
              child: Text(
                'Sexo',
                style: TextStyle(
                    color: kSecondaryColor,
                    fontSize: heightScreen * kMediumSize),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    child: RadioListTile(
                      activeColor: kDetailColor,
                      title: Text(
                        'Macho',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: heightScreen * kMediumLargeSize),
                      ),
                      value: 'Macho',
                      groupValue: sex,
                      onChanged: (value) {
                        setState(
                          () {
                            sex = value.toString();
                          },
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    activeColor: kDetailColor,
                    title: Text('Fêmea',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: heightScreen * kMediumLargeSize)),
                    value: 'Fêmea',
                    groupValue: sex,
                    onChanged: (value) {
                      setState(
                        () {
                          sex = value.toString();
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: DecimalTextFieldCustom('Peso (Quilograma)', weightController, ''),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child:
                  TextFieldCustom('Medida (Centímetros)', heightController, ''),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child:
                  TextFieldCustomDate('Data de Nascimento', ageController, age),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 8),
              child: Text(
                'Seu animal é castrado(a)?',
                style: TextStyle(
                    color: kSecondaryColor,
                    fontSize: heightScreen * kMediumSize),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    activeColor: kDetailColor,
                    title: Text('Sim',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: heightScreen * kMediumLargeSize)),
                    value: true,
                    groupValue: isCastrated,
                    onChanged: (value) {
                      setState(
                        () {
                          isCastrated = true;
                        },
                      );
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    activeColor: kDetailColor,
                    title: Text('Não',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: heightScreen * kMediumLargeSize)),
                    value: false,
                    groupValue: isCastrated,
                    onChanged: (value) {
                      setState(
                        () {
                          repository.getBreed(specie);
                          isCastrated = false;
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 8),
              child: Text(
                'Nível de Atividade',
                style: TextStyle(
                    color: kSecondaryColor,
                    fontSize: heightScreen * kMediumSize),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, right: 16, left: 16),
              child: DropdownSearch(
                dropdownButtonProps: const DropdownButtonProps(
                  icon: Icon(
                    Icons.arrow_circle_down_outlined,
                    color: kDetailColor,
                    size: 35,
                  ),
                ),
                items: const [1, 2, 3],
                onChanged: (data) {
                  setState(() {
                    activityLevel = data as int;
                  });
                },
              ),
            ),
            const VerticalSpacerBox(size: SpacerSize.medium),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 10),
              child: Center(
                child: SizedBox(
                  width: widthScreen * 0.55,
                  child: Row(
                    children: [
                      Center(
                        child: ElevatedButton(
                          style: EditAnimalScreen.styleSalvar,
                          child: Text('Atualizar',
                              style: TextStyle(
                                  color: kBackgroundColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: heightScreen * kMediumLargeSize)),
                          onPressed: () {
                            EditAnimalController().editAnimal(
                              widget.animal.id,
                              nameController.text,
                              sex,
                              isCastrated,
                              weightController.text,
                              heightController.text,
                              specie,
                              context,
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: ElevatedButton(
                          style: EditAnimalScreen.styleRemover,
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) =>
                                    DeleteAnimalDialog(widget.animal.id));
                          },
                          child: Text("Remover",
                              style: TextStyle(
                                  color: kBackgroundColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: heightScreen * kMediumLargeSize)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const VerticalSpacerBox(size: SpacerSize.medium),
          ],
        ),
      ),
    );
  }
}
