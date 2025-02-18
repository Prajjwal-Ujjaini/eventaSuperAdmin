import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/data/data_provider.dart';

class ServiceTypeListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the DataState using the new dataProvider (StateNotifierProvider)
    final dataState = ref.watch(dataProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Types'),
      ),
      body: dataState.allServiceType.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: dataState.allServiceType.length,
              itemBuilder: (context, index) {
                final serviceType = dataState.allServiceType[index];
                return ListTile(
                  title: Text(serviceType.serviceTypeName ?? ''),
                );
              },
            ),
    );
  }
}
