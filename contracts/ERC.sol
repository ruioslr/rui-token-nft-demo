// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import './IERC20.sol';

contract ERC20 is IERC20 {
    string ercName;
    string ercSymbol;
    uint8 ercDecimal;
    uint256 ercTotalSupply;

    address public owner;

    mapping(address => uint256) ercBanlances;
    mapping(address => mapping(address => uint256)) ercApproved;

    constructor(string memory _name, string memory _symbol, uint8 _decimal) {
        ercName = _name;
        ercSymbol = _symbol;
        ercDecimal = _decimal;

        owner = msg.sender;
        // ercBanlances[owner] = 100000000;
    }

    function name() external view override returns (string memory) {
        return ercName;
    }

    function symbol() external view override returns (string memory) {
        return ercSymbol;
    }

    function decimals() external view override returns (uint8) {
        return ercDecimal;
    }

    function totalSupply() external view override returns (uint256) {
        return ercTotalSupply;
    }

    function balanceOf(
        address _owner
    ) external view override returns (uint256 balance) {
        return ercBanlances[_owner];
    }

    function transfer(
        address _to,
        uint256 _value
    ) external returns (bool success) {
        require(ercBanlances[msg.sender] >= _value, 'money not enough');
        require(_value > 0, 'value should more then zero');
        require(address(0) != _to, 'address not be zero address');

        ercBanlances[msg.sender] -= _value;
        ercBanlances[_to] += _value;

        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) external override returns (bool success) {
        require(ercBanlances[_from] >= _value, 'balance should enough');
        require(
            ercApproved[_from][msg.sender] >= _value,
            'approve balance should enough'
        );
        require(address(0) != _to, 'address not be zero');
        require(_value > 0, 'value should be than zero');

        ercBanlances[_from] -= _value;
        ercBanlances[_to] += _value;
        ercApproved[_from][msg.sender] -= _value;

        emit Transfer(_from, _to, _value);
        return true;
    }

    function approve(
        address _spender,
        uint256 _value
    ) external override returns (bool success) {
        // require(_value >0 , 'value should then 0');
        require(address(0) != _spender, 'address not be zore address');
        require(ercBanlances[msg.sender] >= _value, 'balance should be enough');

        ercApproved[msg.sender][_spender] = _value;

        emit Approval(msg.sender, _spender, _value);

        return true;
    }

    function allowance(
        address _owner,
        address _spender
    ) external view override returns (uint256 remaining) {
        remaining = ercApproved[_owner][_spender];
    }

    function mint(address _to, uint256 _value) public {
        require(msg.sender == owner, 'only owner can do');

        ercBanlances[_to] += _value;
        ercTotalSupply += _value;

        emit Transfer(address(0), _to, _value);
    }
}
