# LearnToEarn Smart Contract

## Project Title
**LearnToEarn** - A decentralized platform for content creators and learners using ERC-20 tokens.

## Project Description
LearnToEarn is a decentralized platform built on Ethereum that allows content creators to monetize their courses by accepting payments in ERC-20 tokens. Learners can purchase courses, gaining access to educational content by transferring tokens to the content creator. The platform ensures content creators are rewarded directly through token transfers, and learners have access to the purchased content.

## Contract Address
0x4A73B844aFC4d479bfB51C278374BfF48B7693dF
Key Features
.ERC-20 Token Integration: The contract uses an ERC-20 token to facilitate course purchases, enabling easy integration with any ERC-20 token.
.Course Creation: Content creators can add courses to the platform with a title, description, and a price set in tokens.
.Course Purchase: Users can purchase courses by transferring the specified amount of tokens to the content creator.
.Access Control: After a successful purchase, users are granted access to the course, which is tracked in the contract.
.Content Creator Management: Only designated content creators (added by the owner) can create and manage courses.
.Owner Withdrawal: The contract owner can withdraw any tokens held in the contract balance.
.Transparent Transactions: Every transaction, such as course creation or purchase, triggers an event for transparency, making the operations traceable on the blockchain.

addContentCreator(address _creator);
removeContentCreator(address _creator);
addCourse(string memory title, string memory description, uint256 price);
purchaseCourse(uint256 courseId);
hasUserAccess(uint256 courseId);
withdraw(uint256 amount);

