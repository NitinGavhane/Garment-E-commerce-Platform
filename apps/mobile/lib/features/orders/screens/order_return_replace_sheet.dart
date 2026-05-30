import 'package:flutter/material.dart';

import '../models/order_return_replace_form.dart';


import '../models/order_return_replace_request.dart';
import '../../../models/order.dart';

class OrderReturnReplaceSheet extends StatefulWidget {
  final Order order;
  final ReturnReplaceType type;

  const OrderReturnReplaceSheet({
    super.key,
    required this.order,
    required this.type,
  });

  @override
  State<OrderReturnReplaceSheet> createState() => _OrderReturnReplaceSheetState();
}

class _OrderReturnReplaceSheetState extends State<OrderReturnReplaceSheet> {
final _formKey = GlobalKey<OrderReturnReplaceFormState>();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          OrderReturnReplaceForm(
            key: _formKey,
            order: widget.order,
            type: widget.type,
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                final state = _formKey.currentState;
                final error = state?.validate();
                if (error != null && error.isNotEmpty) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(error)));
                  return;
                }

                final req = state!.buildRequest();
                Navigator.of(context).pop(req);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${req.label} request submitted (${req.statusLabel})',
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.send_rounded),
              label: const Text('Submit request'),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

