# Department Petty Cash Management System

A web-based system to record, track, and manage petty cash transactions 
for the Department at Anand Institute of Higher Technology — replacing 
manual registers with a simple, auditable digital workflow.

## 📌 Overview
This project allows department staff/admins to log petty cash 
disbursements and receipts, monitor running balances, and generate 
reports for accountability and audit purposes.

## 🚀 Features
- Record cash inflows (fund allocation/reimbursement) and outflows (expenses)
- Track running balance in real time
- Categorize expenses (stationery, maintenance, misc.)
- Generate transaction history/reports
- User roles (e.g., Admin, Staff) for access control

## 🛠️ Tech Stack
- **Frontend:** Semantic HTML5, CSS3, JavaScript
- **Backend:** Java Spring Boot 3 (REST API)
- **Database:** MySQL 8.0 with Hibernate (ORM)
- **Tools:** Draw.io (diagrams/wireframes), Postman (API testing)

## 📋 Project Phases
- **Phase 1: Define** — Requirements gathering, tech stack selection, system design
- *(Add Phase 2, 3... as your project progresses)*

## ⚙️ Getting Started
### Prerequisites
- JDK 17+
- MySQL 8.0
- Maven

### Setup
```bash
git clone <your-repo-url>
📄 License
This project is developed as part of academic coursework at
Anand Institute of Higher Technology.
Want me to save this as an actual `README.md` file you can download, or add more sections like an ER diagram, API endpoints, or team member credits?
cd petty-cash-system
# configure application.properties with your DB credentials
mvn spring-boot:run
