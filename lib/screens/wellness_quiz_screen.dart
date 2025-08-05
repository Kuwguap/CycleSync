import 'package:flutter/material.dart';

class WellnessQuizScreen extends StatefulWidget {
  const WellnessQuizScreen({super.key});

  @override
  State<WellnessQuizScreen> createState() => _WellnessQuizScreenState();
}

class _WellnessQuizScreenState extends State<WellnessQuizScreen> {
  int currentQuestionIndex = 0;
  int currentLevel = 0; // 0: beginner, 1: intermediate, 2: pro
  int score = 0;
  List<bool> answers = [];
  bool quizCompleted = false;
  bool showResult = false;
  String? selectedAnswer;
  bool isAnswerCorrect = false;
  bool showFeedback = false;

  final List<String> levels = ['Beginner', 'Intermediate', 'Pro'];
  final List<Color> levelColors = [
    const Color(0xFF4CAF50), // Green for beginner
    const Color(0xFFFF9800), // Orange for intermediate
    const Color(0xFFE91E63), // Pink for pro
  ];

  final List<List<QuizQuestion>> allQuestions = [
    // Beginner Level - Basic Wellness
    [
      QuizQuestion(
        question: 'What is mindfulness?',
        options: [
          'A type of exercise',
          'Being present in the moment',
          'A diet plan',
          'A sleep technique'
        ],
        correctAnswer: 1,
        explanation: 'Mindfulness is the practice of being fully present and aware of the current moment without judgment.',
      ),
      QuizQuestion(
        question: 'How can deep breathing help with stress?',
        options: [
          'It makes you tired',
          'It activates the relaxation response',
          'It increases heart rate',
          'It has no effect'
        ],
        correctAnswer: 1,
        explanation: 'Deep breathing activates the parasympathetic nervous system, triggering the relaxation response and reducing stress.',
      ),
      QuizQuestion(
        question: 'Which activity is best for mental wellness?',
        options: [
          'Watching TV all day',
          'Regular exercise',
          'Eating junk food',
          'Staying indoors'
        ],
        correctAnswer: 1,
        explanation: 'Regular exercise releases endorphins and reduces stress hormones, making it excellent for mental wellness.',
      ),
      QuizQuestion(
        question: 'What is a good way to practice gratitude?',
        options: [
          'Complaining about problems',
          'Keeping a gratitude journal',
          'Ignoring positive things',
          'Focusing on negatives'
        ],
        correctAnswer: 1,
        explanation: 'Keeping a gratitude journal helps you focus on positive aspects of life and improves overall well-being.',
      ),
      QuizQuestion(
        question: 'True or False: Sleep affects your mental health.',
        options: ['True', 'False'],
        correctAnswer: 0,
        explanation: 'True! Poor sleep can worsen anxiety, depression, and stress, while good sleep improves mood and cognitive function.',
      ),
    ],
    // Intermediate Level - Stress Management & Self-Care
    [
      QuizQuestion(
        question: 'What is the "fight or flight" response?',
        options: [
          'A type of exercise',
          'The body\'s stress response',
          'A breathing technique',
          'A meditation practice'
        ],
        correctAnswer: 1,
        explanation: 'The "fight or flight" response is the body\'s automatic reaction to perceived threats, releasing stress hormones.',
      ),
      QuizQuestion(
        question: 'Which technique helps with anxiety?',
        options: [
          'Progressive muscle relaxation',
          'Avoiding all social situations',
          'Drinking caffeine',
          'Staying up late'
        ],
        correctAnswer: 0,
        explanation: 'Progressive muscle relaxation helps reduce anxiety by systematically tensing and relaxing muscle groups.',
      ),
      QuizQuestion(
        question: 'What is emotional intelligence?',
        options: [
          'Being very smart',
          'Understanding and managing emotions',
          'Having many friends',
          'Being artistic'
        ],
        correctAnswer: 1,
        explanation: 'Emotional intelligence is the ability to understand, use, and manage emotions effectively in yourself and others.',
      ),
      QuizQuestion(
        question: 'How can journaling help with wellness?',
        options: [
          'It wastes time',
          'It helps process emotions',
          'It makes you tired',
          'It has no benefits'
        ],
        correctAnswer: 1,
        explanation: 'Journaling helps process emotions, reduce stress, and gain clarity about thoughts and feelings.',
      ),
      QuizQuestion(
        question: 'What is a healthy way to set boundaries?',
        options: [
          'Saying yes to everything',
          'Communicating your limits clearly',
          'Avoiding all conflict',
          'Being aggressive'
        ],
        correctAnswer: 1,
        explanation: 'Setting healthy boundaries involves clearly communicating your limits and needs in a respectful way.',
      ),
      QuizQuestion(
        question: 'Which activity promotes social wellness?',
        options: [
          'Isolating yourself',
          'Spending time with loved ones',
          'Avoiding all social media',
          'Working constantly'
        ],
        correctAnswer: 1,
        explanation: 'Spending quality time with loved ones promotes social wellness and strengthens relationships.',
      ),
    ],
    // Pro Level - Advanced Wellness & Mental Health
    [
      QuizQuestion(
        question: 'What is cognitive behavioral therapy (CBT)?',
        options: [
          'A type of medication',
          'A therapy that focuses on changing thought patterns',
          'A physical exercise',
          'A diet plan'
        ],
        correctAnswer: 1,
        explanation: 'CBT is a therapy approach that helps identify and change negative thought patterns and behaviors.',
      ),
      QuizQuestion(
        question: 'What is the difference between stress and anxiety?',
        options: [
          'They are the same thing',
          'Stress is temporary, anxiety can be persistent',
          'Stress is always bad, anxiety is always good',
          'There is no difference'
        ],
        correctAnswer: 1,
        explanation: 'Stress is typically a temporary response to a specific situation, while anxiety can be persistent and not tied to a specific threat.',
      ),
      QuizQuestion(
        question: 'What is the role of serotonin in mental health?',
        options: [
          'It only affects sleep',
          'It\'s a neurotransmitter that affects mood',
          'It only affects appetite',
          'It has no role in mental health'
        ],
        correctAnswer: 1,
        explanation: 'Serotonin is a neurotransmitter that plays a key role in regulating mood, sleep, appetite, and other functions.',
      ),
      QuizQuestion(
        question: 'What is the "window of tolerance"?',
        options: [
          'A time management technique',
          'The optimal zone for emotional regulation',
          'A type of meditation',
          'A breathing exercise'
        ],
        correctAnswer: 1,
        explanation: 'The window of tolerance is the optimal zone where we can process emotions and respond effectively to challenges.',
      ),
      QuizQuestion(
        question: 'How does nature affect mental health?',
        options: [
          'It has no effect',
          'It can reduce stress and improve mood',
          'It only affects physical health',
          'It makes people anxious'
        ],
        correctAnswer: 1,
        explanation: 'Spending time in nature has been shown to reduce stress, improve mood, and enhance overall mental well-being.',
      ),
    ],
  ];

  @override
  Widget build(BuildContext context) {
    if (quizCompleted) {
      return _buildResultsScreen();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.pink[300]),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Icon(Icons.self_improvement, color: Colors.green[600], size: 24),
            const SizedBox(width: 8),
            Text(
              'Wellness Quiz',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1A2128),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Progress Bar
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Level ${currentLevel + 1}: ${levels[currentLevel]}',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: levelColors[currentLevel],
                      ),
                    ),
                    Text(
                      '${currentQuestionIndex + 1}/${allQuestions[currentLevel].length}',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: (currentQuestionIndex + 1) / allQuestions[currentLevel].length,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(levelColors[currentLevel]),
                ),
              ],
            ),
          ),
          // Question Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Question
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: levelColors[currentLevel].withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: levelColors[currentLevel].withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      allQuestions[currentLevel][currentQuestionIndex].question,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1A2128),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Options
                  ...allQuestions[currentLevel][currentQuestionIndex]
                      .options
                      .asMap()
                      .entries
                      .map((entry) => _buildOption(entry.key, entry.value))
                      .toList(),
                  const Spacer(),
                  // Next Button
                  if (selectedAnswer != null)
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: showFeedback ? _nextQuestion : _checkAnswer,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: levelColors[currentLevel],
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          showFeedback ? 'Next Question' : 'Submit Answer',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(int index, String option) {
    bool isSelected = selectedAnswer == option;
    bool isCorrect = index == allQuestions[currentLevel][currentQuestionIndex].correctAnswer;
    bool showCorrectAnswer = showFeedback && isCorrect;
    bool showWrongAnswer = showFeedback && isSelected && !isCorrect;

    Color backgroundColor = Colors.white;
    Color borderColor = Colors.grey[300]!;
    Color textColor = const Color(0xFF1A2128);

    if (showCorrectAnswer) {
      backgroundColor = Colors.green[50]!;
      borderColor = Colors.green;
      textColor = Colors.green[700]!;
    } else if (showWrongAnswer) {
      backgroundColor = Colors.red[50]!;
      borderColor = Colors.red;
      textColor = Colors.red[700]!;
    } else if (isSelected) {
      backgroundColor = levelColors[currentLevel].withOpacity(0.1);
      borderColor = levelColors[currentLevel];
      textColor = levelColors[currentLevel];
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: showFeedback ? null : () => _selectAnswer(option),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor),
          ),
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: showCorrectAnswer
                      ? Colors.green
                      : showWrongAnswer
                          ? Colors.red
                          : isSelected
                              ? levelColors[currentLevel]
                              : Colors.grey[300],
                ),
                child: showCorrectAnswer
                    ? Icon(Icons.check, color: Colors.white, size: 16)
                    : showWrongAnswer
                        ? Icon(Icons.close, color: Colors.white, size: 16)
                        : isSelected
                            ? Icon(Icons.circle, color: Colors.white, size: 16)
                            : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  option,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectAnswer(String answer) {
    setState(() {
      selectedAnswer = answer;
    });
  }

  void _checkAnswer() {
    final currentQuestion = allQuestions[currentLevel][currentQuestionIndex];
    final selectedIndex = currentQuestion.options.indexOf(selectedAnswer!);
    final isCorrect = selectedIndex == currentQuestion.correctAnswer;

    setState(() {
      showFeedback = true;
      isAnswerCorrect = isCorrect;
      if (isCorrect) score++;
      answers.add(isCorrect);
    });

    // Show explanation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          currentQuestion.explanation,
          style: const TextStyle(fontFamily: 'Inter'),
        ),
        backgroundColor: isCorrect ? Colors.green : Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _nextQuestion() {
    if (currentQuestionIndex < allQuestions[currentLevel].length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswer = null;
        showFeedback = false;
      });
    } else {
      // Level completed
      if (currentLevel < levels.length - 1) {
        // Move to next level
        setState(() {
          currentLevel++;
          currentQuestionIndex = 0;
          selectedAnswer = null;
          showFeedback = false;
        });
      } else {
        // All levels completed
        setState(() {
          quizCompleted = true;
        });
      }
    }
  }

  Widget _buildResultsScreen() {
    final totalQuestions = allQuestions.fold(0, (sum, level) => sum + level.length);
    final percentage = (score / totalQuestions * 100).round();
    final level = _getLevelFromScore(percentage);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.pink[300]),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Icon(Icons.self_improvement, color: Colors.green[600], size: 24),
            const SizedBox(width: 8),
            Text(
              'Wellness Quiz Results',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1A2128),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Score Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.green[100]!,
                    Colors.teal[100]!,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Wellness Warrior!',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '$percentage%',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'You scored $score out of $totalQuestions',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.green[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Level: $level',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      color: Colors.green[600],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Level Breakdown
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey[200]!),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Level Breakdown',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1A2128),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...levels.asMap().entries.map((entry) {
                    final levelIndex = entry.key;
                    final levelName = entry.value;
                    final levelQuestions = allQuestions[levelIndex].length;
                    final levelScore = _calculateLevelScore(levelIndex);
                    final levelPercentage = (levelScore / levelQuestions * 100).round();
                    
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: levelColors[levelIndex],
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              levelName,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF1A2128),
                              ),
                            ),
                          ),
                          Text(
                            '$levelScore/$levelQuestions',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: levelColors[levelIndex],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '($levelPercentage%)',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            const Spacer(),
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _restartQuiz,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(color: Colors.green[300]!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Try Again',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.green[300],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[300],
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Back to Games',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getLevelFromScore(int percentage) {
    if (percentage >= 90) return 'Wellness Master';
    if (percentage >= 80) return 'Wellness Expert';
    if (percentage >= 70) return 'Wellness Conscious';
    if (percentage >= 60) return 'Wellness Learner';
    return 'Wellness Beginner';
  }

  int _calculateLevelScore(int levelIndex) {
    final levelQuestions = allQuestions[levelIndex].length;
    final startIndex = allQuestions.take(levelIndex).fold(0, (sum, level) => sum + level.length);
    final endIndex = startIndex + levelQuestions;
    
    int levelScore = 0;
    for (int i = startIndex; i < endIndex && i < answers.length; i++) {
      if (answers[i]) levelScore++;
    }
    return levelScore;
  }

  void _restartQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      currentLevel = 0;
      score = 0;
      answers.clear();
      quizCompleted = false;
      selectedAnswer = null;
      showFeedback = false;
    });
  }
}

class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctAnswer;
  final String explanation;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
  });
} 