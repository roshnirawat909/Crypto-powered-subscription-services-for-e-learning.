// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function transfer(address recipient, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract LearnToEarn {
    address public owner;
    IERC20 public token;
    
    mapping(address => uint256) public userBalances;
    mapping(address => bool) public contentCreators;
    mapping(address => mapping(uint256 => bool)) public userAccess; // mapping of user access to course
    
    struct Course {
        uint256 id;
        string title;
        string description;
        uint256 price; // price in tokens
        address creator;
    }
    
    uint256 public nextCourseId = 1;
    mapping(uint256 => Course) public courses;
    
    event CourseAdded(uint256 id, string title, string description, uint256 price, address creator);
    event CoursePurchased(address indexed user, uint256 courseId, uint256 price, uint256 timestamp);
    
    constructor(address _token) {
        owner = msg.sender;
        token = IERC20(_token);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }
    
    modifier onlyContentCreator() {
        require(contentCreators[msg.sender], "You are not a content creator");
        _;
    }
    
    modifier hasAccess(uint256 courseId) {
        require(userAccess[msg.sender][courseId], "You do not have access to this course");
        _;
    }

    // Add content creator
    function addContentCreator(address _creator) external onlyOwner {
        contentCreators[_creator] = true;
    }

    // Remove content creator
    function removeContentCreator(address _creator) external onlyOwner {
        contentCreators[_creator] = false;
    }
    
    // Add a new course
    function addCourse(string memory title, string memory description, uint256 price) external onlyContentCreator {
        uint256 courseId = nextCourseId++;
        courses[courseId] = Course(courseId, title, description, price, msg.sender);
        emit CourseAdded(courseId, title, description, price, msg.sender);
    }
    
    // User purchases a course
    function purchaseCourse(uint256 courseId) external {
        Course memory course = courses[courseId];
        require(course.id > 0, "Course not found");
        require(token.balanceOf(msg.sender) >= course.price, "Insufficient funds");
        
        token.transfer(course.creator, course.price); // Transfer tokens to content creator
        userAccess[msg.sender][courseId] = true; // Grant access to the user
        
        emit CoursePurchased(msg.sender, courseId, course.price, block.timestamp);
    }
    
    // Check if user has access to a course
    function hasUserAccess(uint256 courseId) external view returns (bool) {
        return userAccess[msg.sender][courseId];
    }
    
    // Withdraw tokens by owner
    function withdraw(uint256 amount) external onlyOwner {
        require(token.balanceOf(address(this)) >= amount, "Insufficient balance in contract");
        token.transfer(owner, amount);
    }
}
