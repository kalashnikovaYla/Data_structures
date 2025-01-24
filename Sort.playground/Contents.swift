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

    // Если остались элементы в правой части, добавляем их
    while rightIndex < right.count {
        mergedArray.append(right[rightIndex])
        rightIndex += 1
    }
    
    return mergedArray
}

// Пример использования
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
