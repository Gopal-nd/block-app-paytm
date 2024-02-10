// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DataLeasingContract {
    // Struct to represent a data lease agreement
    struct DataLease {
        address serviceAddress; // Address of the service leasing the data
        address userAddress;    // Address of the user leasing the data
        uint256 duration;       // Duration of the lease agreement in seconds
        uint256 startTime;      // Timestamp when the lease agreement starts
        bool active;            // Flag to indicate if the lease is active
    }

    // Mapping to store data lease agreements
    mapping(bytes32 => DataLease) public dataLeases;

    // Event to log data lease agreements
    event DataLeased(bytes32 indexed leaseId, address indexed serviceAddress, address indexed userAddress, uint256 duration, uint256 startTime);

    // Function to lease data to a service
    function leaseData(address _serviceAddress, uint256 _duration) external {
        require(_duration > 0, "Duration must be greater than zero");

        bytes32 leaseId = keccak256(abi.encodePacked(msg.sender, _serviceAddress, block.timestamp));

        // Make sure there's no active lease for the same service and user
        require(!dataLeases[leaseId].active, "Data lease already exists");

        // Create a new data lease agreement
        dataLeases[leaseId] = DataLease({
            serviceAddress: _serviceAddress,
            userAddress: msg.sender,
            duration: _duration,
            startTime: block.timestamp,
            active: true
        });

        emit DataLeased(leaseId, _serviceAddress, msg.sender, _duration, block.timestamp);
    }

    // Function to revoke a data lease agreement
    function revokeDataLease(bytes32 _leaseId) external {
        require(dataLeases[_leaseId].userAddress == msg.sender, "Only the user can revoke the lease");
        require(dataLeases[_leaseId].active, "Data lease is not active");

        // Deactivate the lease agreement
        dataLeases[_leaseId].active = false;
    }

    // Function to check if a data lease agreement is active
    function isLeaseActive(bytes32 _leaseId) external view returns (bool) {
        return dataLeases[_leaseId].active;
    }
}
