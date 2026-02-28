import 'package:flutter/material.dart';

Widget buildHeader(String name, String email) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.1),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.orange,
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
          const SizedBox(height: 15),
          Text(name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(email, style: TextStyle(color: Colors.grey.shade600)),
        ],
      ),
    );
  }