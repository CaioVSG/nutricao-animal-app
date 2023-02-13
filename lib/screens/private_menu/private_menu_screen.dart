import 'package:flutter/material.dart';

import 'package:thunderapp/screens/screens_index.dart';
import 'package:thunderapp/shared/constants/app_number_constants.dart';

import 'package:thunderapp/shared/constants/style_constants.dart';

class PrivateMenuScreen extends StatefulWidget {
  const PrivateMenuScreen({Key? key}) : super(key: key);

  @override
  State<PrivateMenuScreen> createState() => _PrivateMenuScreenState();
}

class _PrivateMenuScreenState extends State<PrivateMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(actions: [
        IconButton(
          icon: const Icon(Icons.account_circle_rounded),
          onPressed: () => Navigator.pushNamed(context, Screens.user),
        ),
      ]),
      body: ListView(
        children: const [
          Padding(
            padding: EdgeInsets.only(top: 16, left: 16),
            child: Text(
              'Cardápio particular',
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: kHugeSize,
                  fontWeight: FontWeight.w900),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, bottom: 16),
            child: Text(
              'Name',
              style: TextStyle(color: kSecondaryColor, fontSize: kMediumSize),
            ),
          ),
          CardMenu(),
          CardMenu(),
          CardMenu(),
          CardMenu(),
          CardMenu(),
          CardMenu(),
          CardMenu(),
          CardMenu(),
          CardMenu(),
          CardMenu(),
          CardMenu(),
        ],
      ),
      floatingActionButton: SizedBox(
        width: 100,
        height: 100,
        child: FloatingActionButton(
          heroTag: 'Add1',
          onPressed: () {},
          backgroundColor: kSecondaryColor,
          child: const Icon(
            Icons.add,
            size: 65,
            color: kBackgroundColor,
          ),
        ),
      ),
    );
  }
}

class CardMenu extends StatelessWidget {
  const CardMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, Screens.foodDetails),
      child: Ink(
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
          child: SizedBox(
            height: 90,
            child: Card(
              color: kBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  ListTile(
                    title: Padding(
                      padding: EdgeInsets.only(top: 12),
                      child: Text(
                        'Food - Amount',
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: kMediumLargeSize,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    subtitle: Text(
                      'Type',
                      style: TextStyle(
                          color: kSecondaryColor, fontSize: kMediumSize),
                    ),
                    trailing: Padding(
                      padding: EdgeInsets.only(top: 12),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: kDetailColor,
                        size: 30,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
