import UIKit

func merge(nums1: [Int], nums2: [Int]) -> [Int] {
    var array = Array(repeating: 0, count: nums1.count + nums2.count)
    var first = 0
    var first2 = 0
    
    
    for i in 0..<(nums1.count + nums2.count) {
        if first != nums1.count, (first2 == nums2.count || nums1[first] <= nums2[first2]) {
            
            array[i] = nums1[first]
            first += 1
        } else {
            array[i] = nums2[first2]
            first2 += 1
        }
    }
    return array
}


merge(nums1: [1], nums2: [0, 2])
