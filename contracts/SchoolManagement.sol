// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SchoolManagement {
    address public admin;
    
    struct Student {
        uint256 id;
        string name;
        bool isRegistered;
    }

    mapping(uint256 => Student) private students;
    uint256[] private studentIds;

    event StudentRegistered(uint256 id, string name);
    event StudentRemoved(uint256 id);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    constructor() {
        admin = msg.sender; // Set the deployer as the admin
    }

    // Register a new student
    function registerStudent(uint256 _id, string calldata _name) external onlyAdmin {
        require(!students[_id].isRegistered, "Student already registered");

        students[_id] = Student(_id, _name, true);
        studentIds.push(_id);

        emit StudentRegistered(_id, _name);
    }

    // Remove a student
    function removeStudent(uint256 _id) external onlyAdmin {
        require(students[_id].isRegistered, "Student not found");

        delete students[_id];

        // Remove from studentIds array
        for (uint256 i = 0; i < studentIds.length; i++) {
            if (studentIds[i] == _id) {
                studentIds[i] = studentIds[studentIds.length - 1];
                studentIds.pop();
                break;
            }
        }

        emit StudentRemoved(_id);
    }

    // Get student by ID
    function getStudent(uint256 _id) external view returns (string memory name, bool isRegistered) {
        require(students[_id].isRegistered, "Student not found");
        return (students[_id].name, students[_id].isRegistered);
    }

    // Get all registered students
    function getAllStudents() external view returns (uint256[] memory) {
        return studentIds;
    }
}
