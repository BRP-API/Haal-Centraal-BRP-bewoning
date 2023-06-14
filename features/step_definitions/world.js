class World {
    constructor(parameters) {
        this.context = parameters;
        this.context.apiUrl = "http://localhost:8000/haalcentraal/api/bewoning";
        this.context.sql = {
            useDb: true,
            logStatements: false,
            cleanup: true,
            poolConfig: {
                user: "",
                host: "",
                database: "rvig_haalcentraal_testdata",
                password: "",
                port: 5432,
                allowExitOnIdle: true
            }
        };
    }
}

module.exports = {World}

