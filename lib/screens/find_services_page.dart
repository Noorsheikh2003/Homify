import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FindServicesPage extends StatefulWidget {
  const FindServicesPage({super.key});

  @override
  State<FindServicesPage> createState() => _FindServicesPageState();
}

class _FindServicesPageState extends State<FindServicesPage> {
  final List<Map<String, dynamic>> _categories = [
    {"name": "All", "icon": Icons.grid_view},
    {"name": "Electrician", "icon": Icons.bolt},
    {"name": "Plumber", "icon": Icons.plumbing},
    {"name": "Cleaning", "icon": Icons.cleaning_services},
    {"name": "Painter", "icon": Icons.format_paint},
  ];

  // Provider Data with Area and City (address)
  final List<Map<String, String>> _allProviders = [
    {"name": "Ahmed Khan", "service": "Electrician", "phone": "03001234567", "area": "Gulshan", "address": "Karachi"},
    {"name": "Sajid Ali", "service": "Plumber", "phone": "03119876543", "area": "Nazimabad", "address": "Karachi"},
    {"name": "Junaid Khan", "service": "Cleaning", "phone": "03225554433", "area": "Clifton", "address": "Karachi"},
    {"name": "Asif Aziz", "service": "Painter", "phone": "03441112223", "area": "Rizvia Society", "address": "Karachi"},
    {"name": "Bilal Raza", "service": "Electrician", "phone": "03334445556", "area": "Defence", "address": "Karachi"},
  ];

  List<Map<String, String>> _foundProviders = [];
  String _selectedCategory = "All";

  @override
  void initState() {
    _foundProviders = _allProviders;
    super.initState();
  }

  // Search logic handles Name, Service, and Area
  void _filterLogic(String query) {
    List<Map<String, String>> results = [];
    if (query.isEmpty || query == "All") {
      results = _allProviders;
    } else {
      results = _allProviders
          .where((p) =>
              p["name"]!.toLowerCase().contains(query.toLowerCase()) ||
              p["service"]!.toLowerCase().contains(query.toLowerCase()) ||
              p["area"]!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundProviders = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("Find Services",
            style: TextStyle(color: Colors.white,)),
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. SEARCH BAR
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  )
                ],
              ),
              child: TextField(
                onChanged: (value) => _filterLogic(value),
                decoration: InputDecoration(
                  hintText: 'Search name, service, or area...',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  prefixIcon: const Icon(Icons.search, color: Colors.teal),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          ),

          // 2. CATEGORIES LIST
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                bool isSelected =
                    _selectedCategory == _categories[index]['name'];
                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedCategory = _categories[index]['name']);
                    _filterLogic(_categories[index]['name']);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 85,
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.teal : Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: isSelected
                              ? Colors.teal
                              : Colors.teal.withOpacity(0.1)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _categories[index]['icon'],
                          color: isSelected ? Colors.white : Colors.teal,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          _categories[index]['name'],
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : Colors.teal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          // 3. PROVIDER LIST WITH SINGLE LINE SUBTITLE
          Expanded(
            child: _foundProviders.isEmpty
                ? const Center(child: Text("No providers found"))
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 20),
                    itemCount: _foundProviders.length,
                    itemBuilder: (context, index) => Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 10,
                              offset: const Offset(0, 4))
                        ],
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.teal.shade50,
                          child: Text(_foundProviders[index]['name']![0],
                              style: const TextStyle(
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                        ),
                        title: Text(_foundProviders[index]['name']!,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              // Service Name
                              Text(
                                _foundProviders[index]['service']!,
                                style: TextStyle(
                                    color: Colors.grey[700], fontSize: 12),
                              ),
                              // Space
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 6),
                                child: Text("",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold)),
                              ),
                              // Location Icon
                              const Icon(Icons.location_on_outlined,
                                  size: 14, color: Colors.teal),
                              const SizedBox(width: 1),
                              // Area and City
                              Flexible(
                                child: Text(
                                  "${_foundProviders[index]['area']} | ${_foundProviders[index]['address']}",
                                  style: TextStyle(
                                      color: Colors.grey[600], fontSize: 12),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        trailing: Container(
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.phone, color: Colors.green),
                            onPressed: () async {
                              final Uri url = Uri.parse(
                                  "tel:${_foundProviders[index]['phone']}");
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url);
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}