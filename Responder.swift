import Foundation

// MARK: - Responder

final class Responder {
    let id: UUID!
    private var dictionary: [String: String]
    var nextResponder: Responder?
    
    func next(_ responder: Responder) {
        nextResponder = responder
    }
    
    func checkDictionary(keyIn: String) {
        if let value = dictionary[keyIn] {
            print("The value for key: \(keyIn) is \(value)")
            return
        } else if let next = nextResponder {
            next.checkDictionary(keyIn: keyIn)
        } else {
            print("none")
        }
        return
    }
    
    func modifyDictionary(key: String, value: String) {
        dictionary[key] = value
    }
    
    init(dictionary: [String: String], nextResponder: Responder? = nil) {
        self.dictionary = dictionary
        self.nextResponder = nextResponder
        self.id = UUID()
    }
    
    static func == (lgh: Responder, rgh: Responder) -> Bool {
        return lgh.id == rgh.id
    }
}

class ChainOfResponders {
     var responderArray : [Responder] = []
    
    func takeAction(keyIn: String) {
        guard !responderArray.isEmpty else {
            print("There is no responder to handle the task.")
            return
        }
        let index = responderArray.count - 1
        responderArray[index].checkDictionary(keyIn: keyIn)
    }
    
    func addNext(_ responder: Responder) {
        responderArray.append(responder)
        guard responderArray.count > 1 else {
            return
        }
        let index = responderArray.firstIndex(where: { $0 == responder})!
        responder.next(responderArray[index - 1])
    }
    
}
// MARK: - Implementation

let responder1 = Responder(dictionary: ["one"   : "1",
                                        "two"   : "2",
                                        "three" : "3"])

let responder2 = Responder(dictionary: ["four"   : "4",
                                        "five"   : "5",
                                        "six"    : "6"])

let responder3 = Responder(dictionary: ["seven"  : "7",
                                        "eight"  : "8",
                                        "nine"   : "9"])

var chain = ChainOfResponders()
chain.addNext(responder1)
chain.addNext(responder2)
chain.addNext(responder3)
chain.takeAction(keyIn: "three")
