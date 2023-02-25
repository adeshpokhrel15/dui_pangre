import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:two_wheelers/providers/post_provider.dart';

class RandomPage extends StatelessWidget {
  const RandomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final poststream = ref.watch(postStream);
      return Scaffold(
        appBar: AppBar(
          title: const Text('Randomaa'),
        ),
        body: poststream.when(
          data: (data) {
            return ListView.builder(itemBuilder: (context, index) {
              return const ListTile(
                title: Text("hello"),
                //  subtitle: Text((data[index].citizenshipno)),

                // subtitle: Text(data[index].bikemodel),
              );
            });
          },
          error: (err, stack) => Text('$err'),
          loading: () => const CircularProgressIndicator(),
        ),
      );
    });
  }
}
