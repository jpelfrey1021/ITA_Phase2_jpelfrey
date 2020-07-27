<?php

//Convert string to camel case
function toCamelCase($str){
    $str = str_replace('-', '_', $str);
    $array = explode('_', $str);

    $first = array_slice($array, 0, 1);
    $upper = array_slice($array, 1);
    $final = [$first[0]];

    foreach ($upper as $word) {
        $word = ucfirst($word);
        $final[] = $word;
    }

    $result = implode('', $final);
    return $result;
}

//Count the smiley faces!
function count_smileys($arr): int {
    $count = 0;
    for ($x = 0; $x < count($arr); $x++) {
        if ($arr[$x][0] == ":" || $arr[$x][0] == ";") {
            if ($arr[$x][1] == "-" || $arr[$x][1] == "~") {
                if ($arr[$x][2] == "D" || $arr[$x][2] == ")") {
                $count++;
                }
            } else if ($arr[$x][1] == "D" || $arr[$x][1] == ")") {
                $count++;
            }
        } 
    }
    return $count;
}

//Dashatize it
function dashatize(int $num): string {
    $num = str_replace('-','',$num); //get rid of any existing dashes
    $numArr = str_split($num); //make it an array
    $finalArr = []; //will hold final array with dashes
    
    for ($x = 0; $x < count($numArr); $x++) {
      $finalArr[] = $numArr[$x]; //put number in the new array
      //if this number or the next is a negative and it's not the last number add
      //a dash after the number
        if (($numArr[$x] % 2 != 0 || $numArr[$x+1] % 2 != 0) && $x != count($numArr) -1) {
            $finalArr[] = '-';
        } 
    }
    return implode('', $finalArr); //convert back to a string
}


//Simple remove duplicates
function solve($arr) {
    $length = count($arr);
    
    for ($x = 0; $x < $length; $x++) {
        $adjustedArr = $arr;
        unset($adjustedArr[$x]);

        if (in_array($arr[$x],$adjustedArr)) {
            unset($arr[$x]);
        }
    }
    
    return array_values($arr);
}


//Multiples of 3 or 5
function solution($number){
    $multiples = [];
    for ($x = 1; $x < $number; $x++) {
        if ($x % 3 == 0 || $x % 5 == 0) {
            $multiples[] = $x;
        }
    }
    $sum = 0;
    foreach ($multiples as $num) {
        $sum += $num;
    }
    return $sum;
<<<<<<< HEAD
}
=======
}
>>>>>>> 7d57591c7d613fb2149b85d0490b434dcd592c58
