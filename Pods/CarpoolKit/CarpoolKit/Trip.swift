import FirebaseCommunity
import PromiseKit

public struct Trip: Codable, Keyed {
    var key: String!
    public let event: Event
    public let pickUp: Leg?
    public let dropOff: Leg?
}

extension Trip: Equatable {
    public static func ==(lhs: Trip, rhs: Trip) -> Bool {
        return lhs.key == rhs.key
    }
}

extension Trip: Comparable {
    public static func <(lhs: Trip, rhs: Trip) -> Bool {
        return lhs.event.time < rhs.event.time
    }
}

extension Trip: Hashable {
    public var hashValue: Int {
        return key.hashValue
    }
}

extension Trip {
    static func make(key: String, json: [String: Any]) -> Promise<Trip> {
        do {
            func getLeg(key: String) -> Promise<User?> {
                guard let json = json[key] as? [String: String] else { return Promise(value: nil) }
                guard let item = json.first else { return Promise(value: nil) }
                return API.fetchUser(id: item.key).then(on: zalgo){ $0 }
            }

            let dropOff = getLeg(key: "dropOff")
            let pickUp = getLeg(key: "pickUp")
            let event = try Event(json: json, key: "event")

            return firstly {
                when(fulfilled: dropOff, pickUp)
            }.then { pickUp, dropOff in
                Trip(key: key, event: event, pickUp: pickUp.map(Leg.init), dropOff: dropOff.map(Leg.init))
            }
        } catch {
            return Promise(error: error)
        }
    }
}
