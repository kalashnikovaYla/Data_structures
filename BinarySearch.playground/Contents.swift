import Foundation


func binarySearch(nums: [Int], target: Int) -> Int {
    var low = 0
    var hight = nums.count
    
    while low <= hight {
        let middle = (low + hight)/2
        
        if nums[middle] == target {
            return middle
        } else if  nums[middle] > target {
            hight = middle - 1
        } else {
            low = middle + 1
        }
    }
    return low
}

 
binarySearch(nums: [1,2,3,5,6,9,13], target: 9)


//В управлении совета входят родители, учителя, ученики, родителей дб не менее 1/3. Сколько нужно добавить родителей, чтобы их стало не менее 1/3

func searchParents(numbers: Int, parents: Int) -> Int {
    var min = 0
    var max = numbers
    
    while min < max {
        let mid = (min + max)/2
        
        if (parents + mid) * 3 >= numbers + mid {
            max = mid
        } else {
            min = mid + 1
        }
    }
    return min
}


//Юра выбрал на сайте leetcode N задач. В 1 день решил k задач, в каждый следующий день решал на 1 задачу больше чем в предыдущий день. Определите сколько уйдет дней на подготовку к собеседованиям
func leetcodeSearch(numbers: Int, k: Int) -> Int {
    var min = 0
    var max = numbers
    
    while min < max {
        let mid = (min + max) / 2
        if (k + (k + mid - 1)) * mid/2 >= numbers {
            max = mid
        } else {
            min = mid + 1
        }
    }
    return min
}


//Доска W * H сантиметров, нужно разместить на доске N квадратных стикеров. Определите максимальную длинну стороны стикера, чтобы все стикеры поместились на доске, даже если останутся незаполненные ряды

func s(numbers: Int, width: Int, height: Int) -> Int {
    var min = 0
    var max = numbers
    
    while min != max {
        let mid = (min + max + 1) / 2
        if (width/mid) * (height/mid) >= numbers {
            min = mid
        } else {
            max = mid - 1
        }
    }
    return min
}
s(numbers: 4, width: 20, height: 20)


//Дана отсортированная по неубыванию последовательность из N чисел и число X. Необходимо определить индекс первого числа в последовательности, которое больше или равно X. Если такого числа нет, вернуть число N. По неубыванию - мб одинаковые числа
func search(array: [Int], x: Int) -> Int {
    var min = 0
    var max = array.count - 1
    
    while min <= max {
        
        let mid = (min + max) / 2
        
        if array[mid] > x {
            max = mid - 1
        } else if array[mid] < x {
            min = mid + 1
        } else {
            return mid
        }
    }
    return array.count
}
