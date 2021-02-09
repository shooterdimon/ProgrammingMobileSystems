
import Foundation

// Частина 1

// Дано рядок у форматі "Student1 - Group1; Student2 - Group2; ..."

let studentsStr = "Дмитренко Олександр - ІП-84; Матвійчук Андрій - ІВ-83; Лесик Сергій - ІО-82; Ткаченко Ярослав - ІВ-83; Аверкова Анастасія - ІО-83; Соловйов Даніїл - ІО-83; Рахуба Вероніка - ІО-81; Кочерук Давид - ІВ-83; Лихацька Юлія- ІВ-82; Головенець Руслан - ІВ-83; Ющенко Андрій - ІО-82; Мінченко Володимир - ІП-83; Мартинюк Назар - ІО-82; Базова Лідія - ІВ-81; Снігурець Олег - ІВ-81; Роман Олександр - ІО-82; Дудка Максим - ІО-81; Кулініч Віталій - ІВ-81; Жуков Михайло - ІП-83; Грабко Михайло - ІВ-81; Iванов Володимир - ІО-81; Востриков Нікіта - ІО-82; Бондаренко Максим - ІВ-83; Скрипченко Володимир - ІВ-82; Кобук Назар - ІО-81; Дровнін Павло - ІВ-83; Тарасенко Юлія - ІО-82; Дрозд Світлана - ІВ-81; Фещенко Кирил - ІО-82; Крамар Віктор - ІО-83; Іванов Дмитро - ІВ-82"

// Завдання 1
// Заповніть словник, де:
// - ключ – назва групи
// - значення – відсортований масив студентів, які відносяться до відповідної групи

var studentsGroups: [String: [String]] = [:]

// Ваш код починається тут

var studentsArr = studentsStr.split{$0 == ";"}.map(String.init)
var groupArr : [(String,String)] = []
var groupNames : [String] = []
for student in studentsArr{
    let splittedStr = student.split{$0 == "-"}.map(String.init)
    let groupName = splittedStr[1].dropFirst()+"-"+splittedStr[2]
    var studentName = splittedStr[0]
    if studentName.starts(with: " "){
        studentName = String(studentName.dropFirst())
    }
    if studentName[studentName.index(before: studentName.endIndex)] == " "{
            studentName = String(studentName.dropLast())
        }
    let groupStudent: (String, String) = (groupName, studentName)
    groupArr.append(groupStudent)
    if !groupNames.contains(groupName) {
        groupNames.append(groupName)
    }
}

for group in groupNames{
    var studentsByGroups : [String] = []
    for student in groupArr{
        if student.0 == group{
            studentsByGroups.append(student.1)
        }
    }
    studentsByGroups.sort()
    studentsGroups[group] = studentsByGroups
}

// Ваш код закінчується тут

print("Завдання 1")
print(studentsGroups)
print()

// Дано масив з максимально можливими оцінками

let points: [Int] = [12, 12, 12, 12, 12, 12, 12, 16]

// Завдання 2
// Заповніть словник, де:
// - ключ – назва групи
// - значення – словник, де:
//   - ключ – студент, який відносяться до відповідної групи
//   - значення – масив з оцінками студента (заповніть масив випадковими значеннями, використовуючи функцію `randomValue(maxValue: Int) -> Int`)

func randomValue(maxValue: Int) -> Int {
    switch(arc4random_uniform(6)) {
    case 1:
        return Int(ceil(Float(maxValue) * 0.7))
    case 2:
        return Int(ceil(Float(maxValue) * 0.9))
    case 3, 4, 5:
        return maxValue
    default:
        return 0
    }
}

var studentPoints: [String: [String: [Int]]] = [:]

// Ваш код починається тут
for (group,students) in studentsGroups{
    for student in students{
        var pointsToStudent:  [Int] = []
        for point in points{
            pointsToStudent.append(randomValue(maxValue: point))
        }
        studentPoints[group, default: [:]][student] = pointsToStudent
    }
}


// Ваш код закінчується тут

print("Завдання 2")
print(studentPoints)
print()

// Завдання 3
// Заповніть словник, де:
// - ключ – назва групи
// - значення – словник, де:
//   - ключ – студент, який відносяться до відповідної групи
//   - значення – сума оцінок студента

var sumPoints: [String: [String: Int]] = [:]

// Ваш код починається тут
for (group,students) in studentPoints{
    for (student,points) in students{
        var sum = 0
        for point in points{
            sum+=point
        }
        sumPoints[group, default: [:]][student] = sum
    }
}


// Ваш код закінчується тут

print("Завдання 3")
print(sumPoints)
print()

// Завдання 4
// Заповніть словник, де:
// - ключ – назва групи
// - значення – середня оцінка всіх студентів групи

var groupAvg: [String: Float] = [:]

// Ваш код починається тут
for (group,students) in sumPoints{
    var sumGroup: Int=0
    for (_,point) in students{
        sumGroup+=point
    }
    groupAvg[group] = Float(sumGroup)/Float(students.count)
}


// Ваш код закінчується тут

print("Завдання 4")
print(groupAvg)
print()

// Завдання 5
// Заповніть словник, де:
// - ключ – назва групи
// - значення – масив студентів, які мають >= 60 балів

var passedPerGroup: [String: [String]] = [:]

// Ваш код починається тут
for (group,students) in sumPoints{
    var passedStudents: [String]=[]
    for(student,points) in students{
        if points>=60{
            passedStudents.append(student)
        }
    }
    passedPerGroup[group] = passedStudents
}


// Ваш код закінчується тут

print("Завдання 5")
print(passedPerGroup)

// Приклад виведення. Ваш результат буде відрізнятися від прикладу через використання функції random для заповнення масиву оцінок та через інші вхідні дані.
//
//Завдання 1
//["ІВ-73": ["Гончар Юрій", "Давиденко Костянтин", "Капінус Артем", "Науменко Павло", "Чередніченко Владислав"], "ІВ-72": ["Бортнік Василь", "Киба Олег", "Овчарова Юстіна", "Тимко Андрій"], "ІВ-71": ["Андрющенко Данило", "Гуменюк Олександр", "Корнійчук Ольга", "Музика Олександр", "Трудов Антон", "Феофанов Іван"]]
//
//Завдання 2
//["ІВ-73": ["Давиденко Костянтин": [5, 8, 9, 12, 11, 12, 0, 0, 14], "Капінус Артем": [5, 8, 12, 12, 0, 12, 12, 12, 11], "Науменко Павло": [4, 8, 0, 12, 12, 11, 12, 12, 15], "Чередніченко Владислав": [5, 8, 12, 12, 11, 12, 12, 12, 15], "Гончар Юрій": [5, 6, 0, 12, 0, 11, 12, 11, 14]], "ІВ-71": ["Корнійчук Ольга": [0, 0, 12, 9, 11, 11, 9, 12, 15], "Музика Олександр": [5, 8, 12, 0, 11, 12, 0, 9, 15], "Гуменюк Олександр": [5, 8, 12, 9, 12, 12, 11, 12, 15], "Трудов Антон": [5, 0, 0, 11, 11, 0, 12, 12, 15], "Андрющенко Данило": [5, 6, 0, 12, 12, 12, 0, 9, 15], "Феофанов Іван": [5, 8, 12, 9, 12, 9, 11, 12, 14]], "ІВ-72": ["Киба Олег": [5, 8, 12, 12, 11, 12, 0, 0, 11], "Овчарова Юстіна": [5, 8, 12, 0, 11, 12, 12, 12, 15], "Бортнік Василь": [4, 8, 12, 12, 0, 12, 9, 12, 15], "Тимко Андрій": [0, 8, 11, 0, 12, 12, 9, 12, 15]]]
//
//Завдання 3
//["ІВ-72": ["Бортнік Василь": 84, "Тимко Андрій": 79, "Овчарова Юстіна": 87, "Киба Олег": 71], "ІВ-73": ["Капінус Артем": 84, "Науменко Павло": 86, "Чередніченко Владислав": 99, "Гончар Юрій": 71, "Давиденко Костянтин": 71], "ІВ-71": ["Корнійчук Ольга": 79, "Трудов Антон": 66, "Андрющенко Данило": 71, "Гуменюк Олександр": 96, "Феофанов Іван": 92, "Музика Олександр": 72]]
//
//Завдання 4
//["ІВ-71": 79.333336, "ІВ-72": 80.25, "ІВ-73": 82.2]
//
//Завдання 5
//["ІВ-72": ["Бортнік Василь", "Киба Олег", "Овчарова Юстіна", "Тимко Андрій"], "ІВ-73": ["Давиденко Костянтин", "Капінус Артем", "Чередніченко Владислав", "Гончар Юрій", "Науменко Павло"], "ІВ-71": ["Музика Олександр", "Трудов Антон", "Гуменюк Олександр", "Феофанов Іван", "Андрющенко Данило", "Корнійчук Ольга"]]

/*
Variant = 8114 % 2 + 1 = 1
Name = Zikratyi Dmytro
Group = IV-81
*/
print("\nTask by variant 1\n")

class TimeDZ{
    var seconds: UInt
    var minutes: UInt
    var hours: UInt
    
    init(){
        self.seconds=0
        self.minutes=0
        self.hours=0
    }
    
    init(seconds_: UInt, minutes_: UInt, hours_: UInt) {
        if (seconds_<60 && seconds_>=0){
            self.seconds = seconds_
        }else{self.seconds=0}
        
        if (minutes_<60 && minutes_>=0){
            self.minutes = minutes_
        }else{self.minutes=0}
        
        if (hours_<24 && hours_>=0){
            self.hours = hours_
        }else{self.hours=0}
    }
    
    init(date: Date){
        let calendar = Calendar.current
        self.seconds = UInt(calendar.component(.second, from: date))
        self.minutes = UInt(calendar.component(.minute, from: date))
        self.hours = UInt(calendar.component(.hour, from: date))
    }
    
    func getTime() -> String{
        var timeAmPm: String
        var hours_out: UInt
        if self.hours<12{
            timeAmPm = "AM"
            hours_out = self.hours
            if hours_out == 0{
                timeAmPm = "PM"
                hours_out = 12
            }
            //return String(hours_out)+":"+String(self.minutes)+":"+String(self.seconds)+" "+timeAmPm
        }else{
            timeAmPm = "PM"
            hours_out = self.hours-12
            if hours_out == 0{
                timeAmPm = "AM"
                hours_out = 12
            }
        }
        var hour_str = String(hours_out)
        var min_str = String(minutes)
        var sec_str = String(seconds)
        if hours_out<10 {
            hour_str = "0" + hour_str
        }
        if minutes<10 {
            min_str = "0" + min_str
        }
        if seconds<10 {
            sec_str = "0" + sec_str
        }
        return hour_str+":"+min_str+":"+sec_str+" "+timeAmPm
    }
    
    func sumTime(objectTime: TimeDZ) -> TimeDZ {
        objectTime.seconds += self.seconds
        let over_minute = Float(objectTime.seconds)/60
        objectTime.seconds = objectTime.seconds % 60
        if over_minute>=1{
            objectTime.minutes += 1
        }
        objectTime.minutes += self.minutes
        let over_hour = Float(objectTime.minutes)/60
        objectTime.minutes = objectTime.minutes % 60
        if over_hour>=1{
            objectTime.hours += 1
        }
        objectTime.hours += self.hours
        let over_24 = Float(objectTime.hours)/24
        objectTime.hours = objectTime.hours % 24
        if (over_24>=1 && over_24 != 1.5){
            objectTime.hours += 1
        }
        return objectTime
    }
    
    func diffTime(objectTime: TimeDZ) -> TimeDZ {
        if self.seconds<objectTime.seconds{
            self.minutes-=1
            self.seconds=self.seconds+60-objectTime.seconds
        }else{
            self.seconds-=objectTime.seconds
        }
        if self.minutes<objectTime.minutes{
            self.hours-=1
            self.minutes=self.minutes+60-objectTime.minutes
        }else{
            self.minutes-=objectTime.minutes
        }
        if self.hours<objectTime.hours{
            self.hours=self.hours+24-objectTime.hours
        }else{
            self.hours-=objectTime.hours
        }
        return self
    }
    
    func sumTimeObjects(objectA: TimeDZ, objectB: TimeDZ) -> TimeDZ {
        objectA.seconds += objectB.seconds
        let over_minute=Float(objectA.seconds)/60
        objectA.seconds = objectA.seconds % 60
        if over_minute>=1{
            objectA.minutes += 1
        }
        objectA.minutes += objectB.minutes
        let over_hour = Float(objectA.minutes)/60
        objectA.minutes = objectA.minutes % 60
        if over_hour>=1{
            objectA.hours += 1
        }
        objectA.hours += objectB.hours
        let over_24 = Float(objectA.hours)/24
        objectA.hours = objectA.hours % 24
        if (over_24>=1 && over_24 != 1.5){
            objectA.hours += 1
        }
        return objectA
    }
    
    func diffTimeObjects(objectA: TimeDZ, objectB: TimeDZ) -> TimeDZ {
        if objectA.seconds<objectB.seconds{
            objectA.minutes-=1
            objectA.seconds=objectA.seconds+60-objectB.seconds
        }else{
            objectA.seconds-=objectB.seconds
        }
        if objectA.minutes<objectB.minutes{
            objectA.hours-=1
            objectA.minutes=objectA.minutes+60-objectB.minutes
        }else{
            objectA.minutes-=objectB.minutes
        }
        if objectA.hours<objectB.hours{
            objectA.hours=objectA.hours+24-objectB.hours
        }else{
            objectA.hours-=objectB.hours
        }
        return objectA
    }
}

print("Default init")
var timeObjectSimpleInit = TimeDZ()
print(timeObjectSimpleInit.getTime())

print("Pre-set params init")
var timeObjectParamsSet = TimeDZ(seconds_: 10, minutes_: 25, hours_: 16)
print(timeObjectParamsSet.getTime())

print("Date init")
let date = Date(timeIntervalSinceReferenceDate: -123456789.0)
var timeObject3 =  TimeDZ(date: date)
print(timeObject3.getTime())

print("TimeDZ object init")
var timeObject =  TimeDZ(seconds_: 59, minutes_: 59, hours_: 23)
print(timeObject.getTime())

var timeObject2 = TimeDZ(seconds_: 25, minutes_: 10, hours_: 12)
print("Sum method")
print(timeObject.sumTime(objectTime: TimeDZ(seconds_: 1, minutes_: 0, hours_: 12)).getTime())
print("Difference method")
print(timeObject2.diffTime(objectTime: TimeDZ(seconds_: 10, minutes_: 20, hours_: 5)).getTime())

print("Sum two objects method")
print(timeObject.sumTimeObjects(objectA: timeObjectParamsSet, objectB: timeObject3).getTime())
print("Difference two objects method")
print(timeObject.diffTimeObjects(objectA: timeObjectParamsSet, objectB: timeObject3).getTime())



