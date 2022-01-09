
const ipc = require('node-ipc').default;

ipc.config.id = "com.calenicolas.adlamin.daemon";
ipc.config.retry = 1500;

function connect(callback) {
    ipc.connectTo(
        "com.calenicolas.adlamin.daemon",
        () => successfulConnection(callback)
    );
}

function successfulConnection(callback) {
    ipc.of["com.calenicolas.adlamin.daemon"].on(
        "connect",
        function(){
            callback();
        }
    );

    ipc.of["com.calenicolas.adlamin.daemon"].on(
        "message",  //any event or message type your server listens for
        function(data){
            ipc.log("got a message from world : ".debug, data);
        }
    );
}

function send(topic, message) {
    ipc.of["com.calenicolas.adlamin.daemon"].emit(topic, message);
}

module.exports = {
    connect: connect,
    send: send
}