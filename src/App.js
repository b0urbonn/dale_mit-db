// React Frontend Code
import React, { useState, useEffect } from 'react';
import axios from 'axios';
import './App.css';

const App = () => {
  const [students, setStudents] = useState([]);
  const [schedules, setSchedules] = useState([]);
  const [entries, setEntries] = useState([]);
  const [studentId, setStudentId] = useState('');
  const [currentEntry, setCurrentEntry] = useState(null);
  const [filterDate, setFilterDate] = useState('');

  useEffect(() => {
    fetchStudents();
    fetchSchedules();
    fetchEntries();
  }, []);

  const fetchStudents = async () => {
    const res = await axios.get('/api/students');
    setStudents(res.data);
  };

  const fetchSchedules = async () => {
    const res = await axios.get('/api/schedules');
    setSchedules(res.data);
  };

  const fetchEntries = async (date = '') => {
    const res = await axios.get(`/api/entries${date ? `?date=${date}` : ''}`);
    setEntries(res.data);
  };

  const handleTimeIn = async () => {
    const schedule = schedules.find(
      (sched) => sched.Student_ID === parseInt(studentId)
    );

    const purpose = schedule ? 'Scheduled Class' : 'Unscheduled';
    const newEntry = { studentId, timeIn: new Date(), purpose };
    const res = await axios.post('/api/entries', newEntry);
    setCurrentEntry(res.data);
    fetchEntries(filterDate);
  };

  const handleTimeOut = async () => {
    if (!currentEntry) return;

    const updatedEntry = { ...currentEntry, timeOut: new Date() };
    await axios.put(`/api/entries/${currentEntry.id}`, updatedEntry);
    setCurrentEntry(null);
    fetchEntries(filterDate);
  };

  return (
    <div className="App">
      <h1>Lab Attendance Management</h1>
      <div className="section">
        <h2>Lab Entry</h2>
        <input
          type="text"
          placeholder="Enter Student ID"
          value={studentId}
          onChange={(e) => setStudentId(e.target.value)}
        />
        <button onClick={handleTimeIn}>Time In</button>
        <button onClick={handleTimeOut}>Time Out</button>
      </div>
      <div className="section">
        <h2>Lab Entries</h2>
        <input
          type="date"
          value={filterDate}
          onChange={(e) => {
            setFilterDate(e.target.value);
            fetchEntries(e.target.value);
          }}
        />
        <table>
          <thead>
            <tr>
              <th>Student ID</th>
              <th>Time In</th>
              <th>Time Out</th>
              <th>Purpose</th>
            </tr>
          </thead>
          <tbody>
            {entries.map((entry) => (
              <tr key={entry.id}>
                <td>{entry.studentId}</td>
                <td>{new Date(entry.timeIn).toLocaleString()}</td>
                <td>{entry.timeOut ? new Date(entry.timeOut).toLocaleString() : '-'}</td>
                <td>{entry.purpose}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
      <div className="section">
        <h2>Students</h2>
        <button onClick={() => alert('Add Student feature coming soon!')}>Add Student</button>
        <ul>
          {students.map((student) => (
            <li key={student.id}>{student.name}</li>
          ))}
        </ul>
      </div>
      <div className="section">
        <h2>Class Schedules</h2>
        <button onClick={() => alert('Add Schedule feature coming soon!')}>Add Schedule</button>
        <ul>
          {schedules.map((schedule) => (
            <li key={schedule.id}>{`${schedule.Class_Name} - ${schedule.Day_of_Week} (${schedule.Start_Time} - ${schedule.End_Time})`}</li>
          ))}
        </ul>
      </div>
    </div>
  );
};

export default App;
