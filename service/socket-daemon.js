
const ipc = require('node-ipc').default;
const { exec } = require("child_process");

ipc.config.id = "com.calenicolas.adlamin.daemon";
ipc.config.retry = 1500;

ipc.serve(() => {

    ipc.server.on('create', (data,socket) => {
        run("/usr/local/sbin/adlamin_create_service " + data.join(" "));
    });

    ipc.server.on('socket.disconnected', (socket, destroyedSocketID) => {
        ipc.log('client ' + destroyedSocketID + ' has disconnected!');
    });
});

ipc.server.start();

function run(command) {
    exec(command, (error, stdout, stderr) => {
        if (error) {
            console.error(`error: ${error.message}`);
            return;
        }
        if (stderr) {
            console.error(`stderr: ${stderr}`);
            return;
        }
        console.log(`stdout: ${stdout}`);
    });
}