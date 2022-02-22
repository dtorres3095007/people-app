import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:people/preference/Preference.dart';
import 'package:intl/intl.dart';
import 'package:people/providers/appProvider.dart';
import 'package:people/utils/header_secondary_util.dart';
import 'package:people/utils/loading_util.dart';
import 'package:people/utils/util.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:people/ui/inputDecorations.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Stack(
          children: [
            _createBody(context),
            HeaderSecondaryUtil(
              context: context,
              title: 'AGREGAR PERSONA',
            ),
            Container(
              margin: EdgeInsets.only(left: size.width * 0.8, top: 80.0),
              child: Image.asset(
                'assets/images/person_list.png',
                height: 80,
                width: 80,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createBody(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => appProvider(),
      child: const _FormScreen(),
    );
  }
}

class _FormScreen extends StatefulWidget {
  const _FormScreen({Key? key}) : super(key: key);

  @override
  State<_FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<_FormScreen> {
  bool _error = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final addForm = Provider.of<appProvider>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(
                  top: 80.0, bottom: 20.0, left: 15.0, right: 15.0),
              padding: EdgeInsets.all(size.width * 0.05),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Form(
                key: addForm.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: ListView(
                  children: [
                    const SizedBox(height: 20.0),
                    _inputName(addForm),
                    const SizedBox(height: 15.0),
                    _inputLastName(addForm),
                    const SizedBox(height: 15.0),
                    _inputDate(addForm),
                    const SizedBox(height: 15.0),
                  ],
                ),
              ),
            ),
            addForm.isLoading ? LoadingUtil() : Container(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _btnAdd(context, addForm),
    );
  }

  Widget _inputName(addForm) {
    return TextFormField(
      onChanged: (value) => addForm.name = value,
      autocorrect: false,
      keyboardType: TextInputType.multiline,
      validator: (value) {
        return value.toString().isEmpty ? 'Este campo es obligatorio.' : null;
      },
      decoration: InputDecorations.formsInputDecoration(
          hintText: '',
          labelText: 'Nombre',
          prefixIcon: Icons.text_snippet_rounded),
    );
  }

  Widget _inputLastName(addForm) {
    return TextFormField(
      onChanged: (value) => addForm.lastName = value,
      autocorrect: false,
      keyboardType: TextInputType.multiline,
      validator: (value) {
        return value.toString().isEmpty ? 'Este campo es obligatorio.' : null;
      },
      decoration: InputDecorations.formsInputDecoration(
          hintText: '',
          labelText: 'Apellido',
          prefixIcon: Icons.text_snippet_rounded),
    );
  }

  Widget _inputDate(addForm) {
    final format = DateFormat("yyyy-MM-dd");
    return DateTimeField(
      validator: (date) => date == null ? 'Este campo es obligatorio' : null,
      format: format,
      onChanged: (value) {
        setState(() {
          addForm.date = '$value';
        });
      },
      decoration: InputDecorations.formsInputDecoration(
          hintText: '',
          labelText: 'Fecha de Nacimiento',
          prefixIcon: Icons.text_snippet_rounded),
      onShowPicker: (context, currentValue) {
        return showDatePicker(
            locale: const Locale('es'),
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100));
      },
    );
  }

  Widget _btnAdd(context, addForm) {
    return FloatingActionButton(
      child: const Icon(Icons.save, color: Colors.white),
      backgroundColor: addForm.isLoading ? Colors.grey : Colors.red[900],
      onPressed: addForm.isLoading
          ? () => {}
          : () async {
              FocusScope.of(context).unfocus();
              setState(() {});
              if (!addForm.isValidForm() || _error) return;
              _submit(context, addForm);
            },
    );
  }

  _submit(BuildContext context, addForm) async {
    addForm.isLoading = true;
    setState(() {});
    await addForm.add();
    addForm.formKey.currentState.reset();
    showAlert(
      context,
      'Datos Guardados',
      '¿ desea agregar otra persona?',
      'success',
    );
    addForm.isLoading = false;
    setState(() {});
  }
}
