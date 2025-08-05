import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
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
    // Beginner Level
    [
      QuizQuestion(
        question: 'What is menstruation?',
        options: [
          'The release of an egg',
          'The shedding of the uterine lining',
          'Ovulation',
          'Pregnancy'
        ],
        correctAnswer: 1,
        explanation: 'Menstruation is the shedding of the uterine lining that occurs when pregnancy doesn\'t happen.',
      ),
      QuizQuestion(
        question: 'How long does the average menstrual cycle last?',
        options: ['10 days', '28 days', '40 days', '7 days'],
        correctAnswer: 1,
        explanation: 'The average menstrual cycle is 28 days, though it can vary between 21-35 days.',
      ),
      QuizQuestion(
        question: 'Which hormone plays a key role in triggering ovulation?',
        options: ['Progesterone', 'LH (Luteinizing Hormone)', 'Estrogen', 'Testosterone'],
        correctAnswer: 1,
        explanation: 'LH (Luteinizing Hormone) surge triggers ovulation by causing the mature egg to be released.',
      ),
      QuizQuestion(
        question: 'What is the average duration of a menstrual period?',
        options: ['1-2 days', '3-7 days', '8-10 days', '10+ days'],
        correctAnswer: 1,
        explanation: 'The average menstrual period lasts 3-7 days.',
      ),
      QuizQuestion(
        question: 'True or False: PMS (Premenstrual Syndrome) happens before menstruation starts.',
        options: ['True', 'False'],
        correctAnswer: 0,
        explanation: 'True! PMS occurs in the days leading up to menstruation, typically 1-2 weeks before.',
      ),
    ],
    // Intermediate Level
    [
      QuizQuestion(
        question: 'Can stress affect your menstrual cycle?',
        options: ['Yes', 'No'],
        correctAnswer: 0,
        explanation: 'Yes! Stress can cause irregular periods, missed periods, or changes in cycle length.',
      ),
      QuizQuestion(
        question: 'Which of these is a common PMS symptom?',
        options: ['Bloating', 'Mood swings', 'Headaches', 'All of the above'],
        correctAnswer: 3,
        explanation: 'All of the above! PMS can cause physical symptoms like bloating and headaches, as well as emotional symptoms like mood swings.',
      ),
      QuizQuestion(
        question: 'True or False: You cannot get pregnant during your period.',
        options: ['True', 'False'],
        correctAnswer: 1,
        explanation: 'False! While less likely, it\'s still possible to get pregnant during your period, especially if you have a short cycle.',
      ),
      QuizQuestion(
        question: 'Which of these is NOT a menstrual product?',
        options: ['Tampon', 'Menstrual cup', 'Pad', 'Insulin pen'],
        correctAnswer: 3,
        explanation: 'Insulin pen is a medical device for diabetes, not a menstrual product.',
      ),
      QuizQuestion(
        question: 'What causes menstrual cramps?',
        options: [
          'Muscle spasms in the uterus',
          'Dehydration',
          'Ovaries shrinking',
          'Stomach issues'
        ],
        correctAnswer: 0,
        explanation: 'Menstrual cramps are caused by muscle spasms in the uterus as it contracts to shed the lining.',
      ),
      QuizQuestion(
        question: 'Which vitamin/mineral is most important for replenishment during menstruation?',
        options: ['Iron', 'Calcium', 'Vitamin D', 'Magnesium'],
        correctAnswer: 0,
        explanation: 'Iron is crucial during menstruation as blood loss can lead to iron deficiency.',
      ),
    ],
    // Pro Level
    [
      QuizQuestion(
        question: 'Which hormone rises during the luteal phase?',
        options: ['Estrogen', 'Progesterone', 'LH', 'FSH'],
        correctAnswer: 1,
        explanation: 'Progesterone rises during the luteal phase to prepare the uterus for potential pregnancy.',
      ),
      QuizQuestion(
        question: 'What is the average age range for menopause?',
        options: ['25–30', '40–60', '60–75', '30–35'],
        correctAnswer: 1,
        explanation: 'The average age range for menopause is 40-60 years, with the average being around 51.',
      ),
      QuizQuestion(
        question: 'What is PCOS (Polycystic Ovary Syndrome) primarily associated with?',
        options: ['High insulin levels', 'Irregular ovulation', 'Excess androgens', 'All of the above'],
        correctAnswer: 3,
        explanation: 'PCOS is associated with all of these: high insulin levels, irregular ovulation, and excess androgens.',
      ),
      QuizQuestion(
        question: 'Which cycle phase is best for strength training and high-energy workouts?',
        options: ['Menstrual phase', 'Follicular phase', 'Luteal phase', 'Ovulatory phase'],
        correctAnswer: 1,
        explanation: 'The follicular phase is ideal for strength training as estrogen levels are rising, providing more energy and strength.',
      ),
      QuizQuestion(
        question: 'True or False: A 28-day cycle is the only "normal" cycle length.',
        options: ['True', 'False'],
        correctAnswer: 1,
        explanation: 'False! While 28 days is average, cycles between 21-35 days are considered normal.',
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
            Icon(Icons.emoji_people, color: Colors.brown[600], size: 24),
            const SizedBox(width: 8),
            Text(
              'Quiz Hub',
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
            Icon(Icons.emoji_people, color: Colors.brown[600], size: 24),
            const SizedBox(width: 8),
            Text(
              'Quiz Results',
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
                    Colors.pink[100]!,
                    Colors.purple[100]!,
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
                    'Congratulations!',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple[700],
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
                          color: Colors.purple[700],
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
                      color: Colors.purple[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Level: $level',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      color: Colors.purple[600],
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
                      side: BorderSide(color: Colors.pink[300]!),
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
                        color: Colors.pink[300],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink[300],
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Back to Home',
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
    if (percentage >= 90) return 'Expert';
    if (percentage >= 80) return 'Advanced';
    if (percentage >= 70) return 'Intermediate';
    if (percentage >= 60) return 'Beginner';
    return 'Novice';
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