//
//  main.swift
//  ArrayVsDictBenchmark
//
//  Created by Валерия Пономарева on 20.05.2026.
//

import Foundation

print("📝  TECHNICAL TASK — Array vs Dictionary Benchmark")
print("Goal: Find out how many times faster Dictionary is than Array for search")

struct Citizen {
    let passportID: Int // номер паспорта
    let name: String
    let age: Double
}

var street = [Citizen]() // создает пустой список - пустые коттеджи
    
for passportNumber in 1...10000 { // повторяем 10 000 раз -> заселяем коттеджи жителями
    let person = Citizen(
        passportID: passportNumber,
        name: "Citizen \(passportNumber)",
        age: 21.0
        )
   street.append(person) // добавляем в массив -> Итог: в списке 10 000 товаров
}

var wardrobe = [Int: Citizen]() // пустой гардероб

for person in street { // поместим человека в гардероб под его паспортным номером
    wardrobe[person.passportID] = person
}

if let citizen = wardrobe[12345] { // // Ищем по паспорту (мгновенно)
    print("Found: \(citizen.name)")
}

for citizen in street { // Ищем по улице (медленно)
    if citizen.passportID == 12345 {
        print("Found: \(citizen.name)")
    }
}
