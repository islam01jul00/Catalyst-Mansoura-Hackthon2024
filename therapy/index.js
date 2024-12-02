import dotenv from "dotenv";
dotenv.config();

import express from "express";
import mongoose from "mongoose";
import { v4 as uuid } from "uuid";
import jwt from "jsonwebtoken";
import asyncHandler from "express-async-handler";
import fetch from "node-fetch";
import bcrypt from "bcryptjs";
import validator from "validator";

const PORT = process.env.PORT;
const MONGO_URI = process.env.MONGO_URI;
const JWT_SECRET = process.env.JWT_SECRET;

class HttpError extends Error {
  constructor(statusCode, message) {
    super(message);

    this.statusCode = statusCode;
  }
}

// Database

const userSchema = new mongoose.Schema({
  _id: {
    type: String,
    default: uuid,
  },
  name: {
    type: String,
    required: true,
  },
  email: {
    type: String,
    required: true,
    unique: true,
  },
  hash: {
    type: String,
    required: true,
  },
  gender: {
    type: String,
    required: true,
  },
  personality: {
    type: String,
    required: true,
    default: "Unknown",
  },
  traits: {
    type: String,
    required: true,
    default: "Unknown",
  },
  Energy: {
    Introverted: {
      type: Number,
      default: 0,
    },
    Extraverted: {
      type: Number,
      default: 0,
    },
  },
  Mind: {
    Intuitive: {
      type: Number,
      default: 0,
    },
    Observant: {
      type: Number,
      default: 0,
    },
  },
  Nature: {
    Thinking: {
      type: Number,
      default: 0,
    },
    Feeling: {
      type: Number,
      default: 0,
    },
  },
  Tactics: {
    Judging: {
      type: Number,
      default: 0,
    },
    Prospecting: {
      type: Number,
      default: 0,
    },
  },
  Identity: {
    Assertive: {
      type: Number,
      default: 0,
    },
    Turbulent: {
      type: Number,
      default: 0,
    },
  },
});

const User = mongoose.model("User", userSchema);

// Server

const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Middlewares

const auth = asyncHandler(async (req, res, next) => {
  const authHeader = req.headers.authorization;

  if (!authHeader || !authHeader.startsWith("Bearer ")) {
    throw new HttpError(401, "Authorization token is missing or invalid.");
  }

  const token = authHeader.split(" ")[1];

  try {
    const decoded = jwt.verify(token, JWT_SECRET);
    const user = await User.findById(decoded.id);

    console.log(user);

    if (!user) {
      throw new HttpError(404, "User not found.");
    }

    req.user = user;

    next();
  } catch (error) {
    throw new HttpError(401, "Invalid or expired token.");
  }
});

// Endpoints

app.post(
  "/api/signup",
  asyncHandler(async (req, res) => {
    const { name, email, password, gender } = req.body;

    console.log(req.body);

    if (name === undefined) {
      throw new HttpError(400, "name is required");
    }

    if (email === undefined) {
      throw new HttpError(400, "email is required");
    }

    if (password === undefined) {
      throw new HttpError(400, "password is required");
    }

    if (gender === undefined) {
      throw new HttpError(400, "name is required");
    }

    const user = await User.findOne({ email });

    if (user) {
      throw new HttpError(409, "Email already exists.");
    }

    const hash = bcrypt.hashSync(password, bcrypt.genSaltSync());

    const createdUser = await User.create({
      name,
      email,
      hash,
      gender,
    });

    const token = jwt.sign({ id: createdUser._id }, JWT_SECRET);

    return res.status(201).json({ token });
  })
);

app.post(
  "/api/signin",
  asyncHandler(async (req, res) => {
    const { email, password } = req.body;

    const user = await User.findOne({ email });

    if (!user || !bcrypt.compareSync(password, user.hash)) {
      throw new HttpError(400, "Invalid email or password");
    }

    const token = jwt.sign({ id: user._id }, JWT_SECRET);

    return res.status(200).json({ token });
  })
);

app.get("/api/me", auth, (req, res) => {
  const user = req.user;

  res.status(200).json({
    user: {
      id: user._id,
      name: user.name,
      email: user.email,
      gender: user.gender,
    },
  });
});

app.patch(
  "/api/me",
  auth,
  asyncHandler(async (req, res) => {
    const user = req.user;

    const { name, email, password, gender } = req.body;

    if (name !== undefined) {
      user.name = name;
    }

    if (email !== undefined) {
      user.email = email;
    }

    if (password !== undefined) {
      user.password = password;
    }

    if (gender !== undefined) {
      user.gender = gender;
    }

    await user.save();

    return res.status(200).json({
      user: {
        id: user._id,
        name: user.name,
        email: user.email,
        gender: user.gender,
      },
    });
  })
);

app.get(
  "/api/questions",
  asyncHandler(async (req, res) => {
    const response = await fetch("http://localhost:8001/questions");

    if (response.status !== 200) {
      const body = await response.json();

      throw new HttpError(response.status, body.message);
    }

    const body = await response.json();

    res.status(200).json(body);
  })
);

app.post(
  "/api/evaluate",
  auth,
  asyncHandler(async (req, res) => {
    const user = req.user;
    const { responses } = req.body;

    const response = await fetch("http://localhost:8001/evaluate", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ responses }),
    });

    if (response.status !== 200) {
      const body = await response.json();

      throw new HttpError(response.status, body.message);
    }

    const body = await response.json();

    user.personality = body.personality;
    user.traits = body.traits;
    user.Energy = body.Energy;
    user.Mind = body.Mind;
    user.Nature = body.Nature;
    user.Tactics = body.Tactics;
    user.Identity = body.Identity;

    await user.save();

    res.status(200).json(body);
  })
);

app.get("/api/me/personality", auth, (req, res) => {
  const user = req.user;

  res.status(200).json({
    personality: user.personality,
    traits: user.traits,
    Energy: user.Energy,
    Mind: user.Mind,
    Nature: user.Nature,
    Tactics: user.Tactics,
    Identity: user.Identity,
  });
});

app.use((error, req, res, next) => {
  if (error instanceof HttpError) {
    res.status(error.statusCode).json({ message: error.message });
  }

  console.error(error);

  res.status(500).send({
    message: "An unexpected error has occurred.",
  });
});

const bootstrap = async () => {
  try {
    await mongoose.connect(MONGO_URI);

    console.log("DB connected");

    app.listen(PORT, () => {
      console.log(`server running on port ${PORT}`);
    });
  } catch (error) {
    console.error(error);

    process.exit(1);
  }
};

bootstrap();
