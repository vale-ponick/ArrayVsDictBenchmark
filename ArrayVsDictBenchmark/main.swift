//
//  main.swift
//  ArrayVsDictBenchmark
//
//  Created by Валерия Пономарева on 20.05.2026.
//

import Foundation

print("📝 TECHNICAL TASK — Array vs Dictionary Benchmark")
print("Goal: Find out how many times faster Dictionary is than Array for search")

// 1️⃣ Структура жителя
struct Citizen {
    let passportID: Int
    let name: String
    let age: Double
}

// 2️⃣ Массив (улица) — пустые коттеджи
var street = [Citizen]()

// 3️⃣ Заселяем 10 000 жителей в массив
for passportNumber in 1...10000 {
    let person = Citizen(
        passportID: passportNumber,
        name: "Citizen \(passportNumber)",
        age: 21.0
    )
    street.append(person)
}

// 4️⃣ Словарь = Реестр граждан
var citizenRegistry = [Int: Citizen]()

// 5️⃣ Регистрируем жителей по паспорту
for person in street {
    citizenRegistry[person.passportID] = person
}

// 6️⃣ Тест поиска в реестре с защитой
guard let testCitizen = citizenRegistry[1234] else {
    print("❌ Ошибка: реестр пуст или паспорт 12345 не найден")
    fatalError("Тест не пройден")
}
print("✅ Реестр нашёл: \(testCitizen.name)")

// 7️⃣ Тест перебором по улице
for citizen in street {
    if citizen.passportID == 1234 {
        print("🐢 Улица нашла: \(citizen.name)")
    }
}

// 8️⃣ Генерируем 100 случайных паспортов
let randomPassports = (1...10000).shuffled().prefix(100)

// 9️⃣ Функция замера времени выполнения любого блока кода
// Параметр: block — код, который нужно измерить (например, поиск в массиве)
// Возвращает: количество секунд, которое выполнялся блок (Double)
func measureTime(_ block: () -> Void) -> Double {
    let start = CFAbsoluteTimeGetCurrent()  // время "до"
    block()                                  // выполняем переданный код
    let end = CFAbsoluteTimeGetCurrent()    // время "после"
    return end - start                      // разница = время выполнения
}

// 🔟 Функция красивого вывода
func printResult(name: String, time: Double) {
    print("⏱ \(name): \(String(format: "%.6f", time)) сек")
}

// 1️⃣1️⃣ Бенчмарк: массив (улица)
let arrayTime = measureTime {
    for passport in randomPassports {
        _ = street.first { $0.passportID == passport }
    }
}
printResult(name: "Массив (улица)", time: arrayTime)

// 1️⃣2️⃣ Бенчмарк: словарь (реестр)
let dictTime = measureTime {
    for passport in randomPassports {
        _ = citizenRegistry[passport]
    }
}
printResult(name: "Словарь (реестр)", time: dictTime)

// 1️⃣3️⃣ Результат
let ratio = arrayTime / dictTime
print("🚀 Реестр быстрее улицы в \(String(format: "%.1f", ratio)) раз")
