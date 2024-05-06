import 'package:flutter/material.dart';

class WidgetSearchBar extends StatelessWidget {
  const WidgetSearchBar({
    super.key, 
  });


@override 
Widget build (BuildContext context){
return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: SearchBar(
                controller: TextEditingController(),
                leading: const Icon(Icons.search),
                trailing: <Widget>[
                  Tooltip(
                    message: 'Busca por voz',
                    child:
                        IconButton(onPressed: () {}, icon: const Icon(Icons.mic)),
                  ),
                ],
                hintText: 'Procure um filme',
                padding: const MaterialStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16.0)),
              ),
            ),
          );
}
}
