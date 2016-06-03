//initial player attribute
var players = [
  {"no": 1, "next": 1, "dice": 6, "removeDice": 0, "passDice": 0, "finished": false},
  {"no": 2, "next": 2, "dice": 6, "removeDice": 0, "passDice": 0, "finished": false},
  {"no": 3, "next": 3, "dice": 6, "removeDice": 0, "passDice": 0, "finished": false},
  {"no": 4, "next": 0, "dice": 6, "removeDice": 0, "passDice": 0, "finished": false}
];

var started = true;

function rollDice(index){
  dices = [];
  for(var i = 0; i < players[index].dice; i++) {
    dice = Math.floor(Math.random() * (6-1 +1))+1
    if(dice == 1) {
      players[index].passDice++;
    } else if(dice == 6) {
      players[index].removeDice++;
    }
    dices.push(dice);
  }
  console.log("player "+players[index].no+" : "+dices.join(','));
}

function checkDice() {
  for(var i = 0; i < players.length; i++) {
    if(players[i].removeDice > 0) {
      players[i].dice -= players[i].removeDice
    }
    if(players[i].passDice > 0) {
      passDice(i, players[i].next, players[i].passDice)
    }
    // reset
    players[i].passDice = 0
    players[i].removeDice = 0
    //add flag for finished player
    if(players[i].dice == 0) {
      players[i].finished = true
    }
    // if a player already finished, finish the game
    if(checkFinish() > 0) {
      started = false
    }
  }

}

function checkFinish() {
  return players.map(function(p) {
    if (p.finished == true) {
      return p;
    }
  }).filter(function(f) {
    if(f != undefined) {
      return f
    }
  }).length
}

function passDice(from, to, numOfDice) {
  if(players[from].dice > 0 && !players[to].finished) {
    players[from].dice -= numOfDice;
    players[to].dice += numOfDice;
  }
}

function game() {
  //each round roll player dice
  for(var i = 0; i < players.length; i++) {
    if(players[i].dice != 0) {
      rollDice(i);
    }
  }
  //after player rolled dice, check rule
  checkDice();
}

while(started) {
  //start the game
  game()
}
players.forEach(function(player) {
  status = player.finished ? "WIN" : "LOSE"
  console.log("Player "+player.no+":"+status)
})

