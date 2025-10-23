// Tea Order API
// Transaction simulation
// npm init -y
// npm install dotenv mysql2

require('dotenv').config()
const mysql = require('mysql2/promise')
console.log("DB_USER:", process.env.DB_USER);

async function orderTea(teaType, orderQuantity) { 

    const connection = await mysql.createConnection({
    host: "localhost", // MySQL server host
    user: process.env.DB_USER, // MySQL user
    password: process.env.DB_PASSWORD, // MySQL password
    database: process.env.DB_DATABASE, // MySQL database name
    });

    console.log('Connected to database') 

    try {
        await connection.beginTransaction()
        console.log('Starting transaction')

        //check tea stock
        const [stockRows] = await connection.query(
            `SELECT tea_quantity FROM stock WHERE tea_type = ? FOR UPDATE`, 
            [teaType]
        )
        const currentStock = stockRows[0].tea_quantity
        console.log(`Current stock for ${teaType}: ${currentStock}`)

        if (orderQuantity > currentStock) {
            throw new Error(`Insufficient ${teaType} stock`)
        }

        //create the order
        await connection.query(`INSERT INTO orders (order_quantity, tea_type) VALUES (? , ?)`,
            [orderQuantity, teaType] 
        )
        console.log(`Order created for ${orderQuantity} boxes of ${teaType}`)

        // deduct stock
        await connection.query(`UPDATE stock SET tea_quantity = tea_quantity - ? WHERE tea_type = ?`, 
            [orderQuantity, teaType]
        )

        //commit transaction
        await connection.commit()
        console.log('Transaction completed successfully')
        
    } catch (err) {
        // rollback if any step fails
        await connection.rollback()
        console.error('Transaction rolled back due to error:', err.message)
    } finally {
        await connection.end()
        console.log(`Connection ended`)
    }
}

orderTea('Earl Grey', 40)

