<?php

//Array.diff
function arrayDiff($a, $b) {
    foreach ($b as $character) {
        if (in_array($character, $a)) {

            foreach($a as $index=>$val) {
                if ($val == $character) {
                    unset($a[$index]);
                }
            }
        }
    }
    array_splice($a, 0, 0);
    return $a;
}


//Mean Square Error
function solution(array $a, array $b): float {
    $length = count($a);
    $total = 0;
    
    for ($x = 0; $x<$length; $x++) {
        $total += pow($a[$x]-$b[$x],2);
    }
    
    return $total / $length;
}