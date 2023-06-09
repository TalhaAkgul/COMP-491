//
//  SessionManager.swift
//  application
//
//  Created by Doga Ege Inhanli on 12.05.2023.
//

import MultipeerConnectivity
import SQLite

class SessionManager: NSObject, MCSessionDelegate, MCBrowserViewControllerDelegate, MCNearbyServiceAdvertiserDelegate  {
    
    
    static let shared = SessionManager() // Singleton instance

    var peerID: MCPeerID!
    var mcSession: MCSession!
    var mcAdvertiserAssistant: MCNearbyServiceAdvertiser!
    
    var database2: Connection!
    let transactionTable = Table("Transaction")
    let transactionId = Expression<String>("transactionId")
    let amount = Expression<Double>("amount")
    let passengerId = Expression<String>("passengerId")
    var transactionLocalCount = 0
    let requestString = "Sync my transactions"
    var deviceCountToSend = 0
    static var closeOperation = false
    static var closeCompleted = false
    private override init() {
        super.init()
        connectDatabase2()
        peerID = MCPeerID(displayName: UIDevice.current.name)
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        mcSession.delegate = self
        startHosting()
        
    }
    
    func sendTransactions(){
        let connectedPeers = mcSession.connectedPeers
        let deviceCountToSend = connectedPeers.count / 2
        var randomPeers = Set<MCPeerID>()
        while randomPeers.count < deviceCountToSend {
            let randomIndex = Int(arc4random_uniform(UInt32(connectedPeers.count)))
            let randomPeer = connectedPeers[randomIndex]
            randomPeers.insert(randomPeer)
        }
        
        let query = transactionTable.select(transactionId, amount, passengerId)
        let transactions = try! database2.prepare(query).map { row in
            return TransactionJSONData(
                transactionId: row[transactionId],
                amount: row[amount],
                passengerId: row[passengerId]
            )
        }
        let encoder = JSONEncoder()
        
        let transactionData = try! encoder.encode(transactions)
        do {
            try mcSession.send(transactionData, toPeers: Array(randomPeers), with: .reliable)
            
        } catch {
            print(error)
        }
    }
    
    func sendSyncRequest(){
        let connectedPeers = mcSession.connectedPeers
        deviceCountToSend = connectedPeers.count / 2
        var randomPeers = Set<MCPeerID>()
        while randomPeers.count < deviceCountToSend {
            let randomIndex = Int(arc4random_uniform(UInt32(connectedPeers.count)))
            let randomPeer = connectedPeers[randomIndex]
            randomPeers.insert(randomPeer)
        }
        let requestData = requestString.data(using: .utf8)!

        do {
            try mcSession.send(requestData, toPeers: Array(randomPeers), with: .reliable)
        } catch {
            print(error)
        }
        /*
        while(SessionManager.receivedCount < deviceCountToSend){
            
        }
        SessionManager.receivedCount = 0
         */
    }
    
    func startHosting() {
        mcAdvertiserAssistant = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: "mp-numbers")
        mcAdvertiserAssistant.delegate = self
        mcAdvertiserAssistant.startAdvertisingPeer()
    }
    
    func joinSession(fromViewController viewController: UIViewController) {
        let mcBrowser = MCBrowserViewController(serviceType: "mp-numbers", session: mcSession)
        mcBrowser.delegate = self
        viewController.present(mcBrowser, animated: true)
    }
    
    func connectDevice(fromViewController viewController: UIViewController){
        let ac = UIAlertController(title: "Connect to others", message: nil, preferredStyle: .alert)
         ac.addAction(UIAlertAction(title: "Host a session", style: .default) {
            (UIAlertAction) in
             self.startHosting()
       })
         ac.addAction(UIAlertAction(title: "Join a session", style: .default) {
             (UIAlertAction) in
             self.joinSession(fromViewController: viewController)
         })
         ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        viewController.present(ac, animated: true)
    }
    
    // Implement the MCSessionDelegate methods here
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
        let countQuery = transactionTable.count
        do {
            try database2.transaction {
                transactionLocalCount = try database2.scalar(countQuery)
            }
        } catch {
            print("Error getting transaction count: \(error)")
        }
        let dataText = String(data: data, encoding: .utf8)!
        if dataText == requestString {
            let query = transactionTable.select(transactionId, amount, passengerId)
            let transactions = try! database2.prepare(query).map { row in
                return TransactionJSONData(
                    transactionId: row[transactionId],
                    amount: row[amount],
                    passengerId: row[passengerId]
                )
            }
            let encoder = JSONEncoder()
            
            let transactionData = try! encoder.encode(transactions)
            do {
                try mcSession.send(transactionData, toPeers: [peerID], with: .reliable)
            } catch {
                print(error)
            }
        } else {
            
                DispatchQueue.main.async {
                    let decoder = JSONDecoder()
                    let transactionsReceived = try! decoder.decode([TransactionJSONData].self, from: data)
                    do {
                        try self.database2.transaction {
                            for transaction in transactionsReceived {
                                let query = self.transactionTable.filter(self.transactionId == transaction.transactionId && self.passengerId == transaction.passengerId)
                                let result = try self.database2.pluck(query)
                                if result == nil {
                                    let insertQuery = self.transactionTable.insert(
                                        self.transactionId <- transaction.transactionId,
                                        self.amount <- transaction.amount,
                                        self.passengerId <- transaction.passengerId
                                    )
                                    try self.database2.run(insertQuery)
                                }
                            }
                        }
                    } catch {
                        print("Error inserting transactions into Transaction table: \(error)")
                    }
                     
                    var transactionStr = ""
                    do {
                        let selectQuery = self.transactionTable.select(self.transactionId, self.amount, self.passengerId)
                        let rows = try self.database2.prepare(selectQuery)
                        for row in rows {
                            transactionStr += """
                                transactionId: \(row[self.transactionId]), \
                                amount: \(row[self.amount]), \
                                passengerId: \(row[self.passengerId])
                            """ + "\n"
                        }
                    } catch {
                        print("Error selecting transactions from Transaction table: \(error)")
                    }
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
        browserViewController.dismiss(animated: true)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        browserViewController.dismiss(animated: true)
    }
    
    // MARK: - Advertiser Methods
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        invitationHandler(true, mcSession)
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
}
