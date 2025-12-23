import 'package:flutter/material.dart';
import 'add_service_page.dart';

class ServiceManagementPage extends StatefulWidget {
  const ServiceManagementPage({super.key});

  @override
  State<ServiceManagementPage> createState() => _ServiceManagementPageState();
}

class _ServiceManagementPageState extends State<ServiceManagementPage> {
  List<Map<String, dynamic>> _myServices = [];

  // Logic to navigate and add a NEW service
  void _navigateAndAddService() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddServicePage()),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        _myServices.add(result);
      });
    }
  }

  // Logic to DELETE a service
  void _deleteService(int index) {
    setState(() {
      _myServices.removeAt(index);
    });
  }

  // UPDATED: Logic to View and then UPDATE an existing service
  void _viewServiceDetails(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddServicePage(
          existingService: _myServices[index],
          isReadOnly: true, 
        ),
      ),
    );

    // This block runs after you "Pop" back from AddServicePage
    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        // IMPORTANT: We overwrite the data at the exact index
        _myServices[index] = result; 
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Service updated successfully!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Services", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.teal.withOpacity(0.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Your Active Services",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
                ),
                IconButton.filled(
                  onPressed: _navigateAndAddService,
                  icon: const Icon(Icons.add),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: _myServices.isEmpty
                ? const Center(child: Text("No services added yet."))
                : ListView.builder(
                    itemCount: _myServices.length,
                    itemBuilder: (context, index) {
                      final service = _myServices[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        child: ListTile(
                          onTap: () => _viewServiceDetails(index),
                          leading: const Icon(Icons.handyman, color: Colors.teal),
                          title: Text(service['name'] ?? 'Unknown Service', 
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text("${service['area']}, ${service['city']}"),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_outline, color: Colors.red),
                            onPressed: () => _deleteService(index),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}