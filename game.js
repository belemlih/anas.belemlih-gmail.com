window.onload = function() {

  var collection_card = loadCard();
  cardPlayers();
  paloTriunfo(collection_card);

  // add img to button

  var card1 = document.getElementById("button1");
  card1.style.backgroundImage = "url('Cartas/" + collection_card[0] + ".jpg')";
  document.getElementById("button1").style.backgroundSize = '100%';

  var card2 = document.getElementById("button2");
  card2.style.backgroundImage = "url('Cartas/" + collection_card[1] + ".jpg')";
  document.getElementById("button2").style.backgroundSize = '100%';

  var card3 = document.getElementById("button3");
  card3.style.backgroundImage = "url('Cartas/" + collection_card[2] + ".jpg')";
  document.getElementById("button3").style.backgroundSize = '100%';

  var card4 = document.getElementById("button4");
  card4.style.backgroundImage = "url('Cartas/" + collection_card[3] + ".jpg')";
  document.getElementById("button4").style.backgroundSize = '100%';

  var card5 = document.getElementById("button5");
  card5.style.backgroundImage = "url('Cartas/" + collection_card[4] + ".jpg')";
  document.getElementById("button5").style.backgroundSize = '100%';

  var card6 = document.getElementById("button6");
  card6.style.backgroundImage = "url('Cartas/" + collection_card[5] + ".jpg')";
  document.getElementById("button6").style.backgroundSize = '100%';

  var card7 = document.getElementById("button7");
  card7.style.backgroundImage = "url('Cartas/" + collection_card[6] + ".jpg')";
  document.getElementById("button7").style.backgroundSize = '100%';

  var card8 = document.getElementById("button8");
  card8.style.backgroundImage = "url('Cartas/" + collection_card[7] + ".jpg')";
  document.getElementById("button8").style.backgroundSize = '100%';

  // eventos para activar el boton
  card1.addEventListener("click", function() {
    putCard(card1, 1, collection_card[0]);
  });
  card2.addEventListener("click", function() {
    putCard(card2, 2, collection_card[1]);
  });
  card3.addEventListener("click", function() {
    putCard(card3, 3, collection_card[2]);
  });
  card4.addEventListener("click", function() {
    putCard(card4, 4, collection_card[3]);
  });
  card5.addEventListener("click", function() {
    putCard(card5, 1, collection_card[4]);
  });
  card6.addEventListener("click", function() {
    putCard(card6, 2, collection_card[5]);
  });
  card7.addEventListener("click", function() {
    putCard(card7, 3, collection_card[6]);
  });
  card8.addEventListener("click", function() {
    putCard(card8, 4, collection_card[7]);
  });
}

// coloca el palo de triunfu
function paloTriunfo(collection_card) {

  var trinfu = document.getElementById("button9");
  trinfu.style.backgroundColor = "green";
  trinfu.style.backgroundImage = "url('Cartas/" + collection_card[7] + ".jpg')";
  trinfu.style.backgroundSize = '100%';
  trinfu.style.top = "400px";
  trinfu.style.left = "1080px";
}


// carga las cartas del jugador
function loadCard() {
  var carta = new Array();
  carta[0] = "1bastos";
  carta[1] = "4espada";
  carta[2] = "4oro";
  carta[3] = "5copas";
  carta[4] = "10oro";
  carta[5] = "11bastos";
  carta[6] = "11copas";
  carta[7] = "11oro";
  return carta;
}

// coloca las cartas boca abajo de los otro jugadores
function cardPlayers() {

  for (let i = 1; i <= 8; i++) {
    document.getElementById("button1" + i).style.backgroundImage = "url('Cartas/reverso2.jpg')";
    document.getElementById("button1" + i).style.backgroundSize = '98%';

    document.getElementById("button2" + i).style.backgroundImage = "url('Cartas/reverso2.jpg')";
    document.getElementById("button2" + i).style.backgroundSize = '98%';

    document.getElementById("button3" + i).style.backgroundImage = "url('Cartas/reverso1.jpg')";
    document.getElementById("button3" + i).style.backgroundSize = '101%';
  }
}

// coloca las cartas lanzadas
//esta funcion recibe el boton,la posicion del jugador y la carta seleccionada
function putCard(button, position, collection_card) {

  if (position == 1) {

    button.style.backgroundColor = "green";
    button.style.top = "400px";
    button.style.backgroundImage = "url('Cartas/" + collection_card + ".jpg')";
    button.style.left = "440px";

  } else if (position == 2) {

    button.style.backgroundColor = "green";
    button.style.top = "400px";
    button.style.backgroundImage = "url('Cartas/" + collection_card + ".jpg')";
    button.style.left = "600px";

  } else if (position == 3) {

    button.style.backgroundColor = "green";
    button.style.top = "400px";
    button.style.backgroundImage = "url('Cartas/" + collection_card + ".jpg')";
    button.style.left = "760px";

  } else if (position == 4) {
    button.style.backgroundColor = "green";
    button.style.top = "400px";
    button.style.backgroundImage = "url('Cartas/" + collection_card + ".jpg')";
    button.style.left = "920px";
  }
}
