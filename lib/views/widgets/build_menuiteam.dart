import 'dart:ui';
import 'package:flutter/material.dart';

Widget buildMenuItem(IconData icon, String title, {Color color = Colors.black87}) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        // পরবর্তী অ্যাকশন এখানে হবে
      },
    );
  }