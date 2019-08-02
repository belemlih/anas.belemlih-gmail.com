window.onload = function() {

  layout = document.getElementById("mainLayout");
  view = layout.getContext("2d");

  var heightScreen = (window.screen.height / 100) * 4;
  var widthScrenn = (window.screen.width / 100) *14.8;

  //alert(widthScrenn);
  var buttonX = 30;
  var buttonY = 535;
  var buttonW = 100;
  var buttonH = 160;
  var collection_card=cartas();
  alert(collection_card[1]);
  var dir = "collection_card/";
  // id,palo,numero

    const img = new Image();
    img.src = 'Cartas/'+collection_card[0]+'.jpg';
    img.onload = () => {
      view.drawImage(img, buttonX, buttonY, buttonW, buttonH);
    };
    const img1 = new Image();
    img1.src = 'Cartas/'+collection_card[1]+'.jpg';
    img1.onload = () => {
      view.drawImage(img1, 135, buttonY, buttonW, buttonH);
    };
    const img2 = new Image();
    img2.src = 'Cartas/'+collection_card[2]+'.jpg';
    img2.onload = () => {
      view.drawImage(img2, 240, buttonY, buttonW, buttonH);
    };
    const img3 = new Image();
    img3.src = 'Cartas/'+collection_card[3]+'.jpg';
    img3.onload = () => {
      view.drawImage(img3, 345, buttonY, buttonW, buttonH);
    };
    const img4 = new Image();
    img4.src = 'Cartas/'+collection_card[4]+'.jpg';
    img4.onload = () => {
      view.drawImage(img4, 450, buttonY, buttonW, buttonH);
    };
    const img5 = new Image();
    img5.src = 'Cartas/'+collection_card[5]+'.jpg';
    img5.onload = () => {
      view.drawImage(img5, 555, buttonY, buttonW, buttonH);
    };
    const img6= new Image();
    img6.src = 'Cartas/'+collection_card[6]+'.jpg';
    img6.onload = () => {
      view.drawImage(img6, 660, buttonY, buttonW, buttonH);
    };
    const img7 = new Image();
    img7.src = 'Cartas/'+collection_card[7]+'.jpg';
    img7.onload = () => {
      view.drawImage(img7, 765, buttonY, buttonW, buttonH);
    };
    const img8 = new Image();
    img8.src = 'Cartas/'+collection_card[7]+'.jpg';
    img8.onload = () => {
      view.drawImage(img8, 870, buttonY, buttonW, buttonH);
    };

    img8.onload = () => {
      view.drawImage(img8, 870, 150, buttonW, buttonH);
    };

    layout.addEventListener('click', function(event) {
      // Control that click event occurred within position of button
      // NOTE: This assumes canvas is positioned at top left corner
      alert(event.x + " " + event.y);
      if (event.x > buttonX + widthScrenn && event.x < buttonX + buttonW + widthScrenn && event.y > buttonY + heightScreen && event.y < buttonY + buttonH + heightScreen) {
        // Executes if button was clicked!&&event.y > buttonY &&event.y < buttonY + buttonH
        alert('Button was clicked!+1');
      }else if (event.x > 135 + widthScrenn && event.x < 135 + buttonW + widthScrenn && event.y > buttonY + heightScreen && event.y < buttonY + buttonH + heightScreen) {
        alert('Button was clicked!+2');

      }else if (event.x > 240 + widthScrenn && event.x < 240 + buttonW + widthScrenn && event.y > buttonY + heightScreen && event.y < buttonY + buttonH + heightScreen) {
        alert('Button was clicked!+3');

      }else if (event.x > 345 + widthScrenn && event.x < 345 + buttonW + widthScrenn && event.y > buttonY + heightScreen && event.y < buttonY + buttonH + heightScreen) {
        alert('Button was clicked!+4');

      }else if (event.x > 450 + widthScrenn && event.x < 450 + buttonW + widthScrenn && event.y > buttonY + heightScreen && event.y < buttonY + buttonH + heightScreen) {
        alert('Button was clicked!+5');

      }else if (event.x > 555 + widthScrenn && event.x < 555 + buttonW + widthScrenn && event.y > buttonY + heightScreen && event.y < buttonY + buttonH + heightScreen) {
        alert('Button was clicked!+6');

      }else if (event.x > 660 + widthScrenn && event.x < 660 + buttonW + widthScrenn && event.y > buttonY + heightScreen && event.y < buttonY + buttonH + heightScreen) {
        alert('Button was clicked!+7');

      }else if (event.x > 765 + widthScrenn && event.x < 765 + buttonW + widthScrenn && event.y > buttonY + heightScreen && event.y < buttonY + buttonH + heightScreen) {
        alert('Button was clicked!+8');
        
      }
    });

    //evento de la cartas para seleccion por parte del usuario.

    //setInterval(score(buttonX,buttonY,buttonW,buttonY), 500);


  /*const img = new Image();
  img.src = './img.png';
  img.onload = () => {
    view.drawImage(img, buttonX, buttonY, buttonW, buttonH);
  };
  const img1 = new Image();
  img1.src = './img.png';
  img1.onload = () => {
    view.drawImage(img, 240, buttonY, 50, 60);
  };
  const img2 = new Image();
  img2.src = './img.png';
  img2.onload = () => {
    view.drawImage(img, 300, buttonY, 50, 60);
  };
  const img3 = new Image();
  img3.src = './img.png';
  img3.onload = () => {
    view.drawImage(img, 360, buttonY, 50, 60);
  };
  const img4 = new Image();
  img4.src = './img.png';
  img4.onload = () => {
    view.drawImage(img, 420, buttonY, 50, 60);
  };
  const img5 = new Image();
  img5.src = './img.png';
  img5.onload = () => {
    view.drawImage(img, 480, buttonY, 50, 60);
  };
  const img6= new Image();
  img6.src = './img.png';
  img6.onload = () => {
    view.drawImage(img, 540, buttonY, 50, 60);
  };
  const img7 = new Image();
  img7.src = './img.png';
  img7.onload = () => {
    view.drawImage(img, 600, buttonY, 50, 60);
  };
  const img8 = new Image();
  img8.src = './img.png';
  img8.onload = () => {
    view.drawImage(img, 660, buttonY, 50, 60);
  };

  view.fillStyle = 'red';
  view.fillRect(buttonX, buttonY, buttonW, buttonH);
  layout.addEventListener('click', function(event) {
    // Control that click event occurred within position of button
    // NOTE: This assumes canvas is positioned at top left corner
    alert(event.x + " " + event.y);
    if (event.x > buttonX + widthScrenn && event.x < buttonX + buttonW + widthScrenn && event.y > buttonY + heightScreen && event.y < buttonY + buttonH + heightScreen) {
      // Executes if button was clicked!&&event.y > buttonY &&event.y < buttonY + buttonH
      alert('Button was clicked!');
    } else {
      //alert('Button was clicked!r');

    }
  });
*/
}


function putCard(){

}

function cartas(){
  //accerder a la peticion para retornar los datos de la carta,visualizarlos y asignacion de collection_card
    var carta=new Array();
    carta[0]="1bastos";
    carta[1]="4espada";
    carta[2]="4oro";
    carta[3]="5copas";
    carta[4]="10oro";
    carta[5]="11bastos";
    carta[6]="11copas";
    carta[7]="11oro";
    return carta;
}
