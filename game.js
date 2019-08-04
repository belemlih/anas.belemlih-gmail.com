window.onload = function() {

  layout = document.getElementById("mainLayout");
  view = layout.getContext("2d");

  var heightScreen = (window.screen.height / 100) * 4;
  var widthScrenn = (window.screen.width / 100) * 14.8;

  //alert(widthScrenn);
  var buttonX = 80;
  var buttonY = 535;
  var buttonW = 100;
  var buttonH = 160;
  var collection_card = cartas();

  //muestra las cartas boca abajo de los otros cartas_jugadores
  //se envia el entorno de canvas mas la cantidad de cartas que tienen los otros jugadores jugador
  cartas_jugadores(view, 5);

  //creacion de la imagen y colocacion de la imagen en el tablero.
  var img = new Image();
  img.src = 'Cartas/' + collection_card[0] + '.jpg';
  img.onload = () => {
    view.drawImage(img, buttonX, buttonY, buttonW, buttonH);
  };
  const img1 = new Image();
  img1.src = 'Cartas/' + collection_card[1] + '.jpg';
  img1.onload = () => {
    view.drawImage(img1, 185, buttonY, buttonW, buttonH);
  };
  const img2 = new Image();
  img2.src = 'Cartas/' + collection_card[2] + '.jpg';
  img2.onload = () => {
    view.drawImage(img2, 290, buttonY, buttonW, buttonH);
  };
  const img3 = new Image();
  img3.src = 'Cartas/' + collection_card[3] + '.jpg';
  img3.onload = () => {
    view.drawImage(img3, 395, buttonY, buttonW, buttonH);
  };
  const img4 = new Image();
  img4.src = 'Cartas/' + collection_card[4] + '.jpg';
  img4.onload = () => {
    view.drawImage(img4, 500, buttonY, buttonW, buttonH);
  };
  const img5 = new Image();
  img5.src = 'Cartas/' + collection_card[5] + '.jpg';
  img5.onload = () => {
    view.drawImage(img5, 605, buttonY, buttonW, buttonH);
  };
  const img6 = new Image();
  img6.src = 'Cartas/' + collection_card[6] + '.jpg';
  img6.onload = () => {
    view.drawImage(img6, 710, buttonY, buttonW, buttonH);
  };
  const img7 = new Image();
  img7.src = 'Cartas/' + collection_card[7] + '.jpg';
  img7.onload = () => {
    view.drawImage(img7, 815, buttonY, buttonW, buttonH);
  };



  //validacion de posicion del jugador y movimiento de carta
  // por el momento solo se va a validr el movimiento de la cartas
  // ademas se valida  que no vuelva a lanzar otra carta, esto en el arreglo al sacar la carta
  layout.addEventListener('click', function(event) {
    // Executes if button was clicked!&&event.y > buttonY &&event.y < buttonY + buttonH
    //alert(event.x + " " + event.y);
    alert(buttonX);
    if (event.x > buttonX + widthScrenn && event.x < buttonX + buttonW + widthScrenn && event.y > buttonY + heightScreen && event.y < buttonY + buttonH + heightScreen) {
      //clearRect remover posicion actual de la carta en el tablero
      view.clearRect(buttonX, buttonY, buttonW, buttonH);
      //carta lanzada por el jugador
      putCard(1, collection_card[0], view);

    } else if (event.x > 185 + widthScrenn && event.x < 185 + buttonW + widthScrenn && event.y > buttonY + heightScreen && event.y < buttonY + buttonH + heightScreen) {
      //clearRect remover posicion actual de la carta en el tablero
      view.clearRect(185, buttonY, buttonW, buttonH);
      //carta lanzada por el jugador
      putCard(2, collection_card[1], view);

    } else if (event.x > 290 + widthScrenn && event.x < 290 + buttonW + widthScrenn && event.y > buttonY + heightScreen && event.y < buttonY + buttonH + heightScreen) {
      //clearRect remover posicion actual de la carta en el tablero
      view.clearRect(290, buttonY, buttonW, buttonH);
      //carta lanzada por el jugador
      putCard(3, collection_card[2], view);

    } else if (event.x > 395 + widthScrenn && event.x < 395 + buttonW + widthScrenn && event.y > buttonY + heightScreen && event.y < buttonY + buttonH + heightScreen) {
      //clearRect remover posicion actual de la carta en el tablero
      view.clearRect(395, buttonY, buttonW, buttonH);
      //carta lanzada por el jugador
      putCard(4, collection_card[3], view);

    } else if (event.x > 500 + widthScrenn && event.x < 500 + buttonW + widthScrenn && event.y > buttonY + heightScreen && event.y < buttonY + buttonH + heightScreen) {
      //clearRect remover posicion actual de la carta en el tablero
      view.clearRect(500, buttonY, buttonW, buttonH);
      //carta lanzada por el jugador
      putCard(3, collection_card[4], view);

    } else if (event.x > 605 + widthScrenn && event.x < 605 + buttonW + widthScrenn && event.y > buttonY + heightScreen && event.y < buttonY + buttonH + heightScreen) {
      //clearRect remover posicion actual de la carta en el tablero
      view.clearRect(605, buttonY, buttonW, buttonH);
      //carta lanzada por el jugador
      putCard(4, collection_card[5], view);

    } else if (event.x > 710 + widthScrenn && event.x < 710 + buttonW + widthScrenn && event.y > buttonY + heightScreen && event.y < buttonY + buttonH + heightScreen) {
      //clearRect remover posicion actual de la carta en el tablero
      view.clearRect(710, buttonY, buttonW, buttonH);
      //carta lanzada por el jugador
      putCard(4, collection_card[6], view);

    } else if (event.x > 815 + widthScrenn && event.x < 815 + buttonW + widthScrenn && event.y > buttonY + heightScreen && event.y < buttonY + buttonH + heightScreen) {
      //clearRect remover posicion actual de la carta en el tablero
      view.clearRect(815, buttonY, buttonW, buttonH);
      //carta lanzada por el jugador
      putCard(4, collection_card[7], view);

    }
  });

}

// metodo para mover la carta que el jugagor eligio
// en este metodo ingresa la posicion del jugador,la carta y el entorno de canvas
// la posicion se refiere al turno del jugador
function putCard(posicion, collection_card, view) {

  if (posicion == 1) {
    var img = new Image();
    img.src = 'Cartas/' + collection_card + '.jpg';
    img.onload = () => {
      view.drawImage(img, 250, 250, 100, 160);
    };
  } else if (posicion == 2) {
    var img = new Image();
    img.src = 'Cartas/' + collection_card + '.jpg';
    img.onload = () => {
      view.drawImage(img, 360, 250, 100, 160);
    };

  } else if (posicion == 3) {
    var img = new Image();
    img.src = 'Cartas/' + collection_card + '.jpg';
    img.onload = () => {
      view.drawImage(img, 470, 250, 100, 160);
    };

  } else if (posicion == 4) {
    var img = new Image();
    img.src = 'Cartas/' + collection_card + '.jpg';
    img.onload = () => {
      view.drawImage(img, 580, 250, 100, 160);
    };

  }

  //return img;
}

function cartas() {
  //accerder a la peticion para retornar los datos de la carta,visualizarlos y asignacion de collection_card
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

// metodo que muestras las cartas boca abajo de los otros jugadores

function cartas_jugadores(view, value) {
  var x = 250;
  var y = 50;
  var z1 = 50;

  for (let i = 0; i < 8; i++) {
    var img1 = new Image();
    img1.src = 'Cartas/reverso1.jpg';
    img1.onload = () => {
      view.drawImage(img1, x, 5, 60, 90);
      x += 65;
    };
  }

  for (let i = 0; i < 8; i++) {
    var img3 = new Image();
    img3.src = 'Cartas/reverso2.jpg';
    img3.onload = () => {
      view.drawImage(img3, 900, z1, 90, 50);
      z1 += 55;
    };
  }

  for (let i = 0; i < 8; i++) {
    var img2 = new Image();
    img2.src = 'Cartas/reverso2.jpg';
    img2.onload = () => {
      view.drawImage(img2, 10, y, 90, 50);
      y += 55;
    };
  }
}
