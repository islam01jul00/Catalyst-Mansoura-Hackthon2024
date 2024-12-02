require("dotenv").config();

const express = require("express");
const morgan = require("morgan");
const { StatusCodes } = require("http-status-codes");

class HttpError extends Error {
  constructor(statusCode, message) {
    super(message);

    this.statusCode = statusCode;
  }
}

const PORT = process.env.PORT;

const app = express();

app.use(morgan("dev"));

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

const questions = [
  // Introverted (I) VS. Extraverted (E)
  {
    id: "e-1",
    question: "How do you feel after spending time with a group of people?",
    options: [
      { answer: "A", text: "Energized and excited" },
      { answer: "B", text: "Drained and needing some time alone" },
    ],
    aspect: "Energy",
  },
  {
    id: "e-2",
    question: "When faced with a new task, do you:",
    options: [
      {
        answer: "A",
        text: "Seek others' input and jump into action quickly",
      },
      {
        answer: "B",
        text: "Think it through on your own before taking action",
      },
    ],
    aspect: "Energy",
  },
  {
    id: "e-3",
    question: "Which of these activities would you prefer?",
    options: [
      { answer: "A", text: "Going to a party or social event" },
      {
        answer: "B",
        text: "Spending a quiet evening reading or watching a movie at home",
      },
    ],
    aspect: "Energy",
  },
  {
    id: "e-4",
    question: "How do you usually react in social situations?",
    options: [
      {
        answer: "A",
        text: "I enjoy talking to others and meeting new people",
      },
      {
        answer: "B",
        text: "I prefer to listen and engage in smaller, more meaningful conversations",
      },
    ],
    aspect: "Energy",
  },
  {
    id: "e-5",
    question: "When you need to recharge, you tend to:",
    options: [
      {
        answer: "A",
        text: "Go out with friends or participate in group activities",
      },
      {
        answer: "B",
        text: "Spend time alone or with just one close friend to relax",
      },
    ],
    aspect: "Energy",
  },
  // Intuitive (N) VS. Observant (S)
  {
    id: "m-1",
    question: "When you learn something new, do you prefer to:",
    options: [
      {
        answer: "A",
        text: "Focus on the big picture and future possibilities",
      },
      {
        answer: "B",
        text: "Focus on facts, details, and present realities",
      },
    ],
    aspect: "Mind",
  },
  {
    id: "m-2",
    question: "In problem-solving, do you tend to:",
    options: [
      {
        answer: "A",
        text: "Look for patterns and connections beyond the obvious",
      },
      {
        answer: "B",
        text: "Focus on the facts and what is directly in front of you",
      },
    ],
    aspect: "Mind",
  },
  {
    id: "m-3",
    question: "When recalling past experiences, do you tend to:",
    options: [
      {
        answer: "A",
        text: "Remember ideas and impressions more than exact details",
      },
      {
        answer: "B",
        text: "Remember specific details and events clearly",
      },
    ],
    aspect: "Mind",
  },
  {
    id: "m-4",
    question: "Which approach do you prefer in your daily life?",
    options: [
      { answer: "A", text: "Embracing new ideas and abstract concepts" },
      {
        answer: "B",
        text: "Sticking to practical, tried-and-true methods",
      },
    ],
    aspect: "Mind",
  },
  {
    id: "m-5",
    question: "How do you feel about change?",
    options: [
      {
        answer: "A",
        text: "Excited by new possibilities and abstract changes",
      },
      {
        answer: "B",
        text: "Prefer stability and prefer gradual, concrete change",
      },
    ],
    aspect: "Mind",
  },
  // Thinking (T) VS. Feeling (F)
  {
    id: "n-1",
    question: "When making decisions, do you tend to:",
    options: [
      { answer: "A", text: "Focus on logic and objective criteria" },
      {
        answer: "B",
        text: "Consider the feelings of others and personal values",
      },
    ],
    aspect: "Nature",
  },
  {
    id: "n-2",
    question: "In a group setting, you are more likely to:",
    options: [
      { answer: "A", text: "Emphasize fairness and principles" },
      {
        answer: "B",
        text: "Be considerate of others' emotions and well-being",
      },
    ],
    aspect: "Nature",
  },
  {
    id: "n-3",
    question: "When conflict arises, you typically:",
    options: [
      {
        answer: "A",
        text: "Look for the most logical and efficient solution",
      },
      {
        answer: "B",
        text: "Try to find a solution that preserves harmony and relationships",
      },
    ],
    aspect: "Nature",
  },
  {
    id: "n-4",
    question: "When giving feedback, do you prefer to:",
    options: [
      { answer: "A", text: "Be straightforward, even if it is critical" },
      {
        answer: "B",
        text: "Deliver it gently, considering the feelings of the other person",
      },
    ],
    aspect: "Nature",
  },
  {
    id: "n-5",
    question: "When making a tough decision, you are more likely to:",
    options: [
      {
        answer: "A",
        text: "Analyze the situation logically and use facts to guide you",
      },
      {
        answer: "B",
        text: "Think about how the decision will affect others emotionally",
      },
    ],
    aspect: "Nature",
  },
  // Judging (J) VS. Prospecting (P)
  {
    id: "t-1",
    question: "How do you prefer to approach a task?",
    options: [
      { answer: "A", text: "Plan it out and stick to a schedule" },
      {
        answer: "B",
        text: "Go with the flow and be flexible as things unfold",
      },
    ],
    aspect: "Tactics",
  },
  {
    id: "t-2",
    question: "When making plans, you tend to:",
    options: [
      {
        answer: "A",
        text: "Set clear goals and try to finish things ahead of time",
      },
      {
        answer: "B",
        text: "Keep your options open and adapt to new opportunities",
      },
    ],
    aspect: "Tactics",
  },
  {
    id: "t-3",
    question: "When facing a deadline, you are more likely to:",
    options: [
      {
        answer: "A",
        text: "Start early and complete everything well before the deadline",
      },
      {
        answer: "B",
        text: "Procrastinate and work well under pressure at the last minute",
      },
    ],
    aspect: "Tactics",
  },
  {
    id: "t-4",
    question: "How do you prefer to handle unexpected changes in plans?",
    options: [
      { answer: "A", text: "Stick to the original plan as much as possible" },
      { answer: "B", text: "Embrace the change and adapt to new situations" },
    ],
    aspect: "Tactics",
  },
  {
    id: "t-5",
    question: "In your daily life, you prefer:",
    options: [
      {
        answer: "A",
        text: "Having things organized and following a routine",
      },
      { answer: "B", text: "Being spontaneous and keeping options open" },
    ],
    aspect: "Tactics",
  },
  // Assertive (-A) vs. Turbulent (-T)
  {
    id: "i-1",
    question: "How do you feel when faced with a difficult situation?",
    options: [
      {
        answer: "A",
        text: "I stay calm and confident, handling it without much stress",
      },
      {
        answer: "B",
        text: "I tend to get stressed and overthink the situation",
      },
    ],
    aspect: "Identity",
  },
  {
    id: "i-2",
    question: "How do you react when plans don’t go as expected?",
    options: [
      {
        answer: "A",
        text: "I adapt quickly and feel confident in finding a new solution",
      },
      {
        answer: "B",
        text: "I get anxious and feel uncertain about how to move forward",
      },
    ],
    aspect: "Identity",
  },
  {
    id: "i-3",
    question: "When making a decision, do you tend to:",
    options: [
      {
        answer: "A",
        text: "Trust my ability to make the right choice and take action",
      },
      {
        answer: "B",
        text: "Doubt myself and spend a lot of time analyzing the options",
      },
    ],
    aspect: "Identity",
  },
  {
    id: "i-4",
    question: "How do you feel about feedback on your performance?",
    options: [
      {
        answer: "A",
        text: "I am confident in my work and take constructive criticism well",
      },
      {
        answer: "B",
        text: "I feel uneasy and get discouraged by negative feedback",
      },
    ],
    aspect: "Identity",
  },
  {
    id: "i-5",
    question: "When facing a challenge, your response is usually to:",
    options: [
      { answer: "A", text: "Stay calm, stay focused, and push through" },
      { answer: "B", text: "Feel overwhelmed and second-guess my abilities" },
    ],
    aspect: "Identity",
  },
];

const personalities = [
  //
  {
    name: "Architect",
    traits: "INTJ",
  },
  {
    name: "Logician",
    traits: "INTP",
  },
  {
    name: "Commander",
    traits: "ENTJ",
  },
  {
    name: "Debater",
    traits: "ENTP",
  },
  //
  {
    name: "Advocate",
    traits: "INFJ",
  },
  {
    name: "Mediator",
    traits: "INFP",
  },
  {
    name: "Protagonist",
    traits: "ENFJ",
  },
  {
    name: "Campaigner",
    traits: "ENFP",
  },
  //
  {
    name: "Logistician",
    traits: "ISTJ",
  },
  {
    name: "Defender",
    traits: "ISFJ",
  },
  {
    name: "Executive",
    traits: "ESTJ",
  },
  {
    name: "Consul",
    traits: "ESFJ",
  },
  {
    name: "Virtuoso",
    traits: "ISTP",
  },
  {
    name: "Adventurer",
    traits: "ISFP",
  },
  {
    name: "Entrepreneur",
    traits: "ESTP",
  },
  {
    name: "Entertainer",
    traits: "ESFP",
  },
];

app.get("/questions", (req, res) => {
  res.json({
    questions,
  });
});

app.post("/evaluate", (req, res) => {
  const { responses } = req.body;

  // Ensure all responses are provided
  if (!responses || Object.keys(responses).length !== questions.length) {
    throw new HttpError(
      StatusCodes.BAD_REQUEST,
      "All questions must be answered."
    );
  }

  const Energy = { Introverted: 0, Extraverted: 0 };
  const Mind = { Intuitive: 0, Observant: 0 };
  const Nature = { Thinking: 0, Feeling: 0 };
  const Tactics = { Judging: 0, Prospecting: 0 };
  const Identity = { Assertive: 0, Turbulent: 0 };

  // Calculate scores
  for (const id in responses) {
    const question = questions.find((q) => q.id === id);
    const answer = responses[id];

    if (!question) {
      throw new HttpError(
        StatusCodes.BAD_REQUEST,
        `Invalid question ID: ${id}`
      );
    }

    switch (question.aspect) {
      case "Energy":
        answer === "A" ? Energy.Introverted++ : Energy.Extraverted++;
        break;
      case "Mind":
        answer === "A" ? Mind.Intuitive++ : Mind.Observant++;
        break;
      case "Nature":
        answer === "A" ? Nature.Thinking++ : Nature.Feeling++;
        break;
      case "Tactics":
        answer === "A" ? Tactics.Judging++ : Tactics.Prospecting++;
        break;
      case "Identity":
        answer === "A" ? Identity.Assertive++ : Identity.Turbulent++;
        break;
    }
  }

  // Determine the personality type
  const personalityType = [
    Energy.Introverted > Energy.Extraverted ? "I" : "E",
    Mind.Intuitive > Mind.Observant ? "N" : "S",
    Nature.Thinking > Nature.Feeling ? "T" : "F",
    Tactics.Judging > Tactics.Prospecting ? "J" : "P",
  ].join("");

  // Find the matching personality
  const personality = personalities.find((p) => p.traits === personalityType);

  if (!personality) {
    throw new HttpError(
      StatusCodes.INTERNAL_SERVER_ERROR,
      "Failed to determine personality."
    );
  }

  res.status(StatusCodes.OK).json({
    personality: personality.name,
    traits:
      personality.traits +
      (Identity.Assertive > Identity.Turbulent ? "-A" : "-T"),
    Energy,
    Mind,
    Nature,
    Tactics,
    Identity,
  });
});

app.use((error, req, res, next) => {
  if (error instanceof HttpError) {
    res.status(error.statusCode).json({ message: error.message });
  }

  console.error(error);

  res.status(StatusCodes.INTERNAL_SERVER_ERROR).send({
    message: "An unexpected error has occurred.",
  });
});

app.listen(PORT, console.log(`server running on port ${PORT}`));
