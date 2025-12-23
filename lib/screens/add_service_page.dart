import 'package:flutter/material.dart';

class AddServicePage extends StatefulWidget {
  final Map<String, dynamic>? existingService;
  final bool isReadOnly; // Initial mode (View or Add)

  const AddServicePage({super.key, this.existingService, this.isReadOnly = false});

  @override
  State<AddServicePage> createState() => _AddServicePageState();
}

class _AddServicePageState extends State<AddServicePage> {
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _areaController;
  late TextEditingController _cityController;

  // Track if we are currently in edit mode
  late bool _editMode;

  @override
  void initState() {
    super.initState();
    // If it's a new service, editMode is true. If viewing existing, it's false.
    _editMode = widget.existingService == null ? true : !widget.isReadOnly;

    _nameController = TextEditingController(text: widget.existingService?['name'] ?? '');
    _addressController = TextEditingController(text: widget.existingService?['address'] ?? '');
    _areaController = TextEditingController(text: widget.existingService?['area'] ?? '');
    _cityController = TextEditingController(text: widget.existingService?['city'] ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_editMode ? "Add Service Details" : "Edit Service Details", style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                _editMode ? "Service Information" : "Modify Information",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
              ),
              const SizedBox(height: 20),
              
              _buildTextField(_nameController, "Service Name", "e.g., Electrician", Icons.work),
              const SizedBox(height: 15),
              _buildTextField(_addressController, "Shop Address", "Street/Building", Icons.location_on),
              const SizedBox(height: 15),
              _buildTextField(_areaController, "Area", "e.g., Gulshan-e-Iqbal", Icons.map),
              const SizedBox(height: 15),
              _buildTextField(_cityController, "City", "e.g., Karachi", Icons.location_city),

              const SizedBox(height: 30),

              // DYNAMIC BUTTON LOGIC
              if (!_editMode)
                // SHOW THIS BUTTON WHEN ONLY VIEWING
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _editMode = true; // Unlock the fields
                    });
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text("Update Details", style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal, // Different color to stand out
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                )
              else
                // SHOW THIS BUTTON WHEN ADDING OR EDITING
                ElevatedButton(
                  onPressed: () {
                    if (_nameController.text.isNotEmpty && _addressController.text.isNotEmpty) {
                      Navigator.pop(context, {
                        "name": _nameController.text,
                        "address": _addressController.text,
                        "area": _areaController.text,
                        "city": _cityController.text,
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Text(widget.existingService == null ? "Save Service" : "Save Changes", 
                    style: const TextStyle(fontSize: 18)),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, String hint, IconData icon) {
    return TextField(
      controller: controller,
      readOnly: !_editMode, // Controlled by our editMode variable
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.teal),
        filled: !_editMode, // Light grey background when locked
        fillColor: Colors.grey.withOpacity(0.1),
        border: const OutlineInputBorder(),
      ),
    );
  }
}