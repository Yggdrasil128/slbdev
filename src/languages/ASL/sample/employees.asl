import salaries

sort Employee
sort Name
sort Address

-- Constructor
function mkEmployee : Name x Address x Salary -> Employee?

-- Getters
function getEmployeeName : Employee -> Name
function getAddress : Employee -> Address
function getSalary : Employee -> Salary

-- Setters
function setEmployeeName : Employee x Name -> Employee
function setAddress : Employee x Address -> Employee
function setSalary : Employee x Salary -> Employee?

-- Invariant for employees
property employeeInvariant(e) : Employee .
  nonnegativeSalary(getSalary(e))

-- Property of the salary setter
property modifySalaryOnly(e0, s1) : Employee x Salary .
  nonnegativeSalary(s1) =>
    let e1 = setSalary e0 s1 in
         getEmployeeName(e0) = getEmployeeName(e1)
      /\ getAddress(e0) = getAddress(e1)
      /\ s1 = getAddress(e1)
