import 'package:flutter/material.dart';

class Main_listview extends StatefulWidget {
  const Main_listview({super.key});

  @override
  State<Main_listview> createState() => _Main_listviewState();
}

class _Main_listviewState extends State<Main_listview> {
  late List<Element> sortedElements;

  @override
  void initState() {
    super.initState();

    sortedElements = _elements..sort((a, b) => b.date.compareTo(a.date));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 680,
      child: ListView.builder(
          itemCount: sortedElements.length,
          itemBuilder: (context, index) {
            final element = sortedElements[index];

            bool showDateHeader = true;
            if (index > 0) {
              final previousElement = sortedElements[index - 1];
              if (previousElement.date.year == element.date.year &&
                  previousElement.date.month == element.date.month &&
                  previousElement.date.day == element.date.day) {
                showDateHeader = false;
              }
            }

            return Column(
              children: [
                if (showDateHeader) _getGroupSeparator(element),
                _getItem(context, element)
              ],
            );
          }),
    );
  }
}

class Element {
  DateTime date;
  String name;
  IconData icon;

  Element(this.date, this.name, this.icon);
}

List<Element> _elements = <Element>[
  Element(DateTime(2020, 6, 24, 18), 'Got to gym', Icons.fitness_center),
  Element(DateTime(2020, 6, 24, 9), 'Work', Icons.work),
  Element(DateTime(2020, 6, 25, 8), 'Buy groceries', Icons.shopping_basket),
  Element(DateTime(2020, 6, 25, 16), 'Cinema', Icons.movie),
  Element(DateTime(2020, 6, 25, 20), 'Eat', Icons.fastfood),
  Element(DateTime(2020, 6, 26, 12), 'Car wash', Icons.local_car_wash),
  Element(DateTime(2020, 6, 27, 12), 'Car wash', Icons.local_car_wash),
  Element(DateTime(2020, 6, 27, 13), 'Car wash', Icons.local_car_wash),
  Element(DateTime(2020, 6, 27, 14), 'Car wash', Icons.local_car_wash),
  Element(DateTime(2020, 6, 27, 15), 'Car wash', Icons.local_car_wash),
  Element(DateTime(2020, 6, 28, 12), 'Car wash', Icons.local_car_wash),
  Element(DateTime(2020, 6, 29, 12), 'Car wash', Icons.local_car_wash),
  Element(DateTime(2020, 6, 29, 12), 'Car wash', Icons.local_car_wash),
  Element(DateTime(2020, 6, 30, 12), 'Car wash', Icons.local_car_wash),
];

Widget _getGroupSeparator(Element element) {
  return SizedBox(
    child: Container(
      width: 120,
      child: Text(
        '${element.date.month}. ${element.date.day}',
        style: TextStyle(color: Color.fromRGBO(142, 142, 160, 1)),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Widget _getItem(BuildContext ctx, Element element) {
  return Container(
    width: double.infinity,
    child: OutlinedButton(
      onPressed: () {},
      child: ListTile(
        title: Text(
          element.name,
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}
