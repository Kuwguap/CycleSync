import 'package:flutter/material.dart';

class HealthQuizScreen extends StatefulWidget {
  const HealthQuizScreen({super.key});

  @override
  State<HealthQuizScreen> createState() => _HealthQuizScreenState();
}

class _HealthQuizScreenState extends State<HealthQuizScreen> {
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
    // Beginner Level - Basic Health
    [
      QuizQuestion(
        question: 'How much water should you drink daily?',
        options: [
          '2-3 glasses',
          '6-8 glasses (8 oz each)',
          '1 gallon',
          'Only when thirsty'
        ],
        correctAnswer: 1,
        explanation: 'The general recommendation is 6-8 glasses of water (8 oz each) daily, though needs vary by activity and climate.',
      ),
      QuizQuestion(
        question: 'Which food group should make up the largest portion of your plate?',
        options: ['Proteins', 'Vegetables', 'Grains', 'Fruits'],
        correctAnswer: 1,
        explanation: 'Vegetables should make up the largest portion of your plate, providing essential vitamins and fiber.',
      ),
      QuizQuestion(
        question: 'How many hours of sleep do adults need per night?',
        options: ['4-5 hours', '6-7 hours', '7-9 hours', '10+ hours'],
        correctAnswer: 2,
        explanation: 'Adults typically need 7-9 hours of sleep per night for optimal health and functioning.',
      ),
      QuizQuestion(
        question: 'What is the best way to prevent the spread of germs?',
        options: [
          'Wearing gloves',
          'Washing hands with soap and water',
          'Using hand sanitizer only',
          'Avoiding sick people'
        ],
        correctAnswer: 1,
        explanation: 'Washing hands with soap and water for at least 20 seconds is the most effective way to prevent germ spread.',
      ),
      QuizQuestion(
        question: 'True or False: Exercise can help improve your mood.',
        options: ['True', 'False'],
        correctAnswer: 0,
        explanation: 'True! Exercise releases endorphins which are natural mood boosters and can help reduce stress and anxiety.',
      ),
    ],
    // Intermediate Level - Nutrition & Exercise
    [
      QuizQuestion(
        question: 'Which nutrient is essential for building and repairing muscles?',
        options: ['Carbohydrates', 'Protein', 'Fat', 'Fiber'],
        correctAnswer: 1,
        explanation: 'Protein is essential for building and repairing muscles, tissues, and cells in the body.',
      ),
      QuizQuestion(
        question: 'What is the recommended amount of moderate exercise per week?',
        options: ['30 minutes', '150 minutes', '300 minutes', '60 minutes'],
        correctAnswer: 1,
        explanation: 'The CDC recommends at least 150 minutes of moderate-intensity exercise per week for adults.',
      ),
      QuizQuestion(
        question: 'Which vitamin is known as the "sunshine vitamin"?',
        options: ['Vitamin A', 'Vitamin C', 'Vitamin D', 'Vitamin E'],
        correctAnswer: 2,
        explanation: 'Vitamin D is called the "sunshine vitamin" because our bodies can produce it when skin is exposed to sunlight.',
      ),
      QuizQuestion(
        question: 'What is the main function of carbohydrates in the body?',
        options: [
          'Building muscles',
          'Providing energy',
          'Absorbing vitamins',
          'Regulating temperature'
        ],
        correctAnswer: 1,
        explanation: 'Carbohydrates are the body\'s primary source of energy, especially for the brain and muscles.',
      ),
      QuizQuestion(
        question: 'Which of these is a sign of dehydration?',
        options: [
          'Clear urine',
          'Dark yellow urine',
          'Frequent urination',
          'Increased thirst only'
        ],
        correctAnswer: 1,
        explanation: 'Dark yellow urine is a common sign of dehydration, indicating the body needs more water.',
      ),
      QuizQuestion(
        question: 'True or False: Skipping breakfast can slow down your metabolism.',
        options: ['True', 'False'],
        correctAnswer: 0,
        explanation: 'True! Skipping breakfast can slow down your metabolism and lead to overeating later in the day.',
      ),
    ],
    // Pro Level - Advanced Health Knowledge
    [
      QuizQuestion(
        question: 'What is the difference between HDL and LDL cholesterol?',
        options: [
          'HDL is "good" cholesterol, LDL is "bad"',
          'HDL is "bad" cholesterol, LDL is "good"',
          'They are the same thing',
          'HDL is protein, LDL is fat'
        ],
        correctAnswer: 0,
        explanation: 'HDL (high-density lipoprotein) is "good" cholesterol that helps remove LDL, while LDL (low-density lipoprotein) is "bad" cholesterol that can build up in arteries.',
      ),
      QuizQuestion(
        question: 'Which hormone regulates blood sugar levels?',
        options: ['Adrenaline', 'Insulin', 'Testosterone', 'Estrogen'],
        correctAnswer: 1,
        explanation: 'Insulin is the hormone that regulates blood sugar levels by helping glucose enter cells for energy.',
      ),
      QuizQuestion(
        question: 'What is the recommended daily fiber intake for adults?',
        options: ['10-15 grams', '25-30 grams', '40-50 grams', '5-10 grams'],
        correctAnswer: 1,
        explanation: 'Adults should aim for 25-30 grams of fiber daily to support digestive health and prevent chronic diseases.',
      ),
      QuizQuestion(
        question: 'Which type of exercise is best for bone health?',
        options: [
          'Swimming',
          'Weight-bearing exercises',
          'Cycling',
          'Yoga only'
        ],
        correctAnswer: 1,
        explanation: 'Weight-bearing exercises like walking, running, and strength training are best for building and maintaining bone density.',
      ),
      QuizQuestion(
        question: 'What is the "fight or flight" response controlled by?',
        options: [
          'Digestive system',
          'Sympathetic nervous system',
          'Endocrine system',
          'Immune system'
        ],
        correctAnswer: 1,
        explanation: 'The "fight or flight" response is controlled by the sympathetic nervous system, which prepares the body for action.',
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
            Icon(Icons.favorite, color: Colors.red[600], size: 24),
            const SizedBox(width: 8),
            Text(
              'Health Quiz',
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
            Icon(Icons.favorite, color: Colors.red[600], size: 24),
            const SizedBox(width: 8),
            Text(
              'Health Quiz Results',
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
                    Colors.red[100]!,
                    Colors.orange[100]!,
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
                    'Health Champion!',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.red[700],
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
                          color: Colors.red[700],
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
                      color: Colors.red[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Level: $level',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      color: Colors.red[600],
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
                      side: BorderSide(color: Colors.red[300]!),
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
                        color: Colors.red[300],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[300],
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
    if (percentage >= 90) return 'Health Expert';
    if (percentage >= 80) return 'Health Pro';
    if (percentage >= 70) return 'Health Conscious';
    if (percentage >= 60) return 'Health Learner';
    return 'Health Beginner';
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