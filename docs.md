```
POST /api/signin
```

**Request Body:**

```json
{
    "email": "islam@gmail.com",
    "password": "12345678"
}
```

**Response Body:**

- Status: `200`

```json
{
    "token": "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
}
```

```
POST /api/signup
```

**Request Body:**

```json
{
    "name": "islam",
    "email": "islam@gmail.com",
    "password": "12345678"
    "gender": "Male"
}
```

**Response Body:**

- Status: `201`

```json
{
    "token": "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
}
```

```

```
PATH /api/me
```

**Request Body:**

```json
{
    "password": "12341234"
}
```

**Response Body:**

- Status: `200`

```json
{
    user: {
        "id": 1,
        "name": "islam",
        "email": "islam@gmail.com",
        "password": "12341234",
        "gender": "Male"
    }
}
```

```
GET /api/questions
```

**Response Body:**

- Status: `200`

```json
{
    "questions": [
        {
            "id": "i-2",
            "question": "How do you react when plans don’t go as expected?",
            "options": [
                {
                    "answer": "A",
                    "text": "I adapt quickly and feel confident in finding a new solution"
                },
                {
                    "answer": "B",
                    "text": "I get anxious and feel uncertain about how to move forward"
                }
            ],
            "aspect": "Identity"
        },
        // more questions ...
    ]
}
```

```
POST /api/evaluate
```

**Request Body:**

```json
{
    "responses": {
        "e-1": "A",
        "e-2": "A",
        "e-3": "B",
        "e-4": "B",
        "e-5": "A",
        // more responses ...
    }
}
```

**Response Body:**

- Status: `200`

```json
{
  "personality": "Logistician",
  "traits": "ISTJ-A",
  "score": {
    "Energy": {
      "Introverted": 4,
      "Extraverted": 1
    },
    "Mind": {
      "Intuitive": 2,
      "Observant": 3
    },
    "Nature": {
      "Thinking": 3,
      "Feeling": 2
    },
    "Tactics": {
      "Judging": 4,
      "Prospecting": 1
    },
    "Identity": {
      "Assertive": 3,
      "Turbulent": 2
    }
  }
}
```

```
GET /api/me/personality
```

**Response Body:**

- Status: `200`

```json
{
  "personality": "Logistician",
  "traits": "ISTJ-A",
  "score": {
    "Energy": {
      "Introverted": 4,
      "Extraverted": 1
    },
    "Mind": {
      "Intuitive": 2,
      "Observant": 3
    },
    "Nature": {
      "Thinking": 3,
      "Feeling": 2
    },
    "Tactics": {
      "Judging": 4,
      "Prospecting": 1
    },
    "Identity": {
      "Assertive": 3,
      "Turbulent": 2
    }
  }
}
```
