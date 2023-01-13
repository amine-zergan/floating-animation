import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 141, 205, 255),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Spacer(
              flex: 5,
            ),
            FloatingActionButton(
              backgroundColor: Colors.white,
              elevation: 0,
              onPressed: () {
                Get.back(result: 40.0);
              },
              child: const Icon(Icons.close,
                  color: Color.fromARGB(255, 125, 195, 249)),
            ),
            const SizedBox(
              height: 50,
            ),
            MaterialButton(
              onPressed: () {},
              height: size.height * 0.06,
              child: Text(
                "Reminder",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.white),
              ),
            ),
            MaterialButton(
              onPressed: () {},
              height: size.height * 0.06,
              child: Text(
                "Camera",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.white),
              ),
            ),
            MaterialButton(
              onPressed: () {},
              height: size.height * 0.06,
              elevation: 0,
              child: Text(
                "Attachment",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.white),
              ),
            ),
            MaterialButton(
              onPressed: () {},
              height: size.height * 0.06,
              child: Text(
                "Text Note",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.white),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
