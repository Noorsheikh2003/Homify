import 'package:flutter/material.dart';

class AddServicePage extends StatefulWidget {
  const AddServicePage({super.key});

  @override
  State<AddServicePage> createState() => _AddServicePageState();
}

class _AddServicePageState extends State<AddServicePage> {
  // 1. ADDED NEW CONTROLLERS
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Service", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
        centerTitle: true, // Optional: centers the title
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView( // Added scroll view to prevent overflow when keyboard opens
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Service Details",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
              ),
              const SizedBox(height: 20),
              
              // SERVICE NAME FIELD
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Service Name",
                  hintText: "e.g., Electrician, Deep Cleaning",
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
                ),
              ),
              const SizedBox(height: 15),

              // 2. SHOP ADDRESS FIELD
              TextField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: "Shop Address",
                  hintText: "Street No, Building Name",
                  prefixIcon: Icon(Icons.location_on, color: Colors.teal),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),

              // 3. AREA FIELD
              TextField(
                controller: _areaController,
                decoration: const InputDecoration(
                  labelText: "Area",
                  hintText: "e.g., Gulshan-e-Iqbal, Defence",
                  prefixIcon: Icon(Icons.map, color: Colors.teal),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),

              // 4. CITY FIELD
              TextField(
                controller: _cityController,
                decoration: const InputDecoration(
                  labelText: "City",
                  hintText: "e.g., Karachi, Lahore",
                  prefixIcon: Icon(Icons.location_city, color: Colors.teal),
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () {
                  // Check if all fields are filled
                  if (_nameController.text.isNotEmpty && 
                      _addressController.text.isNotEmpty &&
                      _areaController.text.isNotEmpty &&
                      _cityController.text.isNotEmpty) {
                    
                    // Sending a Map back to the previous screen instead of just a String
                    Navigator.pop(context, {
                      "name": _nameController.text,
                      "address": _addressController.text,
                      "area": _areaController.text,
                      "city": _cityController.text,
                    });
                  } else {
                    // Simple alert if fields are empty
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please fill all fields")),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text("Save Service", style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}