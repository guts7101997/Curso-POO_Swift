import Foundation

//arrays
var array: [Int] = [1,2,3,4,5]
array.append(3)
array.remove(at: 2)
print(array)

//sets

var set : Set<String> = ["açao", "ficcao-cientifica"]
set.insert("terror")
print(set)

var set2 : Set<String> = ["ficcao-cientifica"]
print(set.intersection(set2))

//tuplas 
var tupla = (lugar: "Mcdonalds", valor: 30)
print(tupla.valor)

//dicionario
var dicionario : [String : Int] = ["X": 1, "Y": 2]
dicionario["B"] = 4
print(dicionario["X", default: 0])