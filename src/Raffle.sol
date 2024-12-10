// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

/**
 * @title A samplte Raffle contract
 * @notice This contract is for creating a sample raffle
 * @dev Implements Chainlink VRFv2.5
 * @dev Author: Zaid Takieddin
 */
contract Raffle {
    /** Errors */
    error Raffle__SendMoreToEnterRaffle();

    /** State Variables */
    uint256 private immutable i_entranceFee;
    address payable[] private s_players;

    /* Events */
    event RaffleEntered(address indexed player);

    constructor(uint256 entranceFee) {
        i_entranceFee = entranceFee;
    }

    function enterRaffle() public payable {
        // require(msg.value >= i_entranceFee, "Raffle__SendMoreToEnterRaffle"); - not gas efficient
        // require(msg.value >= i_entranceFee, Raffle__SendMoreToEnterRaffle()); - ^0.8.26 and require specific compiler version
        if (msg.value < i_entranceFee) {
            revert Raffle__SendMoreToEnterRaffle();
        }

        s_players.push(payable(msg.sender));

        emit RaffleEntered(msg.sender);
    }

    function pickWinner() public {}

    /** Getter Functions */
    function getEntranceFee() public view returns (uint256) {
        return i_entranceFee;
    }
}
