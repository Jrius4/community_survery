import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../models/survey.dart';
import '../services/hive_service.dart';
import 'package:uuid/uuid.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool hasLivestock = false;

  void _submitForm() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final data = _formKey.currentState!.value;

      final survey = Survey(
        id: const Uuid().v4(),
        title: "Farm Survey",
        description: "Participant's farm information",
        questions: [], // You can add questions if needed
        createdAt: DateTime.now(),
        responses: data,
        isCompleted: true,
      );

      await HiveService.saveSurvey(survey);
      if (mounted) {
        Navigator.pushNamed(context, '/');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farm Survey'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Farm Name
              FormBuilderTextField(
                name: 'farm_name',
                decoration: const InputDecoration(
                  labelText: 'Farm Name',
                  hintText: 'Enter your farm name',
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.maxLength(50),
                ]),
              ),
              const SizedBox(height: 16),

              // 2. Farm Size (Acres)
              FormBuilderTextField(
                name: 'farm_size',
                decoration: const InputDecoration(
                  labelText: 'Farm Size (Acres)',
                  hintText: 'Enter farm size',
                ),
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric(),
                  FormBuilderValidators.min(0.1),
                ]),
              ),
              const SizedBox(height: 16),

              // 3. Primary Farming Type
              FormBuilderRadioGroup(
                name: 'farming_type',
                decoration: const InputDecoration(
                  labelText: 'Primary Farming Type',
                ),
                options: const [
                  FormBuilderFieldOption(
                      value: 'crop', child: Text('Crop Farming')),
                  FormBuilderFieldOption(
                      value: 'livestock', child: Text('Livestock')),
                  FormBuilderFieldOption(
                      value: 'mixed', child: Text('Mixed Farming')),
                  FormBuilderFieldOption(
                      value: 'organic', child: Text('Organic Farming')),
                ],
                validator: FormBuilderValidators.required(),
              ),
              const SizedBox(height: 16),

              // 4. Crops Grown (Multiple Selection)
              FormBuilderCheckboxGroup<String>(
                name: 'crops',
                decoration: const InputDecoration(
                  labelText: 'Crops Grown',
                ),
                options: const [
                  FormBuilderFieldOption(value: 'corn', child: Text('Corn')),
                  FormBuilderFieldOption(value: 'wheat', child: Text('Wheat')),
                  FormBuilderFieldOption(
                      value: 'soybeans', child: Text('Soybeans')),
                  FormBuilderFieldOption(
                      value: 'vegetables', child: Text('Vegetables')),
                  FormBuilderFieldOption(
                      value: 'fruits', child: Text('Fruits')),
                ],
                validator: FormBuilderValidators.required(),
              ),
              const SizedBox(height: 16),

              // 5. Farm Establishment Date
              FormBuilderDateTimePicker(
                name: 'establishment_date',
                decoration: const InputDecoration(
                  labelText: 'Farm Establishment Date',
                ),
                inputType: InputType.date,
                validator: FormBuilderValidators.required(),
              ),
              const SizedBox(height: 16),

              // 6. Has Livestock?
              FormBuilderRadioGroup(
                name: 'has_livestock',
                decoration: const InputDecoration(
                  labelText: 'Do you have livestock?',
                ),
                options: const [
                  FormBuilderFieldOption(value: 'yes', child: Text('Yes')),
                  FormBuilderFieldOption(value: 'no', child: Text('No')),
                ],
                onChanged: (value) {
                  setState(() {
                    hasLivestock = value == 'yes';
                  });
                },
                validator: FormBuilderValidators.required(),
              ),
              const SizedBox(height: 16),

              // 7. Conditional Livestock Count
              if (hasLivestock)
                FormBuilderTextField(
                  name: 'livestock_count',
                  decoration: const InputDecoration(
                    labelText: 'Number of Livestock',
                    hintText: 'Enter total number of animals',
                  ),
                  keyboardType: TextInputType.number,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.numeric(),
                    FormBuilderValidators.min(1),
                  ]),
                ),
              const SizedBox(height: 16),

              // 8. Contact Phone
              FormBuilderTextField(
                name: 'phone',
                decoration: const InputDecoration(
                  labelText: 'Contact Phone',
                  hintText: 'Enter your phone number',
                ),
                keyboardType: TextInputType.phone,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric(),
                  FormBuilderValidators.minLength(10),
                  FormBuilderValidators.maxLength(15),
                ]),
              ),
              const SizedBox(height: 16),

              // 9. Email
              FormBuilderTextField(
                name: 'email',
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  hintText: 'Enter your email',
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ]),
              ),
              const SizedBox(height: 16),

              // 10. Additional Notes
              FormBuilderTextField(
                name: 'notes',
                decoration: const InputDecoration(
                  labelText: 'Additional Notes',
                  hintText: 'Enter any additional information',
                ),
                maxLines: 3,
                validator: FormBuilderValidators.maxLength(500),
              ),
              const SizedBox(height: 24),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text('Submit Survey'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
