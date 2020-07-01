//Unique In Order
var uniqueInOrder=function(iterable){
    let string = [];
    if (typeof iterable === 'string') {
        iterable=iterable.split('');
    } 
    for (var i = 0; i < iterable.length; i++) {
        if (iterable[i] !== iterable[i+1]) {
            string.push(iterable[i]);
        }
    }
    return string;
}



//Indexed capitalization
function capitalize(s,arr){
    let letters = s.split('');
    let result = [];
    letters.forEach(function(letter, index) {
        if (arr.includes(index)) {
            result.push(letter.toUpperCase());
        } else {
            result.push(letter);
        }
    })
    result = result.join('');
    return result;
};


//C.Wars
function initials(n){
    let names = n.split(' ');
    let initials = [];
    let lastName = names[names.length -1];
    lastName = `${lastName[0].toUpperCase()}${lastName.slice(1)}`
    
    for (let i = 0; i < names.length-1; i++) {
        initials.push(`${names[i][0].toUpperCase()}.`);
    }

    initials.push(lastName)
    initials = initials.join('')
    return initials
}

//Sentences should start with capital letters.
function fix(paragraph){
    let array = paragraph.split('. ');
    
    
    if (paragraph === "") {
        return paragraph
    
    } else if (array.length === 1){
        return `${array[0][0].toUpperCase()}${array[0].slice(1)}`
    
    } else {
        let capitalArr = [];
        for (let i = 0; i < array.length; i++) {
            let capSentence = `${array[i][0].toUpperCase()}${array[i].slice(1)}`;
            capitalArr.push(`${capSentence}`);
        }
    
        let final = capitalArr.join('. ')
        return final
    }
}

//Round up to the next multiple of 5
function roundToNext5(n){
    while (n % 5 != 0) {
        n ++
    }
    return n
}