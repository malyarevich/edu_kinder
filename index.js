var sql = require("seriate");

// Change the config settings to match your 
// SQL Server and database
var config = {  
    "server": "127.0.0.1",
    "user": "admins",
    "password": "password_123",
    "database": "Kinder_garden"
};

sql.setDefaultConfig( config );

sql.execute( {  
        query: "SELECT * FROM CHILD"
    } ).then( function( results ) {
        console.log( results );
    }, function( err ) {
        console.log( "Something bad happened:", err );
    } );
    
