const express = require('express');
const mysql = require('mysql');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
app.use(bodyParser.json());
app.use(cors());

// MySQL connection
const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'new_password',
  database: 'lab_attendance'
});

db.connect(err => {
  if (err) throw err;
  console.log('Connected to database');
});

// Routes
app.get('/api/students', (req, res) => {
  const query = 'SELECT * FROM STUDENT_TABLE';
  db.query(query, (err, results) => {
    if (err) throw err;
    res.json(results);
  });
});

app.get('/api/schedules', (req, res) => {
  const query = 'SELECT * FROM CLASS_SCHEDULE_TABLE';
  db.query(query, (err, results) => {
    if (err) throw err;
    res.json(results);
  });
});

app.get('/api/entries', (req, res) => {
  const { date } = req.query;
  let query = 'SELECT * FROM LABORATORY_ENTRIES_TABLE';
  if (date) query += ` WHERE DATE(Entry_TimeIn) = '${date}'`;

  db.query(query, (err, results) => {
    if (err) throw err;
    res.json(results);
  });
});

app.post('/api/entries', (req, res) => {
  const { studentId, timeIn, purpose } = req.body;
  const query = 'INSERT INTO LABORATORY_ENTRIES_TABLE (Student_ID, Entry_TimeIn, Purpose) VALUES (?, ?, ?)';
  db.query(query, [studentId, timeIn, purpose], (err, result) => {
    if (err) throw err;
    res.json({ id: result.insertId, studentId, timeIn, purpose });
  });
});

app.put('/api/entries/:id', (req, res) => {
  const { id } = req.params;
  const { timeOut } = req.body;
  const query = 'UPDATE LABORATORY_ENTRIES_TABLE SET Entry_TimeOut = ? WHERE Entry_ID = ?';
  db.query(query, [timeOut, id], (err, result) => {
    if (err) throw err;
    res.json({ id, timeOut });
  });
});

// Start server
const PORT = 5000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
