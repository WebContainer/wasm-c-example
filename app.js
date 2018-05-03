const {app, BrowserWindow} = require('electron')

const express = require('express')
const server = express()

express.static.mime.types['wasm'] = 'application/wasm' 

server.use(express.static('.'))

function createWindow () {
    server.listen(8000, () => {        
        console.log('Server Listening')
        
        const win = new BrowserWindow({width: 800, height: 600})
        
        win.loadURL('http://localhost:8000/')
        win.webContents.openDevTools()
    })
}
  
app.on('ready', createWindow)
