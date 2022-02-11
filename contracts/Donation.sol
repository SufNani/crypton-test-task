//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract Donations {
address payable public owner;

//Донатеры
address[] public donators;

//Сумма каждого донатеры

uint256 donationSum = 0;
//Т.к помечено паблик, то генерируется геттер
mapping (address => uint256) public donationSums;


constructor() {
//В конструкторе мы можем обращаться к транзе создания контракта. Там from (msg.sender) - это тот, кто деплоит
//Соответственно в переменную owner мы записываем создателя контракта
owner = payable(msg.sender);
}


//Валидатор того, что вызывающий метод контракта - владелец
modifier isOwner() {
require(msg.sender == owner, "You aren't contract owner");
_;
}

function withdrawDonations(address payable to) public isOwner payable {
//Чистим записи о донатах
for (uint256 i = 0; i < donators.length; i++) {
address donatorAddress = donators[i];
donationSums[donatorAddress] = 0;
}
//Так делается вывод средств из контракта
to.transfer(address(this).balance);
}

//Function to accept donation
function getDonation() public payable {
        if(msg.value > 10 ether) {
            donators.push(msg.sender);
        }
        donationSum+=msg.value;
    }

function showDonators() public view returns(address[] memory) {
return donators;
}

function showBalance() public view returns(uint256) {
return address(this).balance;
}
}
