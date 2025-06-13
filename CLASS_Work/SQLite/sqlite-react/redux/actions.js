export const setDb = (db) => ({
    type: 'SET_DB',
    payload: db,
})

export const setTables = tables => ({
    type: 'SET_TABLES',
    payload: tables
})

export const setQuery = query => ({
    type: 'SET_QUERY',
    payload: query
})

export const setResult = result => ({
    type: 'SET_RESULT',
    payload:result
})

export const initDataBase = () => {
    return async (dispatch) => {
        const SQL = await window.initSqlJs({
            locateFile: file => `https://sql.js.org/dist/${file}`
        })

        const db = 

         db.run(`
        CREATE TABLE employees (
          id INTEGER PRIMARY KEY,
          name TEXT,
          age INTEGER,
          salary INTEGER,
          department_id INTEGER
        );
      `);

      // Создаём таблицу отделов
      db.run(`
        CREATE TABLE departments (
          id INTEGER PRIMARY KEY,
          name TEXT
        );
      `);

      // Вставляем данные в таблицу departments
      db.run(`
        INSERT INTO departments (id, name) VALUES
          (1, 'HR'),
          (2, 'IT'),
          (3, 'Marketing');
      `);
       // Данные для таблицы сотрудников (включая связи с отделами)
      const employees = [
        [1, "Alice", 25, 50000, 1],
        [2, "Bob", 30, 60000, 2],
        [3, "Charlie", 35, 70000, 2],
        [4, "David", 40, 80000, 3],
        [5, "Eve", 45, 90000, 1],
      ];

    }
}