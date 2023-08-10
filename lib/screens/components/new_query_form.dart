import 'package:flutter/material.dart';
import 'package:gen_ai_frontend/constants/colors.dart';

const personas = [
  "吳宗憲",
  "林志玲",
  "蔡英文",
  "柯文哲",
  "Warren Buffett",
  "Donald Trump",
  "Mary Callahan Erdoes",
  "Oprah Gail Winfrey",
];
const languages = ["English", "台灣繁體中文"];

class NewQueryForm extends StatefulWidget {
  final String formTitle;
  final TextEditingController controller;
  final void Function() toggleModal;
  final void Function() onSubmit;
  final String persona;
  final String language;
  final void Function(String?) onChangePersona;
  final void Function(String?) onChangeLanguage;
  const NewQueryForm(
      {super.key,
      required this.formTitle,
      required this.controller,
      required this.toggleModal,
      required this.onSubmit,
      required this.persona,
      required this.language,
      required this.onChangePersona,
      required this.onChangeLanguage});

  @override
  State<NewQueryForm> createState() => _NewQueryFormState();
}

class _NewQueryFormState extends State<NewQueryForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: (MediaQuery.of(context).orientation == Orientation.portrait)
          ? 400
          : MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 25,
              ),
              DefaultTextStyle(
                style: const TextStyle(
                    fontSize: 23,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                child: Text(
                  widget.formTitle,
                ),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: widget.controller,
                        keyboardType: TextInputType.multiline,
                        minLines: 5,
                        maxLines: 5,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Ask a question... ',
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          fillColor: Colors.grey[200],
                          alignLabelWithHint: true,
                          filled: true,
                        ),
                        onTap: () {},
                        onChanged: (value) {},
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField(
                        value: widget.persona,
                        isExpanded: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        hint: const Text(
                          "Persona",
                          style: TextStyle(fontSize: 15),
                        ),
                        items: personas
                            .map((persona) => DropdownMenuItem(
                                  value: persona,
                                  child: Center(
                                      child: Text(
                                    persona,
                                    textAlign: TextAlign.center,
                                  )),
                                ))
                            .toList(),
                        onChanged: widget.onChangePersona),
                    const SizedBox(
                      height: 10,
                    ),
                    DropdownButtonFormField(
                        value: widget.language,
                        isExpanded: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        hint: const Text(
                          "Language",
                          style: TextStyle(fontSize: 15),
                        ),
                        items: languages
                            .map((language) => DropdownMenuItem(
                                  value: language,
                                  child: Center(
                                      child: Text(
                                    language,
                                    textAlign: TextAlign.center,
                                  )),
                                ))
                            .toList(),
                        onChanged: widget.onChangeLanguage),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: ElevatedButton(
                          onPressed: widget.onSubmit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: backgroundBlack,
                            elevation: 0,
                            shadowColor: Colors.transparent,
                          ),
                          child: const Text(
                            'Submit',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
          Positioned(
            top: 10,
            right: -10,
            child: IconButton(
              icon: const Icon(Icons.close),
              color: Colors.black,
              onPressed: widget.toggleModal,
            ),
          ),
        ],
      ),
    );
  }
}
