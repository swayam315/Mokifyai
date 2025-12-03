CREATE DATABASE IF NOT EXISTS mokify;
USE mokify;

CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  username VARCHAR(100) NOT NULL UNIQUE,
  email VARCHAR(150) NOT NULL UNIQUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS interviews (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  mode VARCHAR(50),
  company_name VARCHAR(150),
  role VARCHAR(150),
  round_name VARCHAR(150),
  question_id INT,
  score INT NOT NULL,
  resume_score INT,
  feedback TEXT,
  strengths_json TEXT,
  weaknesses_json TEXT,
  improvement_plan_json TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS question_progress (
  user_id INT NOT NULL,
  question_id INT NOT NULL,
  status ENUM('locked','unlocked','solved') NOT NULL DEFAULT 'locked',
  solved_at TIMESTAMP NULL,
  PRIMARY KEY (user_id, question_id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);
