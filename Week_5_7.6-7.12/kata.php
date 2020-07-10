<?php

//2. Exclamation marks series #1: Remove a exclamation mark from the end of string
function remove(string $s): string {
    $array = str_split($s);
    $length = count($array) -1;

    if ($array[$length] == "!") {
        unset($array[$length]);
    }
    
    $string = implode("",$array);
    return $string;
}

//3. String ends with?
function solution($str, $ending) {
    if ($ending == '') {
        return true;
    }
    
    $first = str_split($str);
    $second = str_split($ending);
    
    $length = count($second);
    $startingPoint = count($first) - $length;
    
    $array2 = array_slice($first, $startingPoint, $length);
    
    $firstStr = implode("",$array2);

    return $firstStr === $ending;
}

//4. Find The Parity Outlier
function find($integers) {
    $countEven = 0;
    $countOdd = 0;
    $chosenOne;
    
    //find if all numbers are even or odd
    foreach ($integers as $number) {
        if ($number % 2 == 0) {
            $countEven++;
        } else {
            $countOdd++;
        }
    }
    
    foreach ($integers as $number) {
      //if only 1 is even find that 1
        if ($countEven == 1) {
            if ($number % 2 == 0) {
                $chosenOne = $number;
            }
        //if only 1 is odd find that 1
        } elseif ($countOdd == 1) {
            if ($number % 2 != 0) {
                $chosenOne = $number;
            }
        }
    }
    
    return $chosenOne;
}


//.5 Linux history and `!` command. Series#1 The `!!` command
function bangBang($history){
    //make the string an array split on a space
    $historyArr = explode(" ", $history);
    $lastNumber = 0;
    
    //find the last number that is no all zeros in that array
    foreach ($historyArr as $item) {
        if (is_numeric($item) && isAllZeros($item)) {
            $lastNumber = $item;
        }
    }
    
    //split the OG array into 2 on the last number
    $pieces = explode($lastNumber, $history);
    //trim out the whitespace
    $trimmed = trim($pieces[1]);
    return $trimmed;
}

    //check if the numeric string is all 0s
    function isAllZeros($item) {
        //split inputed array
        $arr = str_split($item);
        $arrNotZero = [];
        //for each item if it is not a 0 add to array
        foreach ($arr as $num) {
            if ($num != 0) {
                $arrNotZero[] = $num;
            }
        }       
        //if arrNotZero has a number it is good, return true. if it is empty return false.
        if ($arrNotZero) {
            return true;
        } else {
            return false;
        }
    }