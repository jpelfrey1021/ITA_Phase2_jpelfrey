var slideIndex = 1;
showSlides(slideIndex);

// Next/previous controls
function plusSlides(n) {
  showSlides(slideIndex += n);
}

// Thumbnail image controls
function currentSlide(n) {
  showSlides(slideIndex = n);
}

function showSlides(n) {
  var i;
  var slides = document.getElementsByClassName("mySlides");
  var dots = document.getElementsByClassName("dot");
  if (n > slides.length) {slideIndex = 1}
  if (n < 1) {slideIndex = slides.length}
  for (i = 0; i < slides.length; i++) {
      slides[i].style.display = "none";
  }
  for (i = 0; i < dots.length; i++) {
      dots[i].className = dots[i].className.replace(" active", "");
  }
  slides[slideIndex-1].style.display = "block";
  dots[slideIndex-1].className += " active";
}

//expands drop down menu when selected
function showTimeFrames() {
  var x = document.getElementById("timeframe__menu");
  if (x.style.display === "block") {
      x.style.display = "none";
  } else {
      x.style.display = "block";
  }
}

//update time shown as featured on drop down when new time is selected. takes in the selected option
function updateTime(time) {
  //find all time frames
  var timeFrames = document.querySelectorAll(".month-option")

  //find the element that will show selected time and set it to the chosen time
  var x = document.getElementById("chosen-time");
  x.innerHTML = time;

  //remove active class from all time frames then add it to the chosen time
  [].forEach.call(timeFrames, function(frame) {
    if (frame.classList.contains("active-time")) {
      frame.classList.remove("active-time");
    }
    if (frame.children[0].innerHTML == time) {
      frame.classList.add("active-time");
    }
    
  });

  //contract the drop down list
  var y = document.getElementById("timeframe__menu");
  y.style.display = "none";
}



function displayPayment(accountLinked = false) {
  let content = document.getElementById("paymentDisplay");
  let bankButton = document.getElementById("linkAccount");
  let paymentButton = document.getElementById("makePayment");
  if (accountLinked ===false) {
    content.innerHTML = 
    `<div class="linked-icon-container">
      <i class="fa fa-exclamation alert-not-linked" aria-hidden="true"></i>
    </div>
    <div class="linked-content">
      <p>
        No data to show on this screen. Start linking your loan and bank accounts to display your savings and round-ups
      </p>
    </div>`

    bankButton.style.display = "block";
    paymentButton.style.display = "none";
  } else {
    content.innerHTML = 
    `<div class="linked-icon-container">
      <i class="fa fa-exclamation alert-linked" aria-hidden="true"></i>
    </div>
    <div class="linked-content">
      <p>
      Awesome, you've linked your loan and bank accounts, your data will update as soon as you make your first Round-up, recurring and/or one-time payment
      </p>
    </div>`

    bankButton.style.display = "none";
    paymentButton.style.display = "block";
  }
}

var previousElement;

function expandDetails(title) {
  var el = document.getElementById(title);
  if (el.classList.contains("hidden")) {
    el.classList.remove("hidden");
    el.parentElement.classList.add("details-active")
  } else {
    el.classList.add("hidden");
    el.parentElement.classList.remove("details-active")
  }

  if (previousElement) {
    if (! previousElement.classList.contains("hidden")) {
      previousElement.classList.add("hidden");
      previousElement.parentElement.classList.remove("details-active")
    }
  }

  previousElement = el;
}

function showElement(id1, id2, id3) {
  let div = document.getElementById(id1)
  let div2 = document.getElementById(id2)
  let div3 = document.getElementById(id3)
  if (div.classList.contains("hidden")) {
    div.classList.remove('hidden');
    div2.classList.add('hidden');
    div3.classList.add('hidden');
  } else {
    div.classList.add('hidden');
  }
}

function expandPage() {
  let header = document.getElementById('poolHeader');
  let main = document.getElementById('poolMain');
  main.classList.toggle('expanded');
  header.classList.toggle('hidden')
  window.scrollTo(0,0);
}


