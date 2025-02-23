import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/data/data_provider.dart';

class ServiceTypeListScreen extends ConsumerWidget {
  const ServiceTypeListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the AsyncValue<DataState> using the new dataProviderAsync
    final dataState = ref.watch(dataProviderAsync);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Types'),
      ),
      body: dataState.when(
        data: (data) {
          // Check if the list is empty
          if (data.allServiceType.isEmpty) {
            return const Center(child: Text('No Service Types available'));
          }
          // Display the list of service types
          return ListView.builder(
            itemCount: data.allServiceType.length,
            itemBuilder: (context, index) {
              final serviceType = data.allServiceType[index];
              return ListTile(
                title: Text(serviceType.name ?? ''),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            Center(child: Text('Error: ${error.toString()}')),
      ),
    );
  }
}
