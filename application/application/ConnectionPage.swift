//
//  ConnectionPage.swift
//  application
//
//  Created by Betul on 5/10/23.
//

import MultipeerConnectivity
import SQLite

class ConnectionPage: UIViewController,MCSessionDelegate, MCBrowserViewControllerDelegate, MCNearbyServiceAdvertiserDelegate  {
    var database2: Connection!
    let transactionTable = Table("Transaction")
    let transactionId = Expression<String>("transactionId")
    let amount = Expression<Double>("amount")
    let passengerId = Expression<String>("passengerId")
    @IBOutlet weak var numLabel: UILabel!
    var peerID: MCPeerID!
    var mcSession: MCSession!
    var mcAdvertiserAssistant: MCNearbyServiceAdvertiser!
    var number = 0
    var transactionStr = ""
    var count = 0
    @IBOutlet weak var transactionText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        connectDatabase2()
        peerID = MCPeerID(displayName: UIDevice.current.name)
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        mcSession.delegate = self
        startHosting()
    }
    
    func connectDatabase2(){
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            
            let fileUrl = documentDirectory.appendingPathComponent("Transaction").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database2 = database
        } catch {
            print(error)
        }
    }
    
    @IBAction func connectButtonClicked(_ sender: UIButton) {
        let ac = UIAlertController(title: "Connect to others", message: nil, preferredStyle: .alert)
         ac.addAction(UIAlertAction(title: "Host a session", style: .default) {
             //here we will add a closure to host a session
            (UIAlertAction) in
             self.startHosting()
       })
         ac.addAction(UIAlertAction(title: "Join a session", style: .default) {
             //here we will add a closure to join a session
             (UIAlertAction) in
             self.joinSession()
         })
         ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
         present(ac, animated: true)
    }
    
    @IBAction func sendButtonAction(_ sender: Any) {
        //send data to the other device
        //number = number + 1
        //transactionStr = ""
        /*
        do {
            for transaction in try database2.prepare(transactionTable) {
                let transactionAmount = transaction[amount]
                let transactionId = transaction[transactionId]
            
                
                let formattedId = transactionId.replacingOccurrences(of: " +0000", with: "")

               transactionStr += "Date: " + formattedId + " Amount: " + String(transactionAmount) + "₺\n"
               //print(transactionStr)
            }
        } catch {
            // Handle any errors that occur
            print("Error: \(error)")
        }
        */
        //let count = 2
        let connectedPeers = mcSession.connectedPeers
        let deviceCountToSend = connectedPeers.count / 2
        //if connectedPeers.count >= count {
            var randomPeers = Set<MCPeerID>()
            while randomPeers.count < deviceCountToSend {
                let randomIndex = Int(arc4random_uniform(UInt32(connectedPeers.count)))
                let randomPeer = connectedPeers[randomIndex]
                randomPeers.insert(randomPeer)
            }
            count = count + 1
            let countStr = "\(count)"
            let data = countStr.data(using: .utf8)!
        
            do {
                try mcSession.send(data, toPeers: Array(randomPeers), with: .reliable)
            } catch {
                print("Error sending data: \(error.localizedDescription)")
            }
        //} else {
        //    print("Not enough connected peers to send data to.")
        //}
        //sendData(data: transactionStr)
        //sendData(data: "\(number)")
    }
    
    func startHosting() {
        mcAdvertiserAssistant = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: "mp-numbers")
        mcAdvertiserAssistant.delegate = self
        mcAdvertiserAssistant.startAdvertisingPeer()
    }
    
    //join a room
    func joinSession() {
        let mcBrowser = MCBrowserViewController(serviceType: "mp-numbers", session: mcSession)
        mcBrowser.delegate = self
        present(mcBrowser, animated: true)
    }
    //send data to other users
    func sendData(data: String) {
        if mcSession.connectedPeers.count > 0 {
            if let textData = data.data(using: .utf8) {
                do {
                    //send data
                    try mcSession.send(textData, toPeers: mcSession.connectedPeers, with: .reliable)
                } catch let error as NSError {
                    //error sending data
                    print(error.localizedDescription)
                }
            }
        }
    }
    // MARK: - Session Methods
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case MCSessionState.connected:
            print("Connected: \(peerID.displayName)")
            
        case MCSessionState.connecting:
            print("Connecting: \(peerID.displayName)")
            
        case MCSessionState.notConnected:
            print("Not connected: \(peerID.displayName)")
            
        @unknown default:
            fatalError()
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        //data received
        if let text = String(data: data, encoding: .utf8) {
            DispatchQueue.main.async {
                //display the text in the label
                self.transactionText.text = text
            }
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
    
    // MARK: - Browser Methods
    
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    
    // MARK: - Advertiser Methods
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        //accept the connection/invitation
        invitationHandler(true, mcSession)
    }
        
}
