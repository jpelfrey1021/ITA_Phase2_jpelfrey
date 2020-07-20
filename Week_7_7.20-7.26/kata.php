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