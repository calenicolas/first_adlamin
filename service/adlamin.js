
const readline = require("readline");
const client = require("./socket-client");

client.connect(onConnected);

function onConnected() {
    const clientArguments = process.argv.slice(2);
    const command = clientArguments[0];
    const commandArguments = clientArguments.slice(1);

    switch (command) {
      case "create":
        create(commandArguments);
        break;
      case "deploy":
        deploy(commandArguments);
        break;
      default:
        process.exit(0)
    }
}

function create(commandArguments) {
    if (commandArguments.length != 2) {
        throw new Error("Bad usage. The correct usage is `adlamin create url domain`");
    }
    client.send("create", commandArguments.concat([process.env.PWD]));
}

function deploy(commandArguments) {
    client.send("deploy", commandArguments);
}