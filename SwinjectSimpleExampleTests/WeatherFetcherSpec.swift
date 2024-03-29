//
//  WeatherFetcherSpec.swift
//  SwinjectSimpleExample
//
//  Created by koogawa on 2016/07/17.
//  Copyright © 2016年 koogawa. All rights reserved.
//

import Nimble
import Quick
import Swinject
@testable import SwinjectSimpleExample

class WeatherFetcherSpec: QuickSpec {
    /*
    override func spec() {
        it("returns cities.") {
            var cities: [City]?
            WeatherFetcher.fetch { cities = $0 }

            expect(cities).toEventuallyNot(beNil())
            expect(cities?.count).toEventually(equal(12))
            expect(cities?[0].id).toEventually(equal(6077243))
            expect(cities?[0].name).toEventually(equal("Montreal"))
            expect(cities?[0].weather).toEventually(equal("Clouds"))
        }
    }
 */

    struct StubNetwork: Networking {
        private static let json =
            "{" +
                "\"list\": [" +
                "{" +
                "\"id\": 2643743," +
                "\"name\": \"London\"," +
                "\"weather\": [" +
                "{" +
                "\"main\": \"Rain\"" +
                "}" +
                "]" +
                "}," +
                "{" +
                "\"id\": 3451190," +
                "\"name\": \"Rio de Janeiro\"," +
                "\"weather\": [" +
                "{" +
                "\"main\": \"Clear\"" +
                "}" +
                "]" +
                "}" +
                "]" +
        "}"

        func request(response: NSData? -> ()) {
            let data = StubNetwork.json.dataUsingEncoding(
                NSUTF8StringEncoding, allowLossyConversion: false)
            response(data)
        }
    }

    override func spec() {
        var container: Container!
        beforeEach {
            container = Container()

            // Registrations for the network using Alamofire.
            container.register(Networking.self) { _ in Network() }
            container.register(WeatherFetcher.self) { r in
                WeatherFetcher(networking: r.resolve(Networking.self)!)
            }

            // Registration for the stub network.
            container.register(Networking.self, name: "stub") { _ in
                StubNetwork()
            }
            container.register(WeatherFetcher.self, name: "stub") { r in
                WeatherFetcher(networking: r.resolve(Networking.self, name: "stub")!)
            }
        }

        it("returns cities.") {
            var cities: [City]?
            let fetcher = container.resolve(WeatherFetcher.self)!
            fetcher.fetch { cities = $0 }

            expect(cities).toEventuallyNot(beNil())
            expect(cities?.count).toEventually(beGreaterThan(0))
        }
        it("fills weather data.") {
            var cities: [City]?
            let fetcher = container.resolve(WeatherFetcher.self, name: "stub")!
            fetcher.fetch { cities = $0 }

            expect(cities?[0].id).toEventually(equal(2643743))
            expect(cities?[0].name).toEventually(equal("London"))
            expect(cities?[0].weather).toEventually(equal("Rain"))
            expect(cities?[1].id).toEventually(equal(3451190))
            expect(cities?[1].name).toEventually(equal("Rio de Janeiro"))
            expect(cities?[1].weather).toEventually(equal("Clear"))
        }
    }
}
