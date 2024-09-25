import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:zee_translator/app/constants/app_colors.dart';
import 'package:zee_translator/app/cubit/lang_cubit/language_cubit.dart';
import 'package:zee_translator/app/cubit/lang_cubit/language_state.dart';
import 'package:zee_translator/app/cubit/speech_to_text_cubit/speech_to_text_cubit.dart';
import 'package:zee_translator/app/cubit/speech_to_text_cubit/speech_to_text_state.dart';
import 'package:zee_translator/app/cubit/translator_cubit/translator_cubit.dart';
import 'package:zee_translator/app/cubit/translator_cubit/translator_state.dart';
import 'package:zee_translator/app/widgets/custom_drop_down.dart';
import 'package:zee_translator/app/widgets/custom_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TranslatorScreen extends StatefulWidget {
  const TranslatorScreen({super.key});

  @override
  State<TranslatorScreen> createState() => _TranslatorScreenState();
}

class _TranslatorScreenState extends State<TranslatorScreen> {
  final TextEditingController _inputText = TextEditingController();
  String firstLang = "en";
  String secondLang = "ur";

  @override
  void initState() {
    super.initState();
    context.read<LanguageCubit>().setLangFrom(firstLang);
    context.read<LanguageCubit>().setLangTo(secondLang);
  }

  @override
  Widget build(BuildContext context) {
    final FlutterTts flutterTts = FlutterTts();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TranslatorCubit(),
        ),
        BlocProvider(
          create: (context) => SpeechCubit()..listenForPermissions(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.offWhite,
          centerTitle: true,
          title: const Text(
            'ZeeTranslator',
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          actions: [IconButton(onPressed: (){}, icon: Icon(Icons.arrow_circle_right_sharp,color: Colors.black,))],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Expanded(
                    child:
                        Center(child: BlocBuilder<LanguageCubit, LanguageState>(
                      builder: (context, state) {
                        return CustomDropDown(
                          onSelected: (value) {
                            context.read<LanguageCubit>().setLangFrom(value);
                          },
                          languages: const [
                            Languages('English', 'en'),
                            Languages('Urdu', 'ur'),
                            Languages('Spanish', 'es'),
                            Languages('French', 'fr'),
                            Languages('German', 'de'),
                            Languages('Chinese', 'zh'),
                            Languages('Japanese', 'ja'),
                            Languages('Korean', 'ko'),
                            Languages('Russian', 'ru'),
                            Languages('Italian', 'it'),
                            Languages('Portuguese', 'pt'),
                            Languages('Arabic', 'ar'),
                            Languages('Turkish', 'tr'),
                            Languages('Hindi', 'hi'),
                            Languages('Bengali', 'bn'),
                            Languages('Swahili', 'sw'),
                            Languages('Thai', 'th'),
                          ],
                          selectedLanguage: state.selectedLanguageFrom,
                        );
                      },
                    )),
                  ),
                  SizedBox(
                    width: 30,
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.compare_arrows_sharp,
                          size: 25,
                        )),
                  ),
                  Expanded(
                    child:
                        Center(child: BlocBuilder<LanguageCubit, LanguageState>(
                      builder: (context, state) {
                        return CustomDropDown(
                          onSelected: (value) {
                            context.read<LanguageCubit>().setLangTo(value);
                          },
                          languages: const [
                            Languages('English', 'en'),
                            Languages('Urdu', 'ur'),
                            Languages('Spanish', 'es'),
                            Languages('French', 'fr'),
                            Languages('German', 'de'),
                            Languages('Chinese', 'zh'),
                            Languages('Japanese', 'ja'),
                            Languages('Korean', 'ko'),
                            Languages('Russian', 'ru'),
                            Languages('Italian', 'it'),
                            Languages('Portuguese', 'pt'),
                            Languages('Arabic', 'ar'),
                            Languages('Turkish', 'tr'),
                            Languages('Hindi', 'hi'),
                            Languages('Bengali', 'bn'),
                            Languages('Swahili', 'sw'),
                            Languages('Thai', 'th'),
                          ],
                          selectedLanguage: state.selectedLanguageTo,
                        );
                      },
                    )),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: BlocConsumer<TranslatorCubit, TranslatorState>(
                  listener: (context, translatorState) {
                    if (translatorState.translatorStatus ==
                        TranslatorStatus.listenText) {
                      _inputText.text = translatorState.message;
                    }
                  },
                  builder: (context, translatorState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          onChanged: (value) async {
                            if (value.isNotEmpty) {
                              context.read<TranslatorCubit>().translate(
                                  context
                                      .read<LanguageCubit>()
                                      .state
                                      .selectedLanguageFrom,
                                  context
                                      .read<LanguageCubit>()
                                      .state
                                      .selectedLanguageTo,
                                  _inputText.text);
                            }
                          },
                          hintText: 'Enter Text...',
                          controller: _inputText,
                          bgColor: AppColors.offWhite,
                        ),
                        Center(
                          child: BlocConsumer<SpeechCubit, SpeechState>(
                            listener: (BuildContext context,
                                SpeechState speechState) {
                              if (speechState.status == SpeechStatus.result) {
                                context.read<TranslatorCubit>().setInputValue(
                                    speechState.result!.recognizedWords);
                                context.read<TranslatorCubit>().translate(
                                    context
                                        .read<LanguageCubit>()
                                        .state
                                        .selectedLanguageFrom,
                                    context
                                        .read<LanguageCubit>()
                                        .state
                                        .selectedLanguageTo,
                                    speechState.result!.recognizedWords);
                                print(speechState.status);
                              }
                            },
                            builder: (context, speechState) {
                              return IconButton(
                                onPressed: () {
                                  final cubit = context.read<SpeechCubit>();
                                  if (speechState.status ==
                                      SpeechStatus.initialized) {
                                    cubit.startListening();
                                  } else if (speechState.status ==
                                      SpeechStatus.stopped) {
                                    cubit.startListening();
                                  } else if (speechState.status ==
                                      SpeechStatus.listening) {
                                    cubit.stopListening();
                                  }

                                  if (speechState.status ==
                                      SpeechStatus.error) {
                                    cubit.stopListening();
                                  }

                                  print(speechState.status);
                                },
                                icon: Icon(
                                  speechState.status == SpeechStatus.listening
                                      ? Icons.mic
                                      : Icons.mic_off,
                                  color: Colors.black,
                                ),
                                color: Colors.green,
                              );
                            },
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                color: AppColors.offWhite,
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: BlocBuilder<TranslatorCubit, TranslatorState>(
                  builder: (context, state) {
                    if (state.translatorStatus == TranslatorStatus.converted) {
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(state.message),
                            Center(
                              child: IconButton(
                                  onPressed: () {
                                    flutterTts.speak(state.message);
                                  },
                                  icon: SvgPicture.asset(
                                    'assets/svg/speaker.svg',
                                    width: 30,
                                    height: 30,
                                  )),
                            )
                          ]);
                    } else if (state.translatorStatus ==
                        TranslatorStatus.converting) {
                      return Text(state.message);
                    } else if (state.translatorStatus ==
                        TranslatorStatus.failed) {
                      return Text(state.message);
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Output Text"),
                          const SizedBox(
                            height: 50,
                          ),
                          Center(
                            child: IconButton(
                                onPressed: () {
                                  flutterTts
                                      .speak('Hello, This is ZeeTranslator');
                                },
                                icon: SvgPicture.asset(
                                  'assets/svg/speaker.svg',
                                  width: 20,
                                  height: 20,
                                )),
                          )
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
