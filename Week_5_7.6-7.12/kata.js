//1. Maximum Length Difference
function mxdiflg(a1, a2) {
    //if array is empty return -1 and stop
    if (a1 == 0 || a2 == 0) {
        return -1  
    }
    
    //initial values for our max and mins
    let largeX = '';
    let largeY = '';
    let smallX = a1[0].length;
    let smallY = a2[0].length;
    
    //find max and min for the first array
    for (let i = 0; i < a1.length; i++) {
        if (a1[i].length > largeX) {
            largeX = a1[i].length
        }
        if (a1[i].length < smallX) {
            smallX = a1[i].length
        }
    }
    
    //find max and min for the second array
    for (let i = 0; i < a2.length; i++) {
        if (a2[i].length > largeY) {
            largeY = a2[i].length
        }
        if (a2[i].length < smallY) {
            smallY = a2[i].length
        }
    }
    
    //find our two possible answers
    let option1 = largeX - smallY
    let option2 = largeY - smallX
    
    //return the greater of the two answers
    if (option1 > option2) {
        return option1
    } else {
        return option2
    }
}