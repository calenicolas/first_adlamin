
const ipc = require("node-ipc");

ipc.config.id = "com.calenicolas.adlamin.daemon";
ipc.config.retry = 1500;

function connect(callback) {
    ipc.connectTo(
        "adlamin-daemon",
        () => successfulConnection(callback)
    );
}

function successfulConnection(callback) {
    ipc.of["adlamin-daemon"].on(
        "connect",
        function(){
            ipc.log("## connected to world ##".rainbow, ipc.config.delay);
            callback();
        }
    );

    ipc.of["adlamin-daemon"].on(
        "message",  //any event or message type your server listens for
        function(data){
            ipc.log("got a message from world : ".debug, data);
        }
    );
}

function send(topic, message) {
    ipc.of["adlamin-daemon"].emit(topic, message);
}

module.exports = {
    connect: connect,
    send: send
}