const ipc = require('node-ipc');

ipc.config.id = "com.calenicolas.adlamin.daemon";
ipc.config.retry = 1500;

ipc.serve(() => {
    ipc.server.on('message', (data,socket) => {
        ipc.log('got a message : '.debug, data);
        ipc.server.emit(socket, 'message', data+' world!');
    });

    ipc.server.on('socket.disconnected', (socket, destroyedSocketID) => {
        ipc.log('client ' + destroyedSocketID + ' has disconnected!');
    });
});

ipc.server.start();
