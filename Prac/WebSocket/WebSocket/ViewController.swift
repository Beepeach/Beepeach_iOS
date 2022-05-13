//
//  ViewController.swift
//  WebSocket
//
//  Created by JunHeeJo on 5/13/22.
//

import UIKit
import Starscream

class ViewController: UIViewController {
    private var socket: WebSocket?
    
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var echoLabel: UILabel!

    @IBAction func send(_ sender: Any) {
        sendMessage(text: inputField.text ?? "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        setupWebSocket()
    }
    
    // raw -> String으로 데이터가 옵니다.
    // raw/json -> Json으로 데이터가 옵니다.
    func setupWebSocket() {
        let url = URL(string: "wss://ws.postman-echo.com/raw")!
        var request = URLRequest(url: url)
        request.timeoutInterval = 5
        
        socket = WebSocket(request: request)
        socket?.delegate = self
        socket?.connect()
    }
    
    deinit {
        socket?.disconnect()
        socket?.delegate = nil
    }
    
    func sendMessage(text: String) {
        socket?.write(string: text)
    }
}


extension ViewController: WebSocketDelegate {
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .connected(let header):
            client.write(string: "Hi Echo")
            print("WebSocket is connected \(header)")
        case .disconnected(let reason, let code):
            print("WebSocket is disconnected \(reason) with code: \(code)")
        case .text(let text):
            print("Receive Text: \(text)")
            self.echoLabel.text = text
            
        case .binary(let data):
            print("Receive Binary: \(data)")
        case .pong(_):
            break
        case .ping(_):
            break
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            print("WebSocket is cancelld")
        case .error(let error):
            print("WebSocket is error \(error.debugDescription)")
        }
    }
}

