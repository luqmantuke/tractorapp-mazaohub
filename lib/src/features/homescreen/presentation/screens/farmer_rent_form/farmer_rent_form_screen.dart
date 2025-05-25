import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tractorapp/src/core/constants/colors.dart';
import 'package:tractorapp/src/shared/widgets/buttons/custombuttons.dart';

class FarmerRentFormScreen extends StatefulWidget {
  const FarmerRentFormScreen({super.key});

  @override
  State<FarmerRentFormScreen> createState() => _FarmerRentFormScreenState();
}

class _FarmerRentFormScreenState extends State<FarmerRentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _productController = TextEditingController();
  final _rentalDurationController = TextEditingController(text: '20,000/day');
  final _pickupController =
      TextEditingController(text: 'Magomeni Mikumi, Dar es salaam');
  final _coordinatesController = TextEditingController(text: '20,000/day');
  final _addressController =
      TextEditingController(text: 'Magomeni Mikumi, Dar es salaam');
  final _notesController = TextEditingController();
  bool _acceptTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h),
                _buildAppBar(context),
                SizedBox(height: 2.h),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTextField(
                          'Customer name', 'Enter full name', _nameController),
                      _buildTextField('Phone number', 'Enter your phone number',
                          _phoneController,
                          keyboardType: TextInputType.phone),
                      _buildTextField(
                          'Email', 'Enter your email address', _emailController,
                          keyboardType: TextInputType.emailAddress),
                      _buildTextField('Product name', 'Enter your product name',
                          _productController),
                      _buildTextField(
                          'Rental duration', '', _rentalDurationController,
                          enabled: false),
                      _buildTextField('Preferred pickup/delivery date', '',
                          _pickupController,
                          enabled: false),
                      _buildTextField(
                          'Enter Coordinates', '', _coordinatesController,
                          enabled: false),
                      _buildTextField('Address', '', _addressController,
                          enabled: false),
                      _buildTextField('Additional notes (optional)',
                          'Additional notes', _notesController,
                          maxLines: 3),
                      SizedBox(height: 2.h),
                      _buildTermsCheckbox(),
                      SizedBox(height: 2.h),
                      CustomButton(
                        text: 'Pay Now',
                        color: AppColors.primaryGreen,
                        textColor: AppColors.white,
                        onPressed: _acceptTerms ? _onPayNow : null,
                      ),
                      SizedBox(height: 2.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        SizedBox(width: 2.w),
        Text('Tractors & Machinery',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
      ],
    );
  }

  Widget _buildTextField(
      String label, String hint, TextEditingController controller,
      {bool enabled = true,
      TextInputType keyboardType = TextInputType.text,
      int maxLines = 1}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400)),
          SizedBox(height: 0.5.h),
          TextFormField(
            controller: controller,
            enabled: enabled,
            keyboardType: keyboardType,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: AppColors.grey.withOpacity(0.08),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTermsCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _acceptTerms,
          onChanged: (val) => setState(() => _acceptTerms = val ?? false),
          activeColor: AppColors.primaryGreen,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: 'I accept ',
              style: TextStyle(color: Colors.black, fontSize: 15.sp),
              children: const [
                TextSpan(
                  text: 'Terms & Conditions',
                  style: TextStyle(
                      color: AppColors.primaryGreen,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _onPayNow() {
    if (_formKey.currentState?.validate() ?? false) {
      context.pushNamed('farmer-quote');
    }
  }
}
