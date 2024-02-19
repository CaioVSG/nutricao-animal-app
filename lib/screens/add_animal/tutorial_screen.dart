import 'package:flutter/material.dart';

class TutorialScreen extends StatelessWidget {
  const TutorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            Image(
              image: AssetImage('lib/assets/images/tutorial.jpeg'),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: SizedBox(
                child: Text(
                  'Fonte: Muller et al., 2008\nA fita métrica deverá ser posicionada na extensão entre a base da nuca (articulação atlanto-occipital) e estendida até encontrar o solo, imediatamente atrás dos membros posteriores, passando e apoiando a fita sobre a base da cauda (última vértebra sacral).',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
