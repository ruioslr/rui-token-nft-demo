// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import '@openzeppelin/contracts/interfaces/IERC165.sol';

contract ERC165 is IERC165 {
    mapping(bytes4 => bool) supportedInterfaces;

    constructor() {
        supportedInterfaces[IERC165.supportsInterface.selector] = true;
    }

    function supportsInterface(
        bytes4 interfaceId
    ) external view override returns (bool) {
        return supportedInterfaces[interfaceId];
    }
}
