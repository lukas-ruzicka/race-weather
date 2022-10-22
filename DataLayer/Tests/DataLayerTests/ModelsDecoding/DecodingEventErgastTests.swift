//
//  DecodingEventErgastTests.swift
//  
//
//  Created by Lukas Ruzicka on 22.10.2022.
//

@testable import DomainLayer
@testable import DataLayer
import Foundation
import XCTest

final class DecodingEventErgastTests: XCTestCase {

    func testImola() throws {
        let jsonData = try XCTUnwrap(eventsResponse.data(using: .utf8))
        let responseModel = try JSONDecoder().decode(ErgastEventResponseModel.self, from: jsonData)
        let events: [Event] = .init(from: responseModel, serie: .formula1)
        XCTAssertEqual(events.count, 22)

        let imolaGP = events[3]
        XCTAssertEqual(imolaGP.serie, .formula1)
        XCTAssertEqual(imolaGP.id, "formula1_2022_4")
        XCTAssertEqual(imolaGP.name, "Emilia Romagna GP")
        XCTAssertEqual(imolaGP.countryCode, "IT")
        XCTAssertEqual(imolaGP.trackName, "Autodromo Enzo e Dino Ferrari")
        XCTAssertEqual(imolaGP.trackMapUrl?.absoluteString, "https://www.formula1.com/content/dam/fom-website/2018-redesign-assets/Track%20icons%204x3/Emilia%20Romagna.png")
        XCTAssertEqual(imolaGP.location.coordinate.latitude, 44.3439)
        XCTAssertEqual(imolaGP.location.coordinate.longitude, 11.7167)
        XCTAssertEqual(imolaGP.sessions.count, 5)
        let imolaGPFP1 = imolaGP.sessions[0]
        XCTAssertEqual(imolaGPFP1.id, "formula1_2022_4_practice1")
        XCTAssertEqual(imolaGPFP1.type, .practice(number: 1))
        XCTAssertEqual(imolaGPFP1.dateRange, Date(string: "2022-04-22T11:30:00Z")!...Date(string: "2022-04-22T12:30:00Z")!)
        let imolaGPSprint = imolaGP.sessions[3]
        XCTAssertEqual(imolaGPSprint.id, "formula1_2022_4_sprint")
        XCTAssertEqual(imolaGPSprint.type, .sprint)
        XCTAssertEqual(imolaGPSprint.dateRange, Date(string: "2022-04-23T14:30:00Z")!...Date(string: "2022-04-23T15:30:00Z")!)
        let imolaGPRace = imolaGP.sessions[4]
        XCTAssertEqual(imolaGPRace.id, "formula1_2022_4_race")
        XCTAssertEqual(imolaGPRace.type, .race)
        XCTAssertEqual(imolaGPRace.dateRange, Date(string: "2022-04-24T13:00:00Z")!...Date(string: "2022-04-24T15:00:00Z")!)
    }

    func testUSA() throws {
        let jsonData = try XCTUnwrap(eventsResponse.data(using: .utf8))
        let responseModel = try JSONDecoder().decode(ErgastEventResponseModel.self, from: jsonData)
        let events: [Event] = .init(from: responseModel, serie: .formula1)
        XCTAssertEqual(events.count, 22)

        let usaGP = events[18]
        XCTAssertEqual(usaGP.serie, .formula1)
        XCTAssertEqual(usaGP.id, "formula1_2022_19")
        XCTAssertEqual(usaGP.name, "United States GP")
        XCTAssertEqual(usaGP.countryCode, "US")
        XCTAssertEqual(usaGP.trackName, "Circuit of the Americas")
        XCTAssertEqual(usaGP.trackMapUrl?.absoluteString, "https://www.formula1.com/content/dam/fom-website/2018-redesign-assets/Track%20icons%204x3/United%20States.png")
        XCTAssertEqual(usaGP.location.coordinate.latitude, 30.1328)
        XCTAssertEqual(usaGP.location.coordinate.longitude, -97.6411)
        XCTAssertEqual(usaGP.sessions.count, 5)
        let usaGPFP3 = usaGP.sessions[2]
        XCTAssertEqual(usaGPFP3.id, "formula1_2022_19_practice3")
        XCTAssertEqual(usaGPFP3.type, .practice(number: 3))
        XCTAssertEqual(usaGPFP3.dateRange, Date(string: "2022-10-22T19:00:00Z")!...Date(string: "2022-10-22T20:00:00Z")!)
        let usaGPRace = usaGP.sessions[4]
        XCTAssertEqual(usaGPRace.id, "formula1_2022_19_race")
        XCTAssertEqual(usaGPRace.type, .race)
        XCTAssertEqual(usaGPRace.dateRange, Date(string: "2022-10-23T19:00:00Z")!...Date(string: "2022-10-23T21:00:00Z")!)
    }
}

private extension DecodingEventErgastTests {

    var eventsResponse: String {
        """
        {
            "MRData": {
                "xmlns": "http://ergast.com/mrd/1.5",
                "series": "f1",
                "url": "http://ergast.com/api/f1/current.json",
                "limit": "30",
                "offset": "0",
                "total": "22",
                "RaceTable": {
                    "season": "2022",
                    "Races": [
                        {
                            "season": "2022",
                            "round": "1",
                            "url": "http://en.wikipedia.org/wiki/2022_Bahrain_Grand_Prix",
                            "raceName": "Bahrain Grand Prix",
                            "Circuit": {
                                "circuitId": "bahrain",
                                "url": "http://en.wikipedia.org/wiki/Bahrain_International_Circuit",
                                "circuitName": "Bahrain International Circuit",
                                "Location": {
                                    "lat": "26.0325",
                                    "long": "50.5106",
                                    "locality": "Sakhir",
                                    "country": "Bahrain"
                                }
                            },
                            "date": "2022-03-20",
                            "time": "15:00:00Z",
                            "FirstPractice": {
                                "date": "2022-03-18",
                                "time": "12:00:00Z"
                            },
                            "SecondPractice": {
                                "date": "2022-03-18",
                                "time": "15:00:00Z"
                            },
                            "ThirdPractice": {
                                "date": "2022-03-19",
                                "time": "12:00:00Z"
                            },
                            "Qualifying": {
                                "date": "2022-03-19",
                                "time": "15:00:00Z"
                            }
                        },
                        {
                            "season": "2022",
                            "round": "2",
                            "url": "http://en.wikipedia.org/wiki/2022_Saudi_Arabian_Grand_Prix",
                            "raceName": "Saudi Arabian Grand Prix",
                            "Circuit": {
                                "circuitId": "jeddah",
                                "url": "http://en.wikipedia.org/wiki/Jeddah_Street_Circuit",
                                "circuitName": "Jeddah Corniche Circuit",
                                "Location": {
                                    "lat": "21.6319",
                                    "long": "39.1044",
                                    "locality": "Jeddah",
                                    "country": "Saudi Arabia"
                                }
                            },
                            "date": "2022-03-27",
                            "time": "17:00:00Z",
                            "FirstPractice": {
                                "date": "2022-03-25",
                                "time": "14:00:00Z"
                            },
                            "SecondPractice": {
                                "date": "2022-03-25",
                                "time": "17:00:00Z"
                            },
                            "ThirdPractice": {
                                "date": "2022-03-26",
                                "time": "14:00:00Z"
                            },
                            "Qualifying": {
                                "date": "2022-03-26",
                                "time": "17:00:00Z"
                            }
                        },
                        {
                            "season": "2022",
                            "round": "3",
                            "url": "http://en.wikipedia.org/wiki/2022_Australian_Grand_Prix",
                            "raceName": "Australian Grand Prix",
                            "Circuit": {
                                "circuitId": "albert_park",
                                "url": "http://en.wikipedia.org/wiki/Melbourne_Grand_Prix_Circuit",
                                "circuitName": "Albert Park Grand Prix Circuit",
                                "Location": {
                                    "lat": "-37.8497",
                                    "long": "144.968",
                                    "locality": "Melbourne",
                                    "country": "Australia"
                                }
                            },
                            "date": "2022-04-10",
                            "time": "05:00:00Z",
                            "FirstPractice": {
                                "date": "2022-04-08",
                                "time": "03:00:00Z"
                            },
                            "SecondPractice": {
                                "date": "2022-04-08",
                                "time": "06:00:00Z"
                            },
                            "ThirdPractice": {
                                "date": "2022-04-09",
                                "time": "03:00:00Z"
                            },
                            "Qualifying": {
                                "date": "2022-04-09",
                                "time": "06:00:00Z"
                            }
                        },
                        {
                            "season": "2022",
                            "round": "4",
                            "url": "http://en.wikipedia.org/wiki/2022_Emilia_Romagna_Grand_Prix",
                            "raceName": "Emilia Romagna Grand Prix",
                            "Circuit": {
                                "circuitId": "imola",
                                "url": "http://en.wikipedia.org/wiki/Autodromo_Enzo_e_Dino_Ferrari",
                                "circuitName": "Autodromo Enzo e Dino Ferrari",
                                "Location": {
                                    "lat": "44.3439",
                                    "long": "11.7167",
                                    "locality": "Imola",
                                    "country": "Italy"
                                }
                            },
                            "date": "2022-04-24",
                            "time": "13:00:00Z",
                            "FirstPractice": {
                                "date": "2022-04-22",
                                "time": "11:30:00Z"
                            },
                            "Qualifying": {
                                "date": "2022-04-22",
                                "time": "15:00:00Z"
                            },
                            "SecondPractice": {
                                "date": "2022-04-23",
                                "time": "10:30:00Z"
                            },
                            "Sprint": {
                                "date": "2022-04-23",
                                "time": "14:30:00Z"
                            }
                        },
                        {
                            "season": "2022",
                            "round": "5",
                            "url": "http://en.wikipedia.org/wiki/2022_Miami_Grand_Prix",
                            "raceName": "Miami Grand Prix",
                            "Circuit": {
                                "circuitId": "miami",
                                "url": "http://en.wikipedia.org/wiki/Miami_International_Autodrome",
                                "circuitName": "Miami International Autodrome",
                                "Location": {
                                    "lat": "25.9581",
                                    "long": "-80.2389",
                                    "locality": "Miami",
                                    "country": "USA"
                                }
                            },
                            "date": "2022-05-08",
                            "time": "19:30:00Z",
                            "FirstPractice": {
                                "date": "2022-05-06",
                                "time": "18:30:00Z"
                            },
                            "SecondPractice": {
                                "date": "2022-05-06",
                                "time": "21:30:00Z"
                            },
                            "ThirdPractice": {
                                "date": "2022-05-07",
                                "time": "17:00:00Z"
                            },
                            "Qualifying": {
                                "date": "2022-05-07",
                                "time": "20:00:00Z"
                            }
                        },
                        {
                            "season": "2022",
                            "round": "6",
                            "url": "http://en.wikipedia.org/wiki/2022_Spanish_Grand_Prix",
                            "raceName": "Spanish Grand Prix",
                            "Circuit": {
                                "circuitId": "catalunya",
                                "url": "http://en.wikipedia.org/wiki/Circuit_de_Barcelona-Catalunya",
                                "circuitName": "Circuit de Barcelona-Catalunya",
                                "Location": {
                                    "lat": "41.57",
                                    "long": "2.26111",
                                    "locality": "Montmeló",
                                    "country": "Spain"
                                }
                            },
                            "date": "2022-05-22",
                            "time": "13:00:00Z",
                            "FirstPractice": {
                                "date": "2022-05-20",
                                "time": "12:00:00Z"
                            },
                            "SecondPractice": {
                                "date": "2022-05-20",
                                "time": "15:00:00Z"
                            },
                            "ThirdPractice": {
                                "date": "2022-05-21",
                                "time": "11:00:00Z"
                            },
                            "Qualifying": {
                                "date": "2022-05-21",
                                "time": "14:00:00Z"
                            }
                        },
                        {
                            "season": "2022",
                            "round": "7",
                            "url": "http://en.wikipedia.org/wiki/2022_Monaco_Grand_Prix",
                            "raceName": "Monaco Grand Prix",
                            "Circuit": {
                                "circuitId": "monaco",
                                "url": "http://en.wikipedia.org/wiki/Circuit_de_Monaco",
                                "circuitName": "Circuit de Monaco",
                                "Location": {
                                    "lat": "43.7347",
                                    "long": "7.42056",
                                    "locality": "Monte-Carlo",
                                    "country": "Monaco"
                                }
                            },
                            "date": "2022-05-29",
                            "time": "13:00:00Z",
                            "FirstPractice": {
                                "date": "2022-05-27",
                                "time": "12:00:00Z"
                            },
                            "SecondPractice": {
                                "date": "2022-05-27",
                                "time": "15:00:00Z"
                            },
                            "ThirdPractice": {
                                "date": "2022-05-28",
                                "time": "11:00:00Z"
                            },
                            "Qualifying": {
                                "date": "2022-05-28",
                                "time": "14:00:00Z"
                            }
                        },
                        {
                            "season": "2022",
                            "round": "8",
                            "url": "http://en.wikipedia.org/wiki/2022_Azerbaijan_Grand_Prix",
                            "raceName": "Azerbaijan Grand Prix",
                            "Circuit": {
                                "circuitId": "baku",
                                "url": "http://en.wikipedia.org/wiki/Baku_City_Circuit",
                                "circuitName": "Baku City Circuit",
                                "Location": {
                                    "lat": "40.3725",
                                    "long": "49.8533",
                                    "locality": "Baku",
                                    "country": "Azerbaijan"
                                }
                            },
                            "date": "2022-06-12",
                            "time": "11:00:00Z",
                            "FirstPractice": {
                                "date": "2022-06-10",
                                "time": "11:00:00Z"
                            },
                            "SecondPractice": {
                                "date": "2022-06-10",
                                "time": "14:00:00Z"
                            },
                            "ThirdPractice": {
                                "date": "2022-06-11",
                                "time": "11:00:00Z"
                            },
                            "Qualifying": {
                                "date": "2022-06-11",
                                "time": "14:00:00Z"
                            }
                        },
                        {
                            "season": "2022",
                            "round": "9",
                            "url": "http://en.wikipedia.org/wiki/2022_Canadian_Grand_Prix",
                            "raceName": "Canadian Grand Prix",
                            "Circuit": {
                                "circuitId": "villeneuve",
                                "url": "http://en.wikipedia.org/wiki/Circuit_Gilles_Villeneuve",
                                "circuitName": "Circuit Gilles Villeneuve",
                                "Location": {
                                    "lat": "45.5",
                                    "long": "-73.5228",
                                    "locality": "Montreal",
                                    "country": "Canada"
                                }
                            },
                            "date": "2022-06-19",
                            "time": "18:00:00Z",
                            "FirstPractice": {
                                "date": "2022-06-17",
                                "time": "18:00:00Z"
                            },
                            "SecondPractice": {
                                "date": "2022-06-17",
                                "time": "21:00:00Z"
                            },
                            "ThirdPractice": {
                                "date": "2022-06-18",
                                "time": "17:00:00Z"
                            },
                            "Qualifying": {
                                "date": "2022-06-18",
                                "time": "20:00:00Z"
                            }
                        },
                        {
                            "season": "2022",
                            "round": "10",
                            "url": "http://en.wikipedia.org/wiki/2022_British_Grand_Prix",
                            "raceName": "British Grand Prix",
                            "Circuit": {
                                "circuitId": "silverstone",
                                "url": "http://en.wikipedia.org/wiki/Silverstone_Circuit",
                                "circuitName": "Silverstone Circuit",
                                "Location": {
                                    "lat": "52.0786",
                                    "long": "-1.01694",
                                    "locality": "Silverstone",
                                    "country": "UK"
                                }
                            },
                            "date": "2022-07-03",
                            "time": "14:00:00Z",
                            "FirstPractice": {
                                "date": "2022-07-01",
                                "time": "12:00:00Z"
                            },
                            "SecondPractice": {
                                "date": "2022-07-01",
                                "time": "15:00:00Z"
                            },
                            "ThirdPractice": {
                                "date": "2022-07-02",
                                "time": "11:00:00Z"
                            },
                            "Qualifying": {
                                "date": "2022-07-02",
                                "time": "14:00:00Z"
                            }
                        },
                        {
                            "season": "2022",
                            "round": "11",
                            "url": "http://en.wikipedia.org/wiki/2022_Austrian_Grand_Prix",
                            "raceName": "Austrian Grand Prix",
                            "Circuit": {
                                "circuitId": "red_bull_ring",
                                "url": "http://en.wikipedia.org/wiki/Red_Bull_Ring",
                                "circuitName": "Red Bull Ring",
                                "Location": {
                                    "lat": "47.2197",
                                    "long": "14.7647",
                                    "locality": "Spielberg",
                                    "country": "Austria"
                                }
                            },
                            "date": "2022-07-10",
                            "time": "13:00:00Z",
                            "FirstPractice": {
                                "date": "2022-07-08",
                                "time": "11:30:00Z"
                            },
                            "Qualifying": {
                                "date": "2022-07-08",
                                "time": "15:00:00Z"
                            },
                            "SecondPractice": {
                                "date": "2022-07-09",
                                "time": "10:30:00Z"
                            },
                            "Sprint": {
                                "date": "2022-07-09",
                                "time": "14:30:00Z"
                            }
                        },
                        {
                            "season": "2022",
                            "round": "12",
                            "url": "http://en.wikipedia.org/wiki/2022_French_Grand_Prix",
                            "raceName": "French Grand Prix",
                            "Circuit": {
                                "circuitId": "ricard",
                                "url": "http://en.wikipedia.org/wiki/Paul_Ricard_Circuit",
                                "circuitName": "Circuit Paul Ricard",
                                "Location": {
                                    "lat": "43.2506",
                                    "long": "5.79167",
                                    "locality": "Le Castellet",
                                    "country": "France"
                                }
                            },
                            "date": "2022-07-24",
                            "time": "13:00:00Z",
                            "FirstPractice": {
                                "date": "2022-07-22",
                                "time": "12:00:00Z"
                            },
                            "SecondPractice": {
                                "date": "2022-07-22",
                                "time": "15:00:00Z"
                            },
                            "ThirdPractice": {
                                "date": "2022-07-23",
                                "time": "11:00:00Z"
                            },
                            "Qualifying": {
                                "date": "2022-07-23",
                                "time": "14:00:00Z"
                            }
                        },
                        {
                            "season": "2022",
                            "round": "13",
                            "url": "http://en.wikipedia.org/wiki/2022_Hungarian_Grand_Prix",
                            "raceName": "Hungarian Grand Prix",
                            "Circuit": {
                                "circuitId": "hungaroring",
                                "url": "http://en.wikipedia.org/wiki/Hungaroring",
                                "circuitName": "Hungaroring",
                                "Location": {
                                    "lat": "47.5789",
                                    "long": "19.2486",
                                    "locality": "Budapest",
                                    "country": "Hungary"
                                }
                            },
                            "date": "2022-07-31",
                            "time": "13:00:00Z",
                            "FirstPractice": {
                                "date": "2022-07-29",
                                "time": "12:00:00Z"
                            },
                            "SecondPractice": {
                                "date": "2022-07-29",
                                "time": "15:00:00Z"
                            },
                            "ThirdPractice": {
                                "date": "2022-07-30",
                                "time": "11:00:00Z"
                            },
                            "Qualifying": {
                                "date": "2022-07-30",
                                "time": "14:00:00Z"
                            }
                        },
                        {
                            "season": "2022",
                            "round": "14",
                            "url": "http://en.wikipedia.org/wiki/2022_Belgian_Grand_Prix",
                            "raceName": "Belgian Grand Prix",
                            "Circuit": {
                                "circuitId": "spa",
                                "url": "http://en.wikipedia.org/wiki/Circuit_de_Spa-Francorchamps",
                                "circuitName": "Circuit de Spa-Francorchamps",
                                "Location": {
                                    "lat": "50.4372",
                                    "long": "5.97139",
                                    "locality": "Spa",
                                    "country": "Belgium"
                                }
                            },
                            "date": "2022-08-28",
                            "time": "13:00:00Z",
                            "FirstPractice": {
                                "date": "2022-08-26",
                                "time": "12:00:00Z"
                            },
                            "SecondPractice": {
                                "date": "2022-08-26",
                                "time": "15:00:00Z"
                            },
                            "ThirdPractice": {
                                "date": "2022-08-27",
                                "time": "11:00:00Z"
                            },
                            "Qualifying": {
                                "date": "2022-08-27",
                                "time": "14:00:00Z"
                            }
                        },
                        {
                            "season": "2022",
                            "round": "15",
                            "url": "http://en.wikipedia.org/wiki/2022_Dutch_Grand_Prix",
                            "raceName": "Dutch Grand Prix",
                            "Circuit": {
                                "circuitId": "zandvoort",
                                "url": "http://en.wikipedia.org/wiki/Circuit_Zandvoort",
                                "circuitName": "Circuit Park Zandvoort",
                                "Location": {
                                    "lat": "52.3888",
                                    "long": "4.54092",
                                    "locality": "Zandvoort",
                                    "country": "Netherlands"
                                }
                            },
                            "date": "2022-09-04",
                            "time": "13:00:00Z",
                            "FirstPractice": {
                                "date": "2022-09-02",
                                "time": "10:30:00Z"
                            },
                            "SecondPractice": {
                                "date": "2022-09-02",
                                "time": "14:00:00Z"
                            },
                            "ThirdPractice": {
                                "date": "2022-09-03",
                                "time": "10:00:00Z"
                            },
                            "Qualifying": {
                                "date": "2022-09-03",
                                "time": "13:00:00Z"
                            }
                        },
                        {
                            "season": "2022",
                            "round": "16",
                            "url": "http://en.wikipedia.org/wiki/2022_Italian_Grand_Prix",
                            "raceName": "Italian Grand Prix",
                            "Circuit": {
                                "circuitId": "monza",
                                "url": "http://en.wikipedia.org/wiki/Autodromo_Nazionale_Monza",
                                "circuitName": "Autodromo Nazionale di Monza",
                                "Location": {
                                    "lat": "45.6156",
                                    "long": "9.28111",
                                    "locality": "Monza",
                                    "country": "Italy"
                                }
                            },
                            "date": "2022-09-11",
                            "time": "13:00:00Z",
                            "FirstPractice": {
                                "date": "2022-09-09",
                                "time": "12:00:00Z"
                            },
                            "SecondPractice": {
                                "date": "2022-09-09",
                                "time": "15:00:00Z"
                            },
                            "ThirdPractice": {
                                "date": "2022-09-10",
                                "time": "11:00:00Z"
                            },
                            "Qualifying": {
                                "date": "2022-09-10",
                                "time": "14:00:00Z"
                            }
                        },
                        {
                            "season": "2022",
                            "round": "17",
                            "url": "http://en.wikipedia.org/wiki/2022_Singapore_Grand_Prix",
                            "raceName": "Singapore Grand Prix",
                            "Circuit": {
                                "circuitId": "marina_bay",
                                "url": "http://en.wikipedia.org/wiki/Marina_Bay_Street_Circuit",
                                "circuitName": "Marina Bay Street Circuit",
                                "Location": {
                                    "lat": "1.2914",
                                    "long": "103.864",
                                    "locality": "Marina Bay",
                                    "country": "Singapore"
                                }
                            },
                            "date": "2022-10-02",
                            "time": "12:00:00Z",
                            "FirstPractice": {
                                "date": "2022-09-30",
                                "time": "10:00:00Z"
                            },
                            "SecondPractice": {
                                "date": "2022-09-30",
                                "time": "13:00:00Z"
                            },
                            "ThirdPractice": {
                                "date": "2022-10-01",
                                "time": "10:00:00Z"
                            },
                            "Qualifying": {
                                "date": "2022-10-01",
                                "time": "13:00:00Z"
                            }
                        },
                        {
                            "season": "2022",
                            "round": "18",
                            "url": "http://en.wikipedia.org/wiki/2022_Japanese_Grand_Prix",
                            "raceName": "Japanese Grand Prix",
                            "Circuit": {
                                "circuitId": "suzuka",
                                "url": "http://en.wikipedia.org/wiki/Suzuka_Circuit",
                                "circuitName": "Suzuka Circuit",
                                "Location": {
                                    "lat": "34.8431",
                                    "long": "136.541",
                                    "locality": "Suzuka",
                                    "country": "Japan"
                                }
                            },
                            "date": "2022-10-09",
                            "time": "05:00:00Z",
                            "FirstPractice": {
                                "date": "2022-10-07",
                                "time": "03:00:00Z"
                            },
                            "SecondPractice": {
                                "date": "2022-10-07",
                                "time": "06:00:00Z"
                            },
                            "ThirdPractice": {
                                "date": "2022-10-08",
                                "time": "03:00:00Z"
                            },
                            "Qualifying": {
                                "date": "2022-10-08",
                                "time": "06:00:00Z"
                            }
                        },
                        {
                            "season": "2022",
                            "round": "19",
                            "url": "http://en.wikipedia.org/wiki/2022_United_States_Grand_Prix",
                            "raceName": "United States Grand Prix",
                            "Circuit": {
                                "circuitId": "americas",
                                "url": "http://en.wikipedia.org/wiki/Circuit_of_the_Americas",
                                "circuitName": "Circuit of the Americas",
                                "Location": {
                                    "lat": "30.1328",
                                    "long": "-97.6411",
                                    "locality": "Austin",
                                    "country": "USA"
                                }
                            },
                            "date": "2022-10-23",
                            "time": "19:00:00Z",
                            "FirstPractice": {
                                "date": "2022-10-21",
                                "time": "19:00:00Z"
                            },
                            "SecondPractice": {
                                "date": "2022-10-21",
                                "time": "22:00:00Z"
                            },
                            "ThirdPractice": {
                                "date": "2022-10-22",
                                "time": "19:00:00Z"
                            },
                            "Qualifying": {
                                "date": "2022-10-22",
                                "time": "22:00:00Z"
                            }
                        },
                        {
                            "season": "2022",
                            "round": "20",
                            "url": "http://en.wikipedia.org/wiki/2022_Mexican_Grand_Prix",
                            "raceName": "Mexico City Grand Prix",
                            "Circuit": {
                                "circuitId": "rodriguez",
                                "url": "http://en.wikipedia.org/wiki/Aut%C3%B3dromo_Hermanos_Rodr%C3%ADguez",
                                "circuitName": "Autódromo Hermanos Rodríguez",
                                "Location": {
                                    "lat": "19.4042",
                                    "long": "-99.0907",
                                    "locality": "Mexico City",
                                    "country": "Mexico"
                                }
                            },
                            "date": "2022-10-30",
                            "time": "20:00:00Z",
                            "FirstPractice": {
                                "date": "2022-10-28",
                                "time": "18:00:00Z"
                            },
                            "SecondPractice": {
                                "date": "2022-10-28",
                                "time": "21:00:00Z"
                            },
                            "ThirdPractice": {
                                "date": "2022-10-29",
                                "time": "17:00:00Z"
                            },
                            "Qualifying": {
                                "date": "2022-10-29",
                                "time": "20:00:00Z"
                            }
                        },
                        {
                            "season": "2022",
                            "round": "21",
                            "url": "http://en.wikipedia.org/wiki/2022_Brazilian_Grand_Prix",
                            "raceName": "Brazilian Grand Prix",
                            "Circuit": {
                                "circuitId": "interlagos",
                                "url": "http://en.wikipedia.org/wiki/Aut%C3%B3dromo_Jos%C3%A9_Carlos_Pace",
                                "circuitName": "Autódromo José Carlos Pace",
                                "Location": {
                                    "lat": "-23.7036",
                                    "long": "-46.6997",
                                    "locality": "São Paulo",
                                    "country": "Brazil"
                                }
                            },
                            "date": "2022-11-13",
                            "time": "18:00:00Z",
                            "FirstPractice": {
                                "date": "2022-11-11",
                                "time": "15:30:00Z"
                            },
                            "Qualifying": {
                                "date": "2022-11-11",
                                "time": "19:00:00Z"
                            },
                            "SecondPractice": {
                                "date": "2022-11-12",
                                "time": "15:30:00Z"
                            },
                            "Sprint": {
                                "date": "2022-11-12",
                                "time": "19:30:00Z"
                            }
                        },
                        {
                            "season": "2022",
                            "round": "22",
                            "url": "http://en.wikipedia.org/wiki/2022_Abu_Dhabi_Grand_Prix",
                            "raceName": "Abu Dhabi Grand Prix",
                            "Circuit": {
                                "circuitId": "yas_marina",
                                "url": "http://en.wikipedia.org/wiki/Yas_Marina_Circuit",
                                "circuitName": "Yas Marina Circuit",
                                "Location": {
                                    "lat": "24.4672",
                                    "long": "54.6031",
                                    "locality": "Abu Dhabi",
                                    "country": "UAE"
                                }
                            },
                            "date": "2022-11-20",
                            "time": "13:00:00Z",
                            "FirstPractice": {
                                "date": "2022-11-18",
                                "time": "10:00:00Z"
                            },
                            "SecondPractice": {
                                "date": "2022-11-18",
                                "time": "13:00:00Z"
                            },
                            "ThirdPractice": {
                                "date": "2022-11-19",
                                "time": "11:00:00Z"
                            },
                            "Qualifying": {
                                "date": "2022-11-19",
                                "time": "14:00:00Z"
                            }
                        }
                    ]
                }
            }
        }
        """
    }
}
