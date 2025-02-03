import UIKit

func quicksort<T: Comparable>(_ array: [T]) -> [T] {
    
    guard array.count > 1 else {
        return array
    }
 
    let pivot = array[array.count / 2]
 
    let less = array.filter { $0 < pivot }
    let equal = array.filter { $0 == pivot }
    let greater = array.filter { $0 > pivot }

    return quicksort(less) + equal + quicksort(greater)
}

func mergeSort<T: Comparable>(_ array: [T]) -> [T] {
    guard array.count > 1 else {
        return array
    }
 
    let middleIndex = array.count / 2
   
    
    let leftArray = mergeSort(Array(array[0..<middleIndex]))
    let rightArray = mergeSort(Array(array[middleIndex..<array.count]))
    
    return merge(leftArray, rightArray)
}

func merge<T: Comparable>(_ left: [T], _ right: [T]) -> [T] {
    var leftIndex = 0
    var rightIndex = 0
    var mergedArray: [T] = []
    
    // Сливаем до тех пор, пока есть элементы в обеих частях
    while leftIndex < left.count && rightIndex < right.count {
        if left[leftIndex] < right[rightIndex] {
            mergedArray.append(left[leftIndex])
            leftIndex += 1
        } else {
            mergedArray.append(right[rightIndex])
            rightIndex += 1
        }
    }
    
    // Если остались элементы в левой части, добавляем их
    while leftIndex < left.count {
        mergedArray.append(left[leftIndex])
        leftIndex += 1
    }
    while rightIndex < right.count {
        mergedArray.append(right[rightIndex])
    }
    return mergedArray
}

 
let unsortedArray = [6,4,3,2,8,9]
let sortedArray = mergeSort(unsortedArray)


func insertionSort(array: inout [Int]) {
    let n = array.count
    
    for j in 1..<n {
        let key = array[j]
        var i = j - 1
        
        while i >= 0 && array[i] > key {
            array[i + 1] = array[i]
            i -= 1 
        }
        array[i + 1] = key
    }
}

//var nums = [6,4,3,2]
//insertionSort(array: &nums)


func bubbleSort(_ array: inout [Int]) {
    let n = array.count
    
    for i in 0..<n {
        var swapped = false
       
        for j in 0..<n - i - 1 {
            if array[j] > array[j + 1] {
                // Используем временную переменную для хранения значения
                let temp = array[j]
                array[j] = array[j + 1]
                array[j + 1] = temp
                swapped = true
            }
        }
        // Если на этом этапе не произошло обменов, массив уже отсортирован
        if !swapped { 
            break
        }
    }
}

var numbers = [64, 34, 25, 12, 22, 11, 90]
bubbleSort(&numbers)
print(numbers)  // Вывод: [11, 12, 22, 25, 34, 64, 90]
 
  
