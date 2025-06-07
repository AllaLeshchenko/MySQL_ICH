import { useState, useEffect } from 'react' 
import initSqlJs from "sql.js";

function App() {
  // Состояние для базы данных SQLite
  const [db, setDb] = useState(null)

  // Состояние для текущего SQL-запроса
  const [query, setQuery] = useState("SELECT * FROM employees;")

  // Состояния для результата выполнения SQL-запроса
  const [result, setResult] = useState(null)

  // Состояние для таблиц с данными (будет массив обьектов: таблица + колонки + строки)
  const [tablesWithData, setTablesWithData] = useState([])

  // Хук, который выполнится один раз после монтирования компонента
  useEffect(()=>{
   // Загружаем и инициализируем SQLite через WebAssembly
     initSqlJs({locateFile: file => `https://sql.js.org/dist/${file}`}).then(SQL => {
      // Создаем новую базу данных в оперативной памяти
      const db = new SQL.Database();

      // Создаем таблицу сотрудников
      db.run(`
         CREATE TABLE employees (
           id INTENGER Primary KEY AUTOINCREMENT,
           name VARCHAR(100) NOT NULL,
           age INT,
           salary INT NOT NULL,
           department_id INT
          );
        `);

        // Создаем таблицу отделов
        db.run(`
            CREATE TABLE departments (
             id INTENGER Primary KEY AUTOINCREMENT,
             name VARCHAR(100) NOT NULL,
            );
          `);

        // Вставляем данные в таблицу departments
        db.run(`
            INSERT INTO departments (name) VALUES 
            ('HR'), 
            ('IT'), 
            ('Marketing');
          `);

        // Данные для таблицы сотрудникоы(включая связи сотделами)
        const employees = [
          ['Alice', 25, 50000, 1],
          ['Bob', 30, 60000, 2],
          ['Charlie', 35, 70000, 2],
          ['John', 40, 80000, 3],
          ['Eve', 45, 90000, 1]
        ];

        //Готовим выражения для вставки строк в таблицу tmployees
        const stmt = db.prepare("INSERT INTO employees (name, age, salary, department_id) VALUES (?, ?, ?, ?)");
        // Вставляем каждую строку
        for (let row of employees) {
          stmt.run(row)
        }

        // Освобождаем ресурсы после вставки
        stmt.free();

        // Сохраняем базу данных в состояние
        setDb(db);

        // Получить список таблиц, исключаем системные таблицы
        const tableRes = db.exec("SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'; ");
        console.log('tableRes:' + tableRes);
        // Извлекаем название таблиц
        const tables = tableRes[0]?.values.map(row => row[0]) || [];
        // values => [['employees'], ['departmens']]

        // Для каждой таблицы извлекаем данные
        const dataPerTable = tables.map(table => {
          const res = db.exec(`SELECT * FROM ${table}`);
          console.log('res:' + res);
          return {
            name: table, 
            columns: res[0]?.columns || [],
            rows: res[0]?.values || [],
          }
        });

        // Сохранение данных всех таблиц в состояние
        setTablesWithData(dataPerTable);
     });
  }, []);

  // Создадим функцию выполнения SQL-запроса по кнопке
  const execute = () => {
    try {
      // Выполныть SQL-запрос
      const res = db.exec(query);
      console.log('res[0:' + res[0])
      // Сохраняем первую талицу результатов
      setResult(res[0] || {colimns: [], valies: []});
    } catch (error) {
       // В случае ошибки сохраняем сообщение об ошибке, как результат
       setResult({columns: ['Error'], values: [error.message]})
    }
  };

 return (
   <div style={{padding: 20}}>
     <h2>SQLite + React: таблици с данными и SQL-запросы</h2>

     {/* Вывод всех таблиц и их содержимое */}

     <div style={{marginBottom: 30}}>
      <h3>Все таблицы в базе</h3>
        {tablesWithData.map(table => (
          <div key={table.name} style={{marginTop: 20}}>
            <h4>{table.name}</h4>
            <table border="1" cellPadding="5">
              <thead>
                <tr>
                  {table.columns.map(col => (
                    <th key={col}>{col}</th> // Название колонок
                  ))}
                </tr>
              </thead>
              <tbody>
                {table.rows.map((row, idx) => (
                  <tr key={idx}>
                    {row.map((val, i) => (
                      <td key={i}>{val}</td> // Ячейка таблицы
                    ))}
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        ))}
     </div>
 
     {/* Поле для выполнения произвольныч SQL-запросов */}
     <textarea 
       rows={6}
       style={{width: '100%', fontFamily: 'monospace'}}
       value={query}
       onChange={event => setQuery(event.target.value)}
     />

    <div style={{marginTop: 10}}>
      <button onClick={execute}>Execute</button>
    </div>

    {/* Результат выполнения SQL-запросов */}
    {result && (
      <div style={{marginTop: 30}}>
        <h4>Результат запроса:</h4>
         <table border="1" cellPadding="5">
              <thead>
                <tr>
                  {result.columns.map(col => (
                    <th key={col}>{col}</th> // Название колонок
                  ))}
                </tr>
              </thead>
              <tbody>
                {result.values.map((row, idx) => (
                  <tr key={idx}>
                    {row.map((val, i) => (
                      <td key={i}>{val}</td> // Ячейка таблицы
                    ))}
                  </tr>
                ))}
              </tbody>
          </table>
      </div>
    )}

   </div>
 )
}

export default App
