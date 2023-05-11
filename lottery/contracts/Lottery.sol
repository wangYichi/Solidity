// SPDX-License-Identifier: MIT
pragma solidity ^0.4.17;

contract Lottery {
    address public manager;
    address[] public players;

    function Lottery() public {
        manager = msg.sender;
    }

    function Enter() public payable {
        require(msg.value > .01 ether);
        players.push(msg.sender);
    }

    function Random() private view CheckIsCreater returns (uint) {
        uint(keccak256(block.difficulty, now, players));
    }

    function PickWinner() public CheckIsCreater {
        require(msg.sender == manager);

        uint index = Random() % players.length;
        players[index].transfer(this.balance);
        players = new address[](0);
    }

    function GetPlayers() public view returns (address[]) {
        return players;
    }

    modifier CheckIsCreater() {
        require(msg.sender == manager);
        _;
    }
}
