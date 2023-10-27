// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../models/event.model.dart';

class EventWidget extends StatelessWidget {
  final EventModel event;
  final VoidCallback onPressed;
  const EventWidget({
    Key? key,
    required this.event,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(
        // horizontal: 10,
        vertical: 5,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Color(event.color),
                  width: 2,
                ),
              ),
              child: ListTile(
                title: Text(
                  '${event.title} - ${event.date.day}/${event.date.month}/${event.date.year}',
                  style: TextStyle(
                    color: Color(event.color),
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  event.description,
                ),
              ),
            ),
          ),
          Container(
            width: 30,
            height: 2,
            color: Color(event.color),
          ),
          InkWell(
            onTap: onPressed,
            child: Container(
              padding: const EdgeInsets.all(10),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Color(event.color),
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
/**
 
 */