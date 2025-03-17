# Raffle Contract

This is a smart contract for a simple raffle system built on Ethereum using Chainlink VRF (Verifiable Random Function). The contract allows users to enter a raffle by paying an entrance fee, and at the end of a specified interval, a winner is chosen at random. Chainlink VRF is used to ensure the randomness of the winner selection process.

## Table of Contents

- [Contract Overview](#contract-overview)
- [Key Components](#key-components)
- [Installation](#installation)
- [Usage](#usage)
- [Makefile Commands](#makefile-commands)

## Contract Overview

This contract is designed for creating and managing a raffle system on the Ethereum blockchain. It incorporates Chainlink VRF v2.5 to ensure fair and verifiable randomness when picking a winner. The contract allows users to participate by paying an entrance fee and selects a winner after a set interval.

### Key Features

- **Entrance Fee**: Users must pay a specified fee to enter the raffle.
- **Raffle Interval**: The raffle occurs at fixed intervals.
- **Chainlink VRF**: Uses Chainlink VRF for secure, verifiable randomness.
- **Winner Selection**: The winner is chosen randomly from the pool of participants.
- **Subscription Model**: Uses Chainlink’s subscription model for VRF requests.
  
## Key Components

### 1. **State Variables**

- `i_entranceFee`: The entrance fee required to participate in the raffle.
- `i_interval`: The duration (in seconds) between raffle events.
- `i_keyHash`: The Chainlink gas lane key hash for VRF.
- `i_subscriptionId`: The Chainlink VRF subscription ID.
- `i_callbackGasLimit`: The gas limit for the callback function.
- `s_players`: A list of addresses of players who have entered the raffle.
- `s_lastTimeStamp`: The last timestamp when the raffle was conducted.
- `s_recentWinner`: The address of the most recent winner.
- `s_raffleState`: The state of the raffle (OPEN or CALCULATING).

### 2. **Events**

- `RaffleEntered`: Emitted when a user enters the raffle.
- `WinnerPicked`: Emitted when a winner is selected.
- `RequestedRaffleWinner`: Emitted when a request is made to Chainlink VRF to pick a winner.

### 3. **Functions**

- **enterRaffle()**: Allows users to enter the raffle by paying the required entrance fee.
- **checkUpkeep()**: Checks if conditions are met to proceed with selecting a winner (e.g., enough time has passed, contract has balance).
- **performUpkeep()**: Called by Chainlink VRF Coordinator to trigger the random number generation and winner selection.
- **fulfillRandomWords()**: This is the callback function called by Chainlink VRF to fulfill the random number request and select a winner.
- **Getter Functions**: Functions that allow external access to important contract data like the entrance fee, raffle state, players, and recent winner.

## Installation

To deploy and interact with the Raffle contract, you'll need to have Foundry and the necessary dependencies installed.

### Dependencies

- **Chainlink Contracts**: The contract imports the Chainlink VRF and related utilities.
- **Forge-Std**: A standard library for smart contract development with Foundry.
- **Solmate**: A library for ERC20 tokens and other smart contract utilities.

### Installation Steps

1. **Install Foundry**:
   ```bash
   curl -L https://foundry.paradigm.xyz | bash
   foundryup
## Install Dependencies

To install the required dependencies, run the following command:

```bash
make install
```

## Deploy the Contract

To deploy the contract, run the following command:

```bash
make deploy ARGS="--network sepolia"
```

## Usage

Once the contract is deployed, users can interact with it as follows:

### Enter the Raffle

To enter the raffle, users must call the `enterRaffle()` function and send the required entrance fee in ETH.

### Check if Raffle is Ready for Winner Selection

The contract automatically checks if it's time to pick a winner using the `checkUpkeep()` function, which is called periodically.

### Pick a Winner

Once the conditions are met, the `performUpkeep()` function will request a random number from Chainlink VRF. The winner is then chosen randomly, and the contract emits the `WinnerPicked` event and transfers the prize to the winner.

## Makefile Commands

The Makefile provides several commands for development and deployment:

- `make all`: Cleans, removes old modules, installs dependencies, and builds the project.
- `make clean`: Cleans the project.
- `make install`: Installs the required dependencies.
- `make update`: Updates dependencies.
- `make build`: Builds the contract.
- `make test`: Runs tests.
- `make deploy`: Deploys the contract to a specified network.
- `make snapshot`: Creates a snapshot of the current state.
- `make format`: Formats the code.
- `make anvil`: Starts a local blockchain for testing.

## Contributing

If you'd like to contribute to the project, feel free to fork the repository and submit a pull request with your changes. Make sure to run the tests before submitting.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
