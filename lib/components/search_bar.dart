import 'package:flutter/material.dart';
import 'package:payzen_app/constant/colors.dart';

class ContactSearchBar extends StatefulWidget {
  final ValueChanged<String> onSearchChanged;

  const ContactSearchBar({super.key, required this.onSearchChanged});

  @override
  State<ContactSearchBar> createState() => _ContactSearchBarState();
}

class _ContactSearchBarState extends State<ContactSearchBar> {
  final TextEditingController _controller = TextEditingController();
  bool _isSearchByNumber = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      widget.onSearchChanged(_controller.text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleSearchMode() {
    setState(() {
      _isSearchByNumber = !_isSearchByNumber;
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _controller,
              keyboardType:
                  _isSearchByNumber ? TextInputType.phone : TextInputType.text,
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText:
                    _isSearchByNumber
                        ? "Search by number"
                        : "Search by contact name",
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: _toggleSearchMode,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                _isSearchByNumber ? "Name" : "Number",
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
